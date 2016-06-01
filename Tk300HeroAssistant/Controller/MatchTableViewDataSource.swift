//
//  MatchTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import Kingfisher
extension MatchViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewDisplayWith("查询无结果", ifNecessaryForRowCount: matchBasicInfoArray.count)
        return matchBasicInfoArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MatchCellIdentifier) as! MatchBasicTableViewCell
        let item  = matchBasicInfoArray[indexPath.row]
        cell.setContent(item)
        cell.matchData = matchPlayerData[matchBasicInfoArray[indexPath.row].matchID]
        return cell
    }
}