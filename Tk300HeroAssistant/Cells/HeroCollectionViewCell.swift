//
//  HeroCollectionViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/20.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var heroImage: UIImageView!
    
    @IBOutlet weak var heroNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heroImage.layer.cornerRadius = 10
        heroImage.layer.masksToBounds = true
        //heroImage.layer.shouldRasterize = true
    }
    
    func setContent(hero:HeroData){
        heroNameLabel.text = hero.name
        heroImage.image = UIImage(named: "hero-" + hero.id! + hero.name!)
    }
}
