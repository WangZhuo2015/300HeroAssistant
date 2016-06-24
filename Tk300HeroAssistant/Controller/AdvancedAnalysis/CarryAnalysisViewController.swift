//
//  CarryAnalysisViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/18.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class CarryAnalysisViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var carryRateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let pageName = "CarryAnalysisViewController"
    let MatchCellIdentifier = "MatchCellIdentifier"
    var matchBasicInfoArray =  [List]()
    var matchBasicInfoDic = [Int:List]()
    var matchDetail = [Int:Match?]()
    var matchPlayerData = [Int:(Int,Int,Int)]()
    var carryBattleCount:(carry:Int,all:Int)?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        //Header
        userNameLabel.text = User.sharedUser.userName
        carryRateLabel.text = String(format: "%.3F", 100 * (Double(carryBattleCount!.0) / Double(carryBattleCount!.1))) + "%"
        
        
        //处理杀死助
        matchDetail.forEach { (id,match) in
            if matchPlayerData.indexForKey(id) == nil{
                var allRoles = [MatchRole]()
                if let data = match{
                    allRoles.appendContentsOf(data.loseSide)
                    allRoles.appendContentsOf(data.winSide)
                    let role = allRoles.filter{$0.roleName == User.sharedUser.userName}[0]
                    matchPlayerData[id] = (role.killCount,role.deathCount,role.assistCount)
                }
            }
        }
        matchBasicInfoArray = matchBasicInfoDic.map{$1}
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
