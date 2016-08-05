//
//  HeroStoryTableViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/7/18.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class HeroStoryTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    
    @IBOutlet weak var heroStoryLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heroImage.layer.cornerRadius = 10
        heroImage.layer.masksToBounds = true
        contentView.backgroundColor = ApplicationColorManager.AppMainBackgroundColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(heroID:String,name:String,story:String){
        //没图片总比崩溃了好
        heroImage.image = DataImageManager.getHeroImageBy(name: name)
        if heroImage.image == nil {
            print("不存在的图片\("hero-" + heroID + name)")
        }
        heroStoryLabel.text = story
        //containerView.backgroundColor = ApplicationColorManager.AppMainBackgroundColor
    }

}
