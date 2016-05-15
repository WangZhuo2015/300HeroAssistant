//
//  MainViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        userChange()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.userChange), name: userChangedNotification, object: nil)
        let login = UIBarButtonItem(title: "切换账号", style: .Plain , target: self, action: #selector(self.login(_:)))
        self.navigationItem.rightBarButtonItem = login
        self.navigationController?.navigationItem.rightBarButtonItem = login
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
    func login(sender:UIBarButtonItem){
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
            ServiceProxy.isIDvalid((usernameTextField?.text)!, complete: { (result, reason, error) in
                if result{
                    User.sharedUser.setUserName((usernameTextField?.text)!)
                    NSUserDefaults.standardUserDefaults().setObject(User.sharedUser.userName, forKey: "userName")
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userChangedNotification, object: nil))
                }
                else{
                    let alert = UIAlertController(title: "切换失败", message: reason, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "好的", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
            
        }
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func userChange(){
        self.navigationItem.title = User.sharedUser.userName
    }
}
