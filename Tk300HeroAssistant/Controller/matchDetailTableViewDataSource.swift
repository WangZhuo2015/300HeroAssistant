//
//  matchDetailTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import SnapKit
extension MatchDetailViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (matchData?.winSide.count) ?? 0
        case 1:
            return (matchData?.loseSide.count) ?? 0
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MatchHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 28))
        switch section {
        case 0:
            view.setContent(
                section, kill: matchData?.winSideKill,
                assistant: matchData?.winSideAssistant,
                death: matchData?.winSideDeath,
                money: matchData?.winSideMoney)
        case 1:
            view.setContent(
                section, kill: matchData?.loseSideKill,
                assistant: matchData?.loseSideAssistant,
                death: matchData?.loseSideDeath,money:
                matchData?.loseSideMoney)
        default:
            view.setContent(section, kill: 0, assistant: 0, death: 0, money: 0)
        }
        return view
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(matchDetailCellIdentifier) as! matchDetailTableViewCell
        switch indexPath.section {
        case 0:
            cell.setRoleCell((matchData?.winSide[indexPath.row])!)
        case 1:
            cell.setRoleCell((matchData?.loseSide[indexPath.row])!)
        default:break
        }
        if indexPath == myScorePosition{
            cell.playerNameLabel.shadowColor = UIColor.grayColor()
            cell.playerNameLabel.shadowOffset = CGSize(width: 1,height: 1)
            cell.playerNameLabel.font = UIFont(name: "PingFangSC-Semibold", size: 22)
            let content = NSMutableAttributedString(string:  User.sharedUser.userName!)
            let contentRange = NSRange(location: 0,length: content.length)
            content.addAttribute(NSUnderlineStyleAttributeName, value:NSUnderlineStyle.StyleSingle.rawValue, range: contentRange)
            cell.playerNameLabel.attributedText = content;
        }
        return cell
    }
}
