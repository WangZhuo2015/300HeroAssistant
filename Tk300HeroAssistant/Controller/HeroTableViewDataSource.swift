//
//  HeroTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension DataViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewDisplayWith("数据加载ing...", ifNecessaryForRowCount: 0)
        return heroDataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HeroDataCellIdentifier) as! HeroTableViewCell
        cell.heroLabel.text = heroDataArray[indexPath.row].name
        cell.locateLabel.text = heroDataArray[indexPath.row].locate
        return cell
    }
}
