//
//  HeroWinRateViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class HeroWinRateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data: [HeroWinRate]?
    //var matchData: [Match]
    let pageName = "HeroWinRateViewController"
    let HeroWinRateCellIdentifier = "HeroWinRateCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewController = segue.destinationViewController as! HeroBattleListViewController
        viewController.hero = data![tableView.indexPathForSelectedRow!.row].hero
    }

}
