//
//  FriendAnalysisDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/11.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension FriendAnalysisViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.friendAnalysisCellIdentifier) ?? FriendAnalysisTableViewCell()
        cell.playerNameLabel.text = data![indexPath.row].0.playerName
        cell.playCountLabel.text = "\(data![indexPath.row].1)"
        
        return cell
    }
}