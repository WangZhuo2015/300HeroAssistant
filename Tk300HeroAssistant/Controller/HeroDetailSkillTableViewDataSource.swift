//
//  HeroDetailSkillTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/18.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension HeroDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewDisplayWith("数据加载ing...", ifNecessaryForRowCount: 0)
        switch functionSegmentedControl.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return skillArray?.count ?? 0
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch functionSegmentedControl.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.heroStoryTableViewCellIdentitier) ?? HeroStoryTableViewCell()
            cell.setContent((hero?.id)!, name: (hero?.name)!, story: (hero?.背景)!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.skillCellIdentifier) ?? SkillInfoTableViewCell()
            cell.setContent((hero?.id)!,data: skillArray![indexPath.row])
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.skillCellIdentifier) ?? SkillInfoTableViewCell()
            cell.setContent((hero?.id)!,data: skillArray![indexPath.row])
            return cell
            
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.skillCellIdentifier) ?? SkillInfoTableViewCell()
            cell.setContent((hero?.id)!,data: skillArray![indexPath.row])
            return cell
        }
    }
    
    
}