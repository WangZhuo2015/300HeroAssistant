//
//  TableViewExtension.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension UITableView{
    func tableViewDisplayWith(message:String, ifNecessaryForRowCount rowCount:Int){
        if rowCount == 0{
            // Display a message when the table is empty
            // 没有数据的时候，UILabel的显示样式
            let messageLabel = UILabel()
            messageLabel.text = message
            messageLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
            messageLabel.textColor = UIColor.lightGrayColor()
            messageLabel.textAlignment = .Center
            messageLabel.sizeToFit()
            self.backgroundView = messageLabel
            self.separatorStyle = .None
        }else {
            self.backgroundView = nil
        }
    }
    func tableViewDisplayWithView(view:UIView, ifNecessaryForRowCount rowCount:Int){
        if rowCount == 0{
            // Display a message when the table is empty
            // 没有数据的时候，UILabel的显示样式
            self.backgroundView = view
            self.separatorStyle = .None
        }else {
            self.backgroundView = nil
        }
    }
}