//
//  PersonalInfoTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/13.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension PersonalInfoViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewDisplayWith("Rank榜单无结果", ifNecessaryForRowCount: rank.count)
        return rank.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PersonalRankCellIdentifier) as! PersonalRankTableViewCell
        cell.setCellContent(rank[indexPath.row])
        return cell
    }
}