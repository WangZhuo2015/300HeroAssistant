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
        return skillArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HeroDataCellIdentifier) as! HeroTableViewCell
        cell.setContent(skillArray[indexPath.row])
        return cell
    }
}