//
//  HeroBattleListDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/18.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension HeroBattleListViewController: UITableViewDataSource,UITableViewDelegate{
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Match", bundle: nil)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("MatchDetailViewController")as! MatchDetailViewController
        let matchID = matchBasicInfoArray[indexPath.row].matchID
        viewController.matchData = matchDetail[matchID]!
        viewController.matchID = matchID
        navigationController?.pushViewController(viewController, animated: true)
    }
}