//
//  PersonalInfoViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    @IBOutlet weak var roleNameLabel: UILabel!
    
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
        let login = UIBarButtonItem(title: "切换账号", style: .Plain , target: self, action: #selector(PersonalInfoViewController.login(_:)))
        self.navigationItem.rightBarButtonItem = login
        self.navigationController?.navigationItem.rightBarButtonItem = login
        tableView.dataSource = self
        tableView.delegate = self
        loadPlayerBasicInfoWithName("古手梨花さん")
        // Do any additional setup after loading the view.
    }
    
    func loadPlayerBasicInfoWithName(name:String){
        ServiceProxy.getPlayerBasicInfo(name) { (playerInfo, error) in
            self.rank = (playerInfo?.rank)!
            self.role = playerInfo?.role
        }
    }

    
    func setRoleContent(role:Role){
        roleNameLabel.text = role.roleName
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
    
    func login(sender:UIBarButtonItem){
        let alert = UIAlertController(title: "登录/切换账号", message: "请输入您的游戏ID", preferredStyle: .Alert)
        var usernameTextField: UITextField?
        
        let loginAction = UIAlertAction(
        title: "登录", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            
            if let username = usernameTextField?.text {
                print(" Username = \(username)")
            } else {
                print("No Username entered")
            }
        }
        // 4.
        alert.addTextFieldWithConfigurationHandler {
            (txtUsername) -> Void in
            usernameTextField = txtUsername
            usernameTextField!.placeholder = "<Your username here>"
        }
        // 5.
        alert.addAction(loginAction)
        self.presentViewController(alert, animated: true, completion: nil)
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
