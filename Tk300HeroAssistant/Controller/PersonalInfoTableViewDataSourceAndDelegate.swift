//
//  PersonalInfoTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/13.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import PKHUD
extension PersonalInfoViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewDisplayWith("Rank榜单无结果", ifNecessaryForRowCount: rank.count)
        return rank.count + 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(MenuTableViewCellIdentifier) as! MenuTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(MenuTableViewCellIdentifier) as! MenuTableViewCell
            cell.menuItemLabel.text = "反馈意见"
            return cell
        default:
            break
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(PersonalRankCellIdentifier) as! PersonalRankTableViewCell
        cell.setCellContent(rank[indexPath.row - 1])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0...1:
            return 57
        default:
            break
        }
        return 103
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            //内购取消
            //performSegueWithIdentifier(advancedAnalysisSegue, sender: nil)
            //内购添加
            if AppManager.haveBoughtIAP(){
                guard User.sharedUser.userName != nil else{
                    HUD.flash(.LabeledError(title: "数据获取失败", subtitle: "无用户"), delay: 1, completion: nil)
                    return
                }
                performSegueWithIdentifier(advancedAnalysisSegue, sender: nil)
            }else{
                let alert = UIAlertController(title: "高级功能包", message: "要购买高级功能包吗", preferredStyle: .Alert)
                let buyIAP = UIAlertAction(title: "购买", style: .Default) { (action) in
                    //dispatch_async(dispatch_get_main_queue()) {
                        //perform code
                        self.requestProducts(NSSet(array: ["AdvancedFunctionPackage"]))
                    //}
                }
                let restoreIAP = UIAlertAction(title: "恢复购买", style: .Default) { (action) in
                    //dispatch_async(dispatch_get_main_queue()) {
                        //perform code
                        self.restoreProducts("AdvancedFunctionPackage")
                    //}
                }
                let cancel = UIAlertAction(title: "取消", style: .Cancel,handler: nil)
                alert.addAction(buyIAP)
                alert.addAction(restoreIAP)
                alert.addAction(cancel)
                presentViewController(alert, animated: true, completion: nil)
            }
        case 1:
            let feedbackViewController = LCUserFeedbackViewController()
            feedbackViewController.navigationBarStyle = LCUserFeedbackNavigationBarStyleBlue
            feedbackViewController.contactHeaderHidden = true
            feedbackViewController.presented = true
            feedbackViewController.feedbackTitle = "用户反馈"
            let navigationController = UINavigationController(rootViewController: feedbackViewController)
            feedbackViewController.contact = AppManager.getUUID()
            presentViewController(navigationController, animated: true, completion: nil)
        default:
            break
        }
        
    }
}