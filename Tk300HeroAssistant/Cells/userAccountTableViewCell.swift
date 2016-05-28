//
//  userAccountTableViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/28.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class userAccountTableViewCell: UITableViewCell {
    @IBOutlet weak var innerView: UIView!

    @IBOutlet weak var userAccountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
