//
//  AccountChangeViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/28.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class AccountChangeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var currentUserLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let accountCellIdentifier = "accountCellIdentifier"
    let addNewAccountCellIdentifier = "addNewAccountCellIdentifier"
    
    var namesArray:[String] {
        get{
            return User.sharedUser.getNames()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        self.navigationItem.title = "账号切换"
        userChange()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: (#selector(PersonalInfoViewController.userChange)), name: userChangedNotification, object: nil)
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
    

    func userChange(){
        currentUserLabel.text = User.sharedUser.userName
    }
    func login(){
        let alert = UIAlertController(title: "登录/切换账号", message: "请输入您的游戏ID", preferredStyle: .Alert)
        var usernameTextField: UITextField?
        alert.addTextFieldWithConfigurationHandler {
            (txtUsername) -> Void in
            usernameTextField = txtUsername
            usernameTextField!.placeholder = "<Your username here>"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let loginAction = UIAlertAction(
        title: "登录", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            usernameTextField?.resignFirstResponder()
            User.login((usernameTextField?.text)!, successHandle: {
                self.tableView.reloadData()
                }, failHandle: { reason in
                    let alert = UIAlertController(title: "切换失败", message: reason, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "好的", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
            })
        }
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(namesArray.count)
        print(namesArray)
        return namesArray.count + 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(accountCellIdentifier) as!userAccountTableViewCell
        guard indexPath.row != namesArray.count else{
            cell.userAccountLabel.text = "add New Account"
            cell.innerView.backgroundColor = UIColor.greenColor()
            cell.editing = true
            return cell
        }
        cell.accessoryType = .None
        if namesArray[indexPath.row] == User.sharedUser.userName {
            cell.accessoryType = .Checkmark
        }
        cell.userAccountLabel.text = namesArray[indexPath.row]
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == namesArray.count{
            self.login()
        }else{
            //TODO : -重构
            User.login(namesArray[indexPath.row], successHandle: {
                tableView.reloadData()
                }, failHandle: { reason in
                    let alert = UIAlertController(title: "切换失败", message: reason ?? "", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "好的", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
            })
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //对于删除操作
        if editingStyle == .Delete{
            //在Model中删除数据
            User.deleteUserName(namesArray[indexPath.row])
            //更新视图
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
