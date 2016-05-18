//
//  HeroDataManager.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
import SwiftCSV
class CSVDataManager{
    
    class func loadHeroData(completionHandle:([HeroData])->Void) {
        loadDataFromCSV("hero data", completionHandle: completionHandle)
    }
    class func loadSkillData(completionHandle:([SkillData])->Void) {
        loadDataFromCSV("skill data", completionHandle: completionHandle)
    }
    
    
    
    
    
    
    
    
    
    /**
     CSV读取
     
     - parameter fileName:         文件名,路径必须为根目录
     - parameter completionHandle: completionHandle
     */
    class func loadDataFromCSV<T:NSObject>(fileName:String,completionHandle:([T])->Void){
        var dataArray = [T]()
        //异步读取
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let heroPath = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv")
            let csvURL = NSURL(fileURLWithPath: heroPath!)
            let csv = try! CSV(url: csvURL)
            for row in csv.rows{
                let data = T()
                for column in csv.columns {
                    data.setValue(row[column.0], forKey: column.0)
                }
                dataArray.append(data)
            }
            dispatch_async(dispatch_get_main_queue(), {
                completionHandle(dataArray)
            })
        })
    }
}