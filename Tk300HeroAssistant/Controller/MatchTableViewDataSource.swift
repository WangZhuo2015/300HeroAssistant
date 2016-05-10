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
        return matchBasicInfoArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MatchCellIdentifier) as! MatchBasicTableViewCell
        let item  = matchBasicInfoArray[indexPath.row]
        cell.matchImage.kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/"+item.hero.iconFile)!)
        cell.heroLevel.text = "\(item.heroLevel)"
        cell.heroName.text = item.hero.name
        //cell.matchDate.text = item.matchDate
        cell.matchResult.text = matchResToStr(item.result)
        cell.matchType.text = "竞技场"
    
        return cell
    }
    
    func matchResToStr(res:Int)->String?{
        switch res {
        case 1:
            return "胜利"
        case 2:
            return "失败"
        case 3:
            return "逃跑"
        default:
            return nil
        }
    }
}