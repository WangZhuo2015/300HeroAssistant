//
//  DataImageManager.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/8/5.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
class DataImageManager{
    static func getEquipmentImageBy(id id:Int)->UIImage?{
        return UIImage(named: "equipment\(id)")
    }
    static func getEquipmentImageBy(id id:String)->UIImage?{
        return UIImage(named: "equipment"+id)
    }
//    static func getHeroImageBy(id id:Int)->UIImage?{
//        //UIImage(named: "hero-" + hero.id! + hero.name!)
//        return UIImage(named: "equipment\(id)")
//    }
    
}