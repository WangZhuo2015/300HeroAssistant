//
//  PersonalInfoViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import StoreKit
class PersonalInfoViewController: UIViewController {

    //@IBOutlet weak var roleNameLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var roleLevelLabel: UILabel!
    
    @IBOutlet weak var winCountLabel: UILabel!
    
    @IBOutlet weak var jumpLevelLabel: UILabel!
    
    @IBOutlet weak var allCountLabel: UILabel!
    
    @IBOutlet weak var updateTimeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBOutlet weak var winRateProgress: UIProgressView!
    
    @IBOutlet weak var changeAccountButton: UIBarButtonItem!
    let feedbackButton = UIBarButtonItem()
    let pageName = "PersonalInfoViewController"
    
    let advancedAnalysisSegue = "advancedAnalysisSegue"
    
    /// App内购
    
    let VERIFY_RECEIPT_URL = "https://buy.itunes.apple.com/verifyReceipt"
    let ITMS_SANDBOX_VERIFY_RECEIPT_URL = "https://sandbox.itunes.apple.com/verifyReceipt"
    var productDict:NSMutableDictionary!
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
        tableView.bounces = false
        tableView.dataSource = self
        tableView.delegate = self
        headerView.backgroundColor = ApplicationColorManager.SectionSeparatorColor
        userChange()
        //防止已有
        if feedbackButton.title == nil {
            feedbackButton.title = "用户反馈"
        }
        feedbackButton.target = self
        feedbackButton.action = #selector(PersonalInfoViewController.feedback)
        self.navigationItem.leftBarButtonItem = feedbackButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: (#selector(PersonalInfoViewController.userChange)), name: userChangedNotification, object: nil)
        loadPlayerBasicInfoWithName()
        
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
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
    
    
    deinit{
        SKPaymentQueue.defaultQueue().removeTransactionObserver(self)
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
    
    func feedback(){
        let feedbackViewController = LCUserFeedbackViewController()
        feedbackViewController.navigationBarStyle = LCUserFeedbackNavigationBarStyleBlue
        feedbackViewController.contactHeaderHidden = true
        feedbackViewController.presented = true
        feedbackViewController.feedbackTitle = "用户反馈"
        let navigationController = UINavigationController(rootViewController: feedbackViewController)
        feedbackViewController.contact = AppManager.getUUID()
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func recieveNewMessage(){
//        let animation = CABasicAnimation(keyPath: "opacity")
//        animation.fromValue = 1.0
//        
//        animation.toValue = 0.0
//        
//        animation.autoreverses = true
//        
//        animation.duration = 1
//        
//        animation.repeatCount = Float.infinity
//        
//        animation.removedOnCompletion = true
//        
//        animation.fillMode = kCAFillModeForwards
        feedbackButton.title = "新的回复"
        feedbackButton.tintColor = UIColor ( red: 1.0, green: 0.4039, blue: 0.4957, alpha: 1.0 )
    }
    func removeNewMessage(){
        feedbackButton.title = "用户反馈"
        feedbackButton.tintColor = UIColor.whiteColor()
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
