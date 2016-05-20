//
//  HeroDataManager.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
class CSVDataManager{
    
    class func loadHeroData(completionHandle:([HeroData])->Void) {
        CSVReader.loadDataFromCSV("hero data", completionHandle: completionHandle)
    }
    class func loadSkillData(completionHandle:([SkillData])->Void) {
        CSVReader.loadDataFromCSV("skill data", completionHandle: completionHandle)
    }
    
    class func loadEquipData(completionHandle:([SkillData])->Void) {
        CSVReader.loadDataFromCSV("equip data", completionHandle: completionHandle)
    }
    
    
    
    
    
    
    

}