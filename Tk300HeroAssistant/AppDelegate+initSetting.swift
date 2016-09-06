//
//  AppDelegate+initSetting.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/7/17.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
import Fabric
import Crashlytics
extension AppDelegate{
    func initSetting(launchOptions: [NSObject: AnyObject]?) {
        //注册推送
        AVOSCloud.registerForRemoteNotification()
        //开启崩溃报告收集
        Fabric.with([Crashlytics.self])
        //AVOSCloudCrashReporting.enable()
        //注册ID
        AVOSCloud.setApplicationId("#{Your AppID}", clientKey: "#{Your AppKey}")
        AVAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        //记录UDID
        if AppManager.getUUID() == nil{
            let UUIDRef = CFUUIDCreate(kCFAllocatorDefault)
            let UUID = String(CFUUIDCreateString(kCFAllocatorDefault, UUIDRef))
            AppManager.setUUID(UUID)
        }
        //设置用户名
        if let name = NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String{
            User.sharedUser.setUserName(name)
        }
        //
        MKStoreKit.sharedKit().startProductRequest()

//        NSNotificationCenter.defaultCenter().addObserverForName(kMKStoreKitProductsAvailableNotification,
//                                                                object: nil, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
//                                                                    print(MKStoreKit.sharedKit().availableProducts)
//        }
//        
//        NSNotificationCenter.defaultCenter().addObserverForName(kMKStoreKitProductPurchasedNotification,
//                                                                object: nil, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
//                                                                    print ("Purchased product: \(note.object)")
//        }
    }
    
    
    
    
    
    
    
    
    func setApplicationApperance(){
        //导航栏颜色
        UINavigationBar.appearance().barTintColor = UIColor(red: 9.2/255, green: 52.5/255, blue: 73.6/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0 )
        if let barFont = UIFont(name: "PingFangSC-Regular", size: 22.0) {
            UINavigationBar.appearance().titleTextAttributes =
                [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:barFont]
        }
        
        UITabBar.appearance().barTintColor = UIColor(red: 9.2/255, green: 52.5/255, blue: 73.6/255, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0 )
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        //状态栏渲染颜色
        //plist修改
        //UIApplication.sharedApplication().statusBarStyle = .LightContent
        //TabBar渲染颜色
    }
}