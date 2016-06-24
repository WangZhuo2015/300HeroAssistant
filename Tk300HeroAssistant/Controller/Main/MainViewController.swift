//
//  MainViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import StoreKit
class MainViewController: UITabBarController,SKStoreProductViewControllerDelegate {
    var timer: NSTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllViewController()
        if AppManager.appUseCountUp() > 5 && !AppManager.isEvaluated(){
            reviewThisApp()
        }
        if User.sharedUser.userName == nil{
            self.selectedIndex = (self.viewControllers?.count)! - 1
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0*30, target: self, selector: #selector(self.checkNewMessage), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //timer.fireDate = NSDate.distantFuture()
        timer?.fireDate = NSDate.distantPast()
        timer!.fire()
    }
    
    deinit{
        timer?.invalidate()
        timer = nil
    }
    
    func loadAllViewController(){
        //获取每个故事版的根视图控制器
        let matchRootViewController = UIStoryboard(name: "Match", bundle: nil).instantiateInitialViewController() as! UINavigationController
        
        let heroRootViewController = UIStoryboard(name: "Hero", bundle: nil).instantiateInitialViewController() as! UINavigationController
        
        let equipmentRootViewController = UIStoryboard(name: "Equipment", bundle: nil).instantiateInitialViewController() as! UINavigationController
        
        let personalInfoRootViewController = UIStoryboard(name: "PersonalInfo", bundle: nil).instantiateInitialViewController() as! UINavigationController
        //设置tabbar被选中时的字体颜色
        let selectedText = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        matchRootViewController.tabBarItem.setTitleTextAttributes(selectedText, forState: UIControlState.Selected)
        heroRootViewController.tabBarItem.setTitleTextAttributes(selectedText, forState: UIControlState.Selected)
        equipmentRootViewController.tabBarItem.setTitleTextAttributes(selectedText, forState: UIControlState.Selected)
        personalInfoRootViewController.tabBarItem.setTitleTextAttributes(selectedText, forState: UIControlState.Selected)
        
        //        设置 tabBarItem的一些属性
        //1
        
        matchRootViewController.tabBarItem.title = "战绩"
        matchRootViewController.tabBarItem.image = UIImage(named: "magical_scroll")
        matchRootViewController.tabBarItem.selectedImage = UIImage(named: "magical_scroll_filled")
        
        //2
        personalInfoRootViewController.tabBarItem.title = "个人"
        personalInfoRootViewController.tabBarItem.image = UIImage(named: "user_male_circle")
        personalInfoRootViewController.tabBarItem.selectedImage = UIImage(named: "user_male_circle_filled")
        
        //4
        heroRootViewController.tabBarItem.title = "英雄"
        heroRootViewController.tabBarItem.image = UIImage(named: "armored_helmet")
        heroRootViewController.tabBarItem.selectedImage = UIImage(named: "armored_helmet_filled")
        
        
        equipmentRootViewController.tabBarItem.title = "装备"
        equipmentRootViewController.tabBarItem.image = UIImage(named: "armored_boot")
        equipmentRootViewController.tabBarItem.selectedImage = UIImage(named: "armored_boot_filled")

        self.viewControllers = [
            matchRootViewController,
            heroRootViewController,
            equipmentRootViewController,
            personalInfoRootViewController
        ]
        
        self.selectedIndex = 0
    }

    
    
    func reviewThisApp(){
        let alert = UIAlertController(title: "快来评价吧ヽ(･ω･｡)ﾉ", message: "喜欢这款App吗?来评价一下吧!", preferredStyle: .Alert)
        let goToEvaluate = UIAlertAction(title: "去评价*~(￣▽￣)~*", style: .Default) { (action) in
            self.evaluate()
        }
        let refuse = UIAlertAction(title: "残忍地拒绝( •̥́ ˍ •̀)", style: .Default) { (action) in
            AppManager.evaluated()
        }
        let cancel = UIAlertAction(title: "以后再说", style: .Cancel,handler: nil)
        alert.addAction(goToEvaluate)
        alert.addAction(refuse)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
    }
    

    
    func evaluate(){
        //初始化控制器
        let storeProductViewContorller = SKStoreProductViewController()
        //设置代理请求为当前控制器本身
        storeProductViewContorller.delegate = self
        //加载一个新的视图展示
        storeProductViewContorller.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier:"1114391519"]) { (result,error) in
            if error != nil{
                print(error)
            }else{
                //模态弹出appstore
                self.presentViewController(storeProductViewContorller, animated: true, completion: nil)
            }
        }
    }
    
    func checkNewMessage(){
        LCUserFeedbackAgent.sharedInstance().countUnreadFeedbackThreadsWithBlock { (number, error) in
            guard error != nil || number != 0 else{
                // 网络出错了，不设置红点
                ((self.viewControllers?.last as! UINavigationController).viewControllers.first as! PersonalInfoViewController).removeNewMessage()
                self.viewControllers?.last?.tabBarItem.badgeValue = nil
                return
            }
            self.viewControllers?.last?.tabBarItem.badgeValue = "\(number)"
            ((self.viewControllers?.last as! UINavigationController).viewControllers.first as! PersonalInfoViewController).recieveNewMessage()
        }
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        loadAllViewController()
        AppManager.evaluated()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
