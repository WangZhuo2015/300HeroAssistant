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
    }
    static func isEvaluated()->Bool{
        return NSUserDefaults.standardUserDefaults().boolForKey("haveEvaluated")
    }
    static func evaluated(){
        return NSUserDefaults.standardUserDefaults().setBool(true, forKey: "haveEvaluated")
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
}