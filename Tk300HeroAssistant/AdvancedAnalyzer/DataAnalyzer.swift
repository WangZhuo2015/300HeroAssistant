//
//  DataAnalyzer.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
class DataAnalyzer {
    //static let sharedInstance = DataAnalyzer()
    var userName = ""
    var battleDatailList = [Int:MatchDetail]()
    var battleList = [Int:List]()
    var alreadyLoadList = false{
        didSet{
            if alreadyLoadList == true{
                loadALlBattleDetail()
            }else{
                battleDatailList.removeAll()
            }
        }
    }
    init(name:String){
        userName = name
    }
    
    
    
    func loadAllData(){
        battleList.removeAll()
        loadListData()
    }
    
    func loadListData() {
        alreadyLoadList = false
        ServiceProxy.getBattleList(userName ?? "", index: battleList.count) { (MatchBasicAPIBase, error) in
            MatchBasicAPIBase?.list.forEach{self.battleList[$0.matchID] = $0}
            if MatchBasicAPIBase?.list.count != 0{self.loadListData()}
            else{ self.alreadyLoadList = true }
        }
    }
    
    func loadALlBattleDetail(){
        battleList.forEach {loadBattleData(id: $0.0)}
    }
    func loadBattleData(id id:Int) {
        ServiceProxy.getMatchDetail(id) { (MatchDetail, error) in
            guard error == nil else{return}
            self.battleDatailList[id] = MatchDetail
        }
        
        ServiceProxy.getBattleList(userName ?? "", index: battleList.count) { (MatchBasicAPIBase, error) in
            MatchBasicAPIBase?.list.forEach{self.battleList[$0.matchID] = $0}
            if MatchBasicAPIBase?.list.count != 0{self.loadListData()}
        }
    }
    //英雄胜率

    var heroBattle = [Hero:HeroWinRate]()
    func calculateHeroWinRate(data:[Int:List],compeltionHandle:([HeroWinRate])->Void){
        battleList.forEach { (item) in
            if heroBattle[item.1.hero] == nil{
                heroBattle[item.1.hero] = HeroWinRate(hero: item.1.hero, win: 0, lose: 0, count: 0)
            }
            heroBattle[item.1.hero]?.count += 1
            if item.1.result == 1{
                heroBattle[item.1.hero]?.win += 1
            }else if item.1.result == 2{
                heroBattle[item.1.hero]?.lose += 1
            }
        }
        let array = heroBattle.map{ return $0.1 }.sort{ $0.rate > $1.rate }
        compeltionHandle(array)
    }
    
    //开黑分析
    var friend = [Player:Int]()
    func analysisFriend(){
        battleDatailList.forEach { (item) in
            var side = [MatchRole]()
            if item.1.match.winSide.map({ (role) -> String in
                return role.roleName
            }).contains(userName){
                side.appendContentsOf(item.1.match.winSide)
            }else{
                side.appendContentsOf(item.1.match.loseSide)
            }
            side.map{Player($0)}.forEach({ (role) in
                if (friend[role] == nil){
                    friend[role] = 0
                }else{
                    friend[role]! += 1
                }
            })
        }
        
        
    }
    
    //carry率
}




struct Player:Hashable,Equatable {
    var playerID:Int
    var playerName:String
    init(_ data:MatchRole){
        playerID = data.roleID
        playerName = data.roleName
    }
    var hashValue: Int{
        return playerID
    }
}
func ==(lhs: Player, rhs: Player) -> Bool{
    return lhs.playerID == rhs.playerID && lhs.playerName == rhs.playerName
}


struct HeroWinRate {
    var hero:Hero
    var win:Int
    var lose:Int
    var count:Int
    var rate:Double{
        return Double(win)/Double(count)
    }
}