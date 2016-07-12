//
//  PlayerDetailViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/22.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    let pageName = "PlayerDetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        AVAnalytics.beginLogPageView(pageName)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        AVAnalytics.endLogPageView(pageName)
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
