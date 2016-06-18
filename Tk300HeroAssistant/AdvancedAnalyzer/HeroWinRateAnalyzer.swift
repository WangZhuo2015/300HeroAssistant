//
//  HeroWinRateAnalyzer.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/18.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
extension DataAnalyzer{
    func filterListWithHero(hero:String) ->[List]{
        return battleList.filter{$0.1.hero.name == hero}.map{$1}
    }
    func filterDetailWithID(ID:[Int]) -> [Int:Match]{
        var dic = [Int:Match]()
        battleDatailList.forEach { data in
            if ID.contains(data.0){
                dic[data.0] = data.1.match
            }
        }
        return dic
    }
}