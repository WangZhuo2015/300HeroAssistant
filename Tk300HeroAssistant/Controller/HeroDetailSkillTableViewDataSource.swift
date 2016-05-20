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
        return skillArray?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SkillCellIdentifier) as! SkillInfoTableViewCell
        cell.setContent((hero?.id)!,data: skillArray![indexPath.row])
        return cell
    }
}