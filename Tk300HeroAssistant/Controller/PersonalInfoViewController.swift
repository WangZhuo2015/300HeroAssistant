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
    
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBOutlet weak var winRateProgress: UIProgressView!
    
    @IBOutlet weak var changeAccountButton: UIBarButtonItem!
    //PersonalRankCell
    let PersonalRankCellIdentifier = "PersonalRankCellIdentifier"
    var rank = [Rank](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var role:Role?{
        didSet{
            setRoleContent(role)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        userChange()
        //let login = UIBarButtonItem(title: "切换账号", style: .Plain , target: self, action: #selector(self.login))
        //self.navigationItem.rightBarButtonItem = login
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: (#selector(PersonalInfoViewController.userChange)), name: userChangedNotification, object: nil)
        loadPlayerBasicInfoWithName()
        // Do any additional setup after loading the view.
    }
    func userChange(){
        guard User.sharedUser.userName != "" else{
            self.navigationItem.title = "个人信息"
            return
        }
        self.navigationItem.title = User.sharedUser.userName
        loadPlayerBasicInfoWithName()
    }
    
    func loadPlayerBasicInfoWithName(name:String = User.sharedUser.userName ?? ""){
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

    
    func setRoleContent(role:Role?){
        //roleNameLabel.text = role.roleName
        roleLevelLabel.text = "\(role?.roleLevel ?? 0)"
        winCountLabel.text = "\(role?.winCount ?? 0)"
        allCountLabel.text = "\(role?.matchCount ?? 0)"
        jumpLevelLabel.text = "\(role?.jumpValue ?? 0)"
        updateTimeLabel.text = role?.updateTime
        guard role != nil else{
            winRateLabel.text = "0"+"%"
            winRateProgress.progress = 0
            return
        }
        let winRate = Float( role!.winCount ) / Float( role!.matchCount )
        winRateLabel.text = "\(winRate*100)"+"%"
        winRateProgress.progress = winRate
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
