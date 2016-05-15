//
//  UITableViewNetErrorDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
class UITableViewNetErrorDataSource: NSObject,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}