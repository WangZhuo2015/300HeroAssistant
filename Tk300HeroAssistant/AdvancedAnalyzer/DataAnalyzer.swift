//
//  DataAnalyzer.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
class DataAnalyzer {
    //单例
    static let sharedInstance = DataAnalyzer()
    //delegate
    var delegate:DataAnalyzerDelegate?
    //用户名
    internal var userName = ""{
        didSet{
            loadAllData()
        }
    }
    //详情列表
    var battleDatailList = [Int:MatchDetail](){
        didSet{
            if battleDatailList.count == battleList.count{
                alreadyLoadDetail = true
            }
        }
    }
    //战绩列表
    var battleList = [Int:List]()
    //是否已经读取列表
    var alreadyLoadList = false{
        didSet{
            guard alreadyLoadList != oldValue else{return}
            if alreadyLoadList == true{
                delegate?.alreadyLoadList?()
                loadALlBattleDetail()
            }else{
                battleDatailList.removeAll()
            }
        }
    }
    var alreadyLoadDetail = false{
        didSet{
            guard alreadyLoadDetail != oldValue else{return}
            if alreadyLoadDetail == true{
                delegate?.alreadyLoadDetail?()
            }
        }
    }
    
    internal func loadAllData(){
        loadListData()
    }
    //加载对应name的数据
    private func loadListData() {
        alreadyLoadList = false
        alreadyLoadDetail = false
        ServiceProxy.getBattleList(userName ?? "", index: battleList.count) { (MatchBasicAPIBase, error) in
            guard error == nil else{
                self.delegate?.errorOccurpty?()
                return
            }
            MatchBasicAPIBase?.list.forEach{self.battleList[$0.matchID] = $0}
            if MatchBasicAPIBase?.list.count != 0{self.loadListData()}
            else{ self.alreadyLoadList = true }
        }
    }
    
    //获取每一场的详情
    private func loadALlBattleDetail(){
        print( "列表已读取\(battleList.count)条")
        battleList.forEach {loadBattleData(id: $0.0)}
        print( "详情已读取\(battleDatailList.count)条")
        //alreadyLoadDetail = true
    }
    /**
     获取战绩详情
     
     - parameter id: 比赛ID
     */
    private func loadBattleData(id id:Int) {
        ServiceProxy.getMatchDetail(id) { (MatchDetail, error) in
            error.debugDescription
            guard error == nil else{
                self.delegate?.errorOccurpty?()
                return
            }
            self.battleDatailList[id] = MatchDetail
        }
    }
    
    
    /**
     英雄胜率
     
     - parameter compeltionHandle: 回调函数
     */
    func calculateHeroWinRate(compeltionHandle:([HeroWinRate])->Void){
        var heroBattle = [Int:HeroWinRate]()
        battleList.forEach { (item) in
            if heroBattle[item.1.hero.iD] == nil{
                heroBattle[item.1.hero.iD] = HeroWinRate(hero: item.1.hero, win: 0, lose: 0, count: 0)
            }
            heroBattle[item.1.hero.iD]?.count += 1
            if item.1.result == 1{
                heroBattle[item.1.hero.iD]?.win += 1
            }else if item.1.result == 2{
                heroBattle[item.1.hero.iD]?.lose += 1
            }
        }
        let array = heroBattle.map{ return $0.1 }.sort{ $0.rate > $1.rate }
        compeltionHandle(array)
    }
    
    //开黑分析
    func analysisFriend(compeltionHandle:([(Player,Int)])->Void){
        var friend = [Player:Int]()
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
                    friend[role] = 1
                }else{
                    friend[role]! += 1
                }
            })
        }
        compeltionHandle(friend.map{($0.0,$0.1)}.sort{$0.1>$1.1}.filter{$0.0.playerName != userName })
    }
    
    //carry率
    
    func carryRateAnalysis(compeltionHandle:(match:[Int:Match],list:[Int:List],carry:Int,all:Int)->Void){
        //carry场数
        var carry = 0
        var carryMatch = [Int:Match]()
        var carryList = [Int:List]()
        battleDatailList.forEach { (item) in
            var side = [MatchRole]()
            if item.1.match.winSide.map({ (role) -> String in
                return role.roleName
            }).contains(userName){
                side.appendContentsOf(item.1.match.winSide)
            }else{
                side.appendContentsOf(item.1.match.loseSide)
            }
            side.sortInPlace{ $0.kDA > $1.kDA }
            
            if side[0].roleName == userName{
                carry += 1
                carryMatch[item.0] = item.1.match
            }
        }
        battleList.filter{carryMatch.keys.contains($0.0)}.forEach{carryList[$0.0] = $0.1}
        compeltionHandle(match: carryMatch,list: carryList,carry: carry,all: battleDatailList.count)
    }
}
@objc
protocol DataAnalyzerDelegate {
    optional func alreadyLoadDetail()
    optional func alreadyLoadList()
    optional func errorOccurpty()
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