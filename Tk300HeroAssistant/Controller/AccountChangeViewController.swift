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
    
    var canEditAccounts:Bool = false
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
    
    @IBAction func editAccountTableView(sender: UIBarButtonItem) {
        sender.title = canEditAccounts ? "完成":"编辑"
        canEditAccounts = !canEditAccounts
        self.tableView.setEditing(canEditAccounts, animated: canEditAccounts)
    }
    
    func login(){
        let alert = UIAlertController(title: "登录/切换账号", message: "请输入您的游戏ID", preferredStyle: .Alert)
        var usernameTextField: UITextField?
        alert.addTextFieldWithConfigurationHandler {
            (txtUsername) -> Void in
            usernameTextField = txtUsername
            usernameTextField!.placeholder = "在此输入账号"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let loginAction = UIAlertAction(
        title: "登录", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            usernameTextField?.resignFirstResponder()
            User.login((usernameTextField?.text)!, successHandle: {
                AppManager.reportLog("LoginSuccess", info: ["Account":(usernameTextField?.text)!])
                self.tableView.reloadData()
                }, failHandle: { reason in
                    let alert = UIAlertController(title: "切换失败", message: self.translateReason(reason), preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "好的", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    //
                    if let error = reason{
                        AppManager.reportLog("LoginError", info: ["Account":(usernameTextField?.text)!,"reason":error])
                        AppManager.buyCountPlusOne()
                    }
            })
        }
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewDisplayWith("无账号", ifNecessaryForRowCount: 1)
        return namesArray.count + 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.accountCellIdentifier) ?? userAccountTableViewCell()
        guard indexPath.row != namesArray.count else{
            cell.userAccountLabel.text = "添加新的账号"
            cell.innerView.backgroundColor = UIColor ( red: 0.3673, green: 0.8866, blue: 0.1082, alpha: 1.0 )
            return cell
        }
        cell.innerView.backgroundColor = UIColor(red: 6/255, green: 123/255, blue: 165/255, alpha: 1)
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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == namesArray.count {return false}
        return true
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
    
    func translateReason(reason:String?)->String?{
        guard reason != nil else{return nil}
        switch reason! {
        case "ParameterInvalid":
            return "用户名不合法"
        case"sql: no rows in result set":
            return "用户名不存在"
        default:
            return reason
        }
    }
}
