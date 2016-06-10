//
//  HeroWinRateTableViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class HeroWinRateTableViewCell: UITableViewCell {
    @IBOutlet weak var heroImage: UIImageView!

    @IBOutlet weak var heroName: UILabel!
    
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBOutlet weak var winCountLabel: UILabel!
    
    @IBOutlet weak var allCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setContent(data:HeroWinRate){
        heroImage.kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/"+data.hero.iconFile)!)
        heroName.text = data.hero.name
        allCountLabel.text = "\(data.count)"
        winCountLabel.text = "\(data.win)"
        winRateLabel.text = String(format: "%.3F%", 100*Double(data.win)/Double(data.count)) + "%"
    }

}
