//
//  CollectionViewExtension.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/20.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension UICollectionView{
    func collectionViewDisplayWith(message:String, ifNecessaryForRowCount rowCount:Int){
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
        }else {
            self.backgroundView = nil
        }
    }
}