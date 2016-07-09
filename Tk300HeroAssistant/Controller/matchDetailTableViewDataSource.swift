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
        view.setContent(section, kill: 0, assistant: 0, dead: 0, money: 0)
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
        return cell
    }
}
