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
        initSetting(launchOptions)
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
    

}

