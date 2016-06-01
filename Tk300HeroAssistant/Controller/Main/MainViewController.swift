//
//  MainViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllViewController()
        if User.sharedUser.userName == nil{
            self.selectedIndex = (self.viewControllers?.count)! - 1
        }
        // Do any additional setup after loading the view.
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
