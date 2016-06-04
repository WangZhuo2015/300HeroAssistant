//
//  HeroDataManager.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
class CSVDataManager{
    static let sharedInstance = CSVDataManager()
    var heroDataArray:[HeroData]?
    var skillDataArray:[SkillData]?
    var equipmentDataArray:[EquipmentData]?
    
    func loadHeroData(completionHandle:([HeroData])->Void) {
        if let data = heroDataArray{
            completionHandle(data)
        }else{
            CSVReader.loadDataFromCSV("hero data", completionHandle: { (data:[HeroData]) in
                self.heroDataArray =  data
                completionHandle(data)
            })
        }
    }
    
    func loadSkillData(completionHandle:([SkillData])->Void) {
        if let data = skillDataArray{
            completionHandle(data)
        }else{
            CSVReader.loadDataFromCSV("skill data", completionHandle: { (data:[SkillData]) in
                self.skillDataArray =  data
                completionHandle(data)
            })
        }
    }
    
    class func loadEquipData(completionHandle:([EquipmentData])->Void) {
        
    }
    
    
    
    
    
    
    

}