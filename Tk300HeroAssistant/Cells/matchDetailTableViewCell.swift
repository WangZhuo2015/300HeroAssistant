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
    
    @IBOutlet weak var eloLabel: UILabel!
    
    @IBOutlet weak var kdaLabel: UILabel!
    
    @IBOutlet weak var winCountLabel: UILabel!
    
    @IBOutlet weak var allMatchCountLabel: UILabel!
    
    @IBOutlet var equipImages: [UIImageView]!
    
    @IBOutlet var skillImages: [UIImageView]!
    
    @IBOutlet weak var winOrLoseImage: UIImageView!
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var playerInnerView: UIView!
    
    
    
    
    
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
        
        if role.result == 1{
            winOrLoseImage.image = UIImage(named: "win")
        }else{
            winOrLoseImage.image = UIImage(named: "lose")
        }
        playerImage.kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/"+role.hero.iconFile)!)
        //防止空格
        role.equip = role.equip.filter { (item) -> Bool in
            item.iconFile != ""
        }
        
        for count in 0..<role.equip.count {
            equipImages[count].kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/" + role.equip[count].iconFile)!)
            print(role.equip[count].iconFile)
        }
        //防止复用Bug
        for count in role.equip.count..<equipImages.count {
            equipImages[count].image = nil
        }
        
        for count in 0..<role.skill.count {
            skillImages[count].kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/"+role.skill[count].iconFile)!)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.layer.cornerRadius = 10
        //playerInnerView.layer.cornerRadius = innerView.layer.cornerRadius
        playerImage.layer.cornerRadius = playerImage.bounds.width/2
        self.innerView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
