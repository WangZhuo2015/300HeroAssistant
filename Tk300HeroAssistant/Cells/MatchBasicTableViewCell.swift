//
//  MatchBasicTableViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class MatchBasicTableViewCell: UITableViewCell {
    @IBOutlet weak var matchType: UILabel!

    @IBOutlet weak var heroLevel: UILabel!
    
    @IBOutlet weak var matchResult: UILabel!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var matchImage: UIImageView!
    
    @IBOutlet weak var heroName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
