//
//  matchDetailTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import SnapKit
extension MatchDetailViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (matchData?.winSide.count) ?? 0
        case 1:
            return (matchData?.loseSide.count) ?? 0
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "    Winner"
        case 1:
            return "    Loser"
        default:
            return "    error"
        }
    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        //let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier()// UIView()//frame: CGRect(x: 0,y: 0,width: 300,height: 30))
//        let label = UILabel()
//        view.addSubview(label)
//        
//        view.backgroundColor = UIColor(red: 113, green: 135, blue: 255, alpha: 1)
//        view.tintColor = UIColor.whiteColor()
//        label.textColor = UIColor.whiteColor()
//        label.snp_makeConstraints { (make) in
//            make.center.equalTo(view.snp_center)
//        }
//        label.text = {
//            switch section {
//            case 0:
//                return "Winner"
//            case 1:
//                return "Loser"
//            default:
//                return "error"
//            }
//        }()
//        print(label.text)
//        return view
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(matchDetailCellIdentifier) as! matchDetailTableViewCell
        switch indexPath.section {
        case 0:
            cell.setRoleCell((matchData?.winSide[indexPath.row])!)
        case 1:
            cell.setRoleCell((matchData?.loseSide[indexPath.row])!)
        default:break
        }
        return cell
    }
}
