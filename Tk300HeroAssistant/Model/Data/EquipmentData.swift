//
//  EquipmentData.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/31.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
class EquipmentData: NSObject {
    var id: String?
    var name: String?
    var 售价: String?
    var 属性: String?
    var 装备技能: String?
    var 所需物品id:[String]?
    var 进阶物品id:[String]?
    
    init(json:EquipmentJSON){
        id = "\(json.id)"
        name = json.name
        售价 = Int(json.fullPrice) > Int(json.combineprice) ? json.fullPrice:json.combineprice
        属性 = json.pro.reduce("", combine: {$0!+"\n\($1)"})
        装备技能 = json.info
        if let sub = json.subItem{
            所需物品id = sub.map{"\($0)"}
        }else{
            所需物品id = []
        }
        if let combine = json.combineItem{
            进阶物品id = combine.map{"\($0)"}
        }else{
            进阶物品id = []
        }
        
    }
}

