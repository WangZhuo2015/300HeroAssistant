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
    private var heroDataArray:[HeroData]?
    private var skillDataArray:[SkillData]?
    private var equipmentDataArray:[EquipmentData]?{
        get{
            return equipmentDataDictionary?.values.map({$0}).sort({Int($0.0.售价!) < Int( $0.1.售价!)})
        }
    }
    private var equipmentDataDictionary:[String:EquipmentData]?
    
    internal func loadHeroData(completionHandle:([HeroData])->Void) {
        if let data = heroDataArray{
            completionHandle(data)
        }else{
            CSVReader.loadDataFromCSV("hero data", completionHandle: { (data:[HeroData]) in
                self.heroDataArray =  data
                completionHandle(data)
            })
        }
    }
    
    internal func loadSkillData(completionHandle:([SkillData])->Void) {
        if let data = skillDataArray{
            completionHandle(data)
        }else{
            CSVReader.loadDataFromCSV("skill data", completionHandle: { (data:[SkillData]) in
                self.skillDataArray =  data
                completionHandle(data)
            })
        }
    }
    
    internal func loadEquipData(completionHandle:([EquipmentData])->Void) {
        //CSVReader.loadDataFromCSV("object data", completionHandle: completionHandle)
        if equipmentDataDictionary != nil{
            completionHandle(equipmentDataArray!)
        }else{
            CSVDataManager.sharedInstance.loadEquipmentDataDictionary { (dic) in
                self.equipmentDataDictionary = dic
                completionHandle(dic.map{$0.1}.sort({Int($0.0.售价!) < Int( $0.1.售价!)}))
            }
        }
    }
    
    internal func getEquipmentInfoByID(id:String)->EquipmentData?{
        return equipmentDataDictionary![id]
    }
    
    
    
    private func loadEquipmentDataDictionary(completionHandle:([String:EquipmentData])->Void) {
        CSVReader.loadComplexDataFromCSV("object data", keyName: "id") { (objectDictionary: [String:EquipmentData]) in
            CSVReader.loadComplexDataFromCSV("合成所需", keyName: "id", orginalDictionary: objectDictionary, arrayAttributeName: ["所需物品id"], completionHandle: { (combineDictionary) in
                CSVReader.loadComplexDataFromCSV("进阶所需", keyName: "id", orginalDictionary: combineDictionary, arrayAttributeName: ["进阶物品id"], completionHandle: completionHandle)
            })
        }
    }
    
    
    
    
    
    
    

}