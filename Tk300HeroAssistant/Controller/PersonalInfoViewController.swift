//
//  PersonalInfoViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    //@IBOutlet weak var roleNameLabel: UILabel!
    
    @IBOutlet weak var roleLevelLabel: UILabel!
    
    @IBOutlet weak var winCountLabel: UILabel!
    
    @IBOutlet weak var jumpLevelLabel: UILabel!
    
    @IBOutlet weak var allCountLabel: UILabel!
    
    @IBOutlet weak var updateTimeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //PersonalRankCell
    let PersonalRankCellIdentifier = "PersonalRankCellIdentifier"
    var rank = [Rank](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var role:Role?{
        didSet{
            if let roleContent = role{
                setRoleContent(roleContent)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: (#selector(PersonalInfoViewController.userChange)), name: userChangedNotification, object: nil)
        loadPlayerBasicInfoWithName()
        // Do any additional setup after loading the view.
    }
    func userChange(){
        loadPlayerBasicInfoWithName()
    }
    
    func loadPlayerBasicInfoWithName(name:String = User.sharedUser.userName){
        ServiceProxy.getPlayerBasicInfo(name) { (playerInfo, error) in
            guard error == nil else{
                self.rank.removeAll()
                self.role = nil
                return
            }
            self.rank = (playerInfo?.rank)!
            self.role = playerInfo?.role
        }
    }

    
    func setRoleContent(role:Role){
        //roleNameLabel.text = role.roleName
        roleLevelLabel.text = "\(role.roleLevel)"
        winCountLabel.text = "\(role.winCount)"
        allCountLabel.text = "\(role.matchCount)"
        jumpLevelLabel.text = "\(role.jumpValue)"
        updateTimeLabel.text = role.updateTime
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
