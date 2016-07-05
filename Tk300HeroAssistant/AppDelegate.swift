//
//  AppDelegate.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //注册推送
        AVOSCloud.registerForRemoteNotification()
        //开启崩溃报告收集
        AVOSCloudCrashReporting.enable()
        //注册ID
        AVOSCloud.setApplicationId("McTRN6wWrpJ3h4JKIH6h4pKA-gzGzoHsz", clientKey: "RtFCOng84Rwka4w1S3uBIDo2")
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
        CSVDataManager.sharedInstance.loadEquipData{_ in }
        CSVDataManager.sharedInstance.loadHeroData{_ in }
        CSVDataManager.sharedInstance.loadSkillData{_ in }
        
        //外观相关设置
        setApplicationApperance()

        // Override point for customization after application launch.
        return true
    }
    
    //注册推送的Token
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        AVOSCloud.handleRemoteNotificationsWithDeviceToken(deviceToken)
    }
    
    //应用正在运行或者在后台
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        if application.applicationState == .Active {
            // 此处可以写上应用激活状态下接收到通知的处理代码，如无需处理可忽略
        } else {
            // The application was just brought from the background to the foreground,
            // so we consider the app as having been "opened by a push notification."
            AVAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
    }
    
    //运行的时候收到APS推送
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        if application.applicationState == .Active {
            // 此处可以写上应用激活状态下接收到通知的处理代码，如无需处理可忽略
        } else {
            // The application was just brought from the background to the foreground,
            // so we consider the app as having been "opened by a push notification."
            AVAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    //
    func applicationDidBecomeActive(application: UIApplication) {
        //清除Badge
        let number = application.applicationIconBadgeNumber
        if number != 0 {
            let currentInstallation = AVInstallation.currentInstallation()
            currentInstallation.badge = 0
            currentInstallation.saveEventually()
            application.applicationIconBadgeNumber = 0
        }
        application.cancelAllLocalNotifications()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        switch shortcutItem.type {
        case "-11.UITouchText.share":
            let items = ["hello 3D Touch"]
            let activityVC = UIActivityViewController(
                activityItems: items,
                applicationActivities: nil)
            self.window?.rootViewController?.presentViewController(activityVC, animated: true, completion: { () -> Void in
                
            })
        default:
            break
        }
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

