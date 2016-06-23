//
//  AdvancedAnalysisMainTableViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import PKHUD
class AdvancedAnalysisMainTableViewController: UITableViewController,DataAnalyzerDelegate {

    var dataAnalyzer = DataAnalyzer.sharedInstance
    let HeroWinRateSegue = "HeroWinRateSegue"
    let friendAnalysisSegue = "friendAnalysisSegue"
    let carryAnalysisSegue = "carryAnalysisSegue"
    
    var heroBattle: [HeroWinRate]?
    var friend:[(Player,Int)]?
    var carryMatch: [Int:Match]?
    var carryBattleCount:(carry:Int,all:Int)?
    var carryList: [Int:List]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        dataAnalyzer.userName = User.sharedUser.userName ?? ""
        dataAnalyzer.delegate = self
        guard User.sharedUser.userName != nil else{
            HUD.flash(.LabeledError(title: "数据获取失败", subtitle: "无用户"), delay: 0, completion: { (bool) in
                self.navigationController?.popViewControllerAnimated(true)
            })
            return
        }
        
        setHUD(titleLabelText: nil, subtitleLabelText: nil)
        PKHUD.sharedHUD.show()
    }
    func setHUD(titleLabelText titleLabelText:String?,subtitleLabelText:String?){
        let view = PKHUDProgressView()
        view.titleLabel.text = titleLabelText ?? "数据获取中"
        view.subtitleLabel.text = subtitleLabelText ?? "正在获取比赛列表"
        PKHUD.sharedHUD.contentView = view
    }
    
    
    //MARK: -DataAnalyzer Delegate Motheds
    func alreadyLoadList() {
        dataAnalyzer.calculateHeroWinRate { self.heroBattle = $0 }
        setHUD(titleLabelText: nil, subtitleLabelText: "正在获取比赛详情")
        tableView.reloadData()
    }
    func alreadyLoadDetail() {
        tableView.reloadData()
        dataAnalyzer.analysisFriend{
            self.friend = $0
            self.dataAnalyzer.carryRateAnalysis { (match, list, carry, all) in
                self.carryMatch = match
                self.carryList = list
                self.carryBattleCount = (carry,all)
                PKHUD.sharedHUD.hide(animated: true, completion: nil)
                HUD.flash(.Success, delay: 0)
            }
        }
        
    }
    func errorOccurpty() {
        HUD.flash(.LabeledError(title: "错误", subtitle: "网络异常"), delay: 0) { (animated) in
            self.navigationController?.popViewControllerAnimated(animated)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 2
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier ?? "" {
        case HeroWinRateSegue:
            let viewController = segue.destinationViewController as! HeroWinRateViewController
            viewController.data = self.heroBattle ?? []
        case friendAnalysisSegue:
            let viewController = segue.destinationViewController as! FriendAnalysisViewController
            viewController.data = self.friend ?? []
        case carryAnalysisSegue:
            let viewController = segue.destinationViewController as! CarryAnalysisViewController
            viewController.matchDetail = self.carryMatch!
            viewController.matchBasicInfoDic = carryList!
            viewController.carryBattleCount = self.carryBattleCount
        default:
            break
        }
        
    }

}
