//
//  HeroWinRateDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension HeroWinRateViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HeroWinRateCellIdentifier)as! HeroWinRateTableViewCell
        cell.setContent(data![indexPath.row])
        return cell
    }
}
