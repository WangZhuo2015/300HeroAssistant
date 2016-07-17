//
//  AdvancedAnalysisIAP.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/7/17.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import PKHUD
extension PersonalInfoViewController{
    func initIAP(){
        //购买成功
        NSNotificationCenter.defaultCenter().addObserverForName(kMKStoreKitProductPurchasedNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note) in
            AppManager.boughtIAP()
            AppManager.buyCountPlusOne()
            PKHUD.sharedHUD.hide()
            HUD.flash(.LabeledSuccess(title: "成功", subtitle: "购买成功"),delay: 1)
        }
        //购买失败
        NSNotificationCenter.defaultCenter().addObserverForName(kMKStoreKitProductPurchaseFailedNotification,object: nil, queue: NSOperationQueue()) { (note) in
            PKHUD.sharedHUD.hide()
            HUD.flash(.LabeledError(title: "错误", subtitle: "购买失败"),delay: 1)
        }
        //商品可用
        NSNotificationCenter.defaultCenter().addObserverForName(kMKStoreKitProductsAvailableNotification,object: nil, queue: NSOperationQueue()) { (note) in
            print(MKStoreKit.sharedKit().availableProducts)
        }
        //恢复成功
        NSNotificationCenter.defaultCenter().addObserverForName(kMKStoreKitRestoredPurchasesNotification,object: nil, queue: NSOperationQueue()) { (note) in
            AppManager.boughtIAP()
            PKHUD.sharedHUD.hide()
            HUD.flash(.LabeledSuccess(title: "成功", subtitle: "恢复成功"),delay: 1)
        }
        //恢复失败
        NSNotificationCenter.defaultCenter().addObserverForName(kMKStoreKitRestoringPurchasesFailedNotification,object: nil, queue: NSOperationQueue()) { (note) in
            PKHUD.sharedHUD.hide()
            HUD.flash(.LabeledError(title: "失败", subtitle: "恢复失败"),delay: 1)
        }
        

        
    }
}