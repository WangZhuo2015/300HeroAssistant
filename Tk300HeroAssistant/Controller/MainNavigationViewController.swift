//
//  MainNavigationViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/9.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    lazy var loginButton:UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = "切换用户"
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = loginButton
        
        // Do any additional setup after loading the view.
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
