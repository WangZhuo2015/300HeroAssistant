//
//  AdvancedAnalysisMenuTableViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemLabel: UILabel!
    
    @IBOutlet weak var itemBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
