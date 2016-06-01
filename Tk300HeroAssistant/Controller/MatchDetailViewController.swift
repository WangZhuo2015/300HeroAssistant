//
//  MatchDetailViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class MatchDetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var detailHeaderView: UIView!
    
    @IBOutlet weak var matchTypeLabel: UILabel!
    
    @IBOutlet weak var matchDateLabel: UILabel!
    
    @IBOutlet weak var matchDurationLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var matchScoreLabel: UILabel!
    
    var matchID = 0
    let matchDetailCellIdentifier = "matchDetailCellIdentifier"
    var matchData:Match?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        guard matchData != nil else{
            ServiceProxy.getMatchDetail(matchID) { (matchDetail, error) in
                self.matchData = (matchDetail?.match)
                self.setMatchInfo(self.matchData!)
                self.tableView.reloadData()
            }
            return
        }
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setMatchInfo(match:Match){
        matchTypeLabel.text = match.matchType == 1 ? "竞技场" : "战场"
        matchDateLabel.text = match.matchDate
        matchScoreLabel.text = "\(match.winSideKill) / \(match.loseSideKill)"
        matchDurationLabel.text = "\(match.usedTime % 60)分钟 \(match.usedTime/60)秒"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func sideSelect(sender: UISegmentedControl) {
        //TODO -:防止index越界
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0,inSection: sender.selectedSegmentIndex), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    
    
    
}
