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
    let HeroWinRateCellIdentifier = "HeroWinRateCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        print(data?.count)
        tableView.dataSource = self
        tableView.delegate = self
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
