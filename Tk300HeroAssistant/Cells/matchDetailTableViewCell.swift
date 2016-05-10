//
//  matchDetailTableViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import Kingfisher
class matchDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var killCountLabel: UILabel!
    
    @IBOutlet weak var assistCountLabel: UILabel!
    
    @IBOutlet weak var deathCountLabel: UILabel!
    
    @IBOutlet weak var destoryCountLabel: UILabel!
    
    @IBOutlet weak var soldierKillCountLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var equipImg1: UIImageView!
    
    @IBOutlet weak var equipImg2: UIImageView!
    
    @IBOutlet weak var equipImg3: UIImageView!
    
    @IBOutlet weak var equipImg4: UIImageView!
    
    @IBOutlet weak var equipImg5: UIImageView!
    
    @IBOutlet weak var equipImg6: UIImageView!
    
    @IBOutlet weak var skillImg1: UIImageView!
    
    @IBOutlet weak var skillImg2: UIImageView!
    
    @IBOutlet weak var eloLabel: UILabel!
    
    @IBOutlet weak var kdaLabel: UILabel!
    
    @IBOutlet weak var winCountLabel: UILabel!
    
    @IBOutlet weak var allMatchCountLabel: UILabel!
    
    @IBOutlet var equipImages: [UIImageView]!
    
    @IBOutlet var skillImages: [UIImageView]!
    
    func setRoleCell(role:MatchRole){
        playerNameLabel.text = role.roleName
        killCountLabel.text = "\(role.killCount)"
        deathCountLabel.text = "\(role.deathCount)"
        assistCountLabel.text = "\(role.assistCount)"
        destoryCountLabel.text = "\(role.towerDestroy)"
        soldierKillCountLabel.text = "\(role.killUnitCount)"
        moneyLabel.text = "\(role.totalMoney)"
        eloLabel.text = "\(role.eLO)"
        kdaLabel.text = "\(role.kDA)"
        winCountLabel.text = "\(role.winCount)"
        allMatchCountLabel.text = "\(role.matchCount)"
        
        playerImage.kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/"+role.hero.iconFile)!)
        for count in 0..<role.equip.count {
            equipImages[count].kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/"+role.equip[count].iconFile)!)
        }
        for count in 0..<role.skill.count {
            skillImages[count].kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/"+role.skill[count].iconFile)!)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
