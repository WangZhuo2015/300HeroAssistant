////
////  HeroTableViewCell.swift
////  Tk300HeroAssistant
////
////  Created by 王卓 on 16/5/15.
////  Copyright © 2016年 SherryTeam. All rights reserved.
////
//
//import UIKit
//
//class HeroTableViewCell: UITableViewCell {
//
//    @IBOutlet weak var heroLabel: UILabel!
//    
//    @IBOutlet weak var locateLabel: UILabel!
//    
//    @IBOutlet weak var heroImageView: UIImageView!
//    
//    @IBOutlet weak var attypeLabel: UILabel!
//    
//    @IBOutlet weak var innerView: UIView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        innerView.layer.cornerRadius = 5
//        innerView.layer.masksToBounds = true
//        // Initialization code
//    }
//
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
//    func setContent(hero:HeroData){
//        attypeLabel.text = hero.attype
//        locateLabel.text = hero.locate
//        heroLabel.text = hero.name
//        heroImageView.image = UIImage(named: "hero-" + hero.id! + hero.name!)
//    }
//
//}
