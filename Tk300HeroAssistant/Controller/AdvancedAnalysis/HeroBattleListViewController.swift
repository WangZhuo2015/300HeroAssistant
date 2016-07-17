//
//  HeroBattleListViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/18.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class HeroBattleListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hero:Hero?
    var matchBasicInfoArray =  [List]()
    var matchDetail = [Int:Match?]()
    var matchPlayerData = [Int:(Int,Int,Int)]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = hero?.name
        matchBasicInfoArray = DataAnalyzer.sharedInstance.filterListWithHero(hero!.name)
        matchDetail = DataAnalyzer.sharedInstance.filterDetailWithID(matchBasicInfoArray.map{$0.matchID})
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
