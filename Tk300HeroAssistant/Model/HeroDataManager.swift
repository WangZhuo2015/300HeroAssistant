//
//  HeroDataManager.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
import SwiftCSV
class HeroDataManager{
    class func loadHeroData(completionHandle:([HeroData])->Void) {
        var heroDataArray = [HeroData]()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let path = NSBundle.mainBundle().pathForResource("hero data", ofType: "csv")
            let csvURL = NSURL(fileURLWithPath: path!)
            let csv = try! CSV(url: csvURL)
            for row in csv.rows{
                let heroData = HeroData()
                for column in csv.columns {
                    heroData.setValue(row[column.0], forKey: column.0)
                }
                heroDataArray.append(heroData)
            }
            heroDataArray.sortInPlace({ (data1, data2) -> Bool in
                data1.locate < data2.locate
            })
            //需要长时间处理的代码
            dispatch_async(dispatch_get_main_queue(), {
                //需要主线程执行的代码
                completionHandle(heroDataArray)
            })
        })

    }
}