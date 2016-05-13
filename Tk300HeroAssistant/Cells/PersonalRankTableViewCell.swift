//
//  PersonalRankTableViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/13.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class PersonalRankTableViewCell: UITableViewCell {

    @IBOutlet weak var rankNameLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var valueChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellContent(rank:Rank){
        rankNameLabel.text = rank.rankName
        rankLabel.text = "\(rank.rank)"
        valueLabel.text = rank.value
        valueChangeLabel.text = "\(rank.rankChange)"
    }

}
