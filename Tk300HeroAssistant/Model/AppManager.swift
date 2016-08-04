//
//  AppManager.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/13.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
class AppManager {
    static func haveBoughtIAP()->Bool{
        return NSUserDefaults.standardUserDefaults().boolForKey("boughtIAP")
    }
    static func boughtIAP(){
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "boughtIAP")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    //统计内购购买次数
    static func buyCountPlusOne(){
        let post = AVObject.init(className: "IAPBoughtLog")
        post.setObject("true", forKey: "BoughtSuccessed")
        post.setObject(AppManager.getUUID(), forKey: "UUID")
        post.saveInBackground()
        //购买量计数
    }
    //是否评分
    static func isEvaluated()->Bool{
        return NSUserDefaults.standardUserDefaults().boolForKey("haveEvaluated")
    }
    
    static func evaluated(){
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "haveEvaluated")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func appUseCountUp()->Int{
        var count = NSUserDefaults.standardUserDefaults().integerForKey("useCount")
        count += 1
        NSUserDefaults.standardUserDefaults().setInteger(count, forKey: "useCount")
        print("App已使用\(count)次")
        return count
    }
    
    static func getUUID()->String?{
        return NSUserDefaults.standardUserDefaults().stringForKey("UUID")
    }
    
    static func setUUID(UUID:String){
        return NSUserDefaults.standardUserDefaults().setObject(UUID, forKey: "UUID")
    }
    
    static let AdvancedFunctionPackage = "AdvancedFunctionPackage"
    
    static func reportLog(table:String,info:[String:String]){
        let report = AVObject(className: table)
        for item in info{
            report.setObject(item.1, forKey: item.0)
        }
        report.saveInBackground()
        //记录错误
    }
}