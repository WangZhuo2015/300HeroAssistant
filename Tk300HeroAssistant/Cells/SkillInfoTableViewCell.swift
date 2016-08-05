//
//  SkillInfoTableViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/18.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class SkillInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var skillImage: UIImageView!
    
    @IBOutlet weak var skillNameLabel: UILabel!
    
    @IBOutlet weak var coolingTimeLabel: UILabel!
    
    @IBOutlet weak var skillMagicUseLabel: UILabel!
    
    @IBOutlet weak var skillKeyLabel: UILabel!
    
    @IBOutlet weak var skillInfoLabel: UILabel!
    
    @IBOutlet weak var magicTitleLabel: UILabel!
    
    @IBOutlet weak var coolingTitleLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = ApplicationColorManager.AppMainBackgroundColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setContent(heroID:String,data:SkillData){
        skillImage.layer.cornerRadius = 10
        skillImage.layer.masksToBounds = true
        //没图片总比崩溃了好
        let image = data.name?.stringByReplacingOccurrencesOfString("/",withString: "or")
        skillImage.image = UIImage(named: "hero-" + heroID + (image ?? ""))// + (data.id ?? ""))
        if skillImage.image == nil {
            print("不存在的图片\("hero-" + heroID + (data.name ?? "")))")
        }
        
        if data.快捷键 == "被动"{
            setLayout(true)
        }else{
            setLayout(false)
        }
        self.layoutIfNeeded()
        skillNameLabel.text = data.name
        coolingTimeLabel.text = data.冷却时间
        skillMagicUseLabel.text = data.技能消耗
        skillKeyLabel.text = "  \(data.快捷键!)  "
        skillInfoLabel.text = data.Information
    }
    
    func setLayout(hide:Bool){
        skillMagicUseLabel.hidden = hide
        coolingTimeLabel.hidden = hide
        magicTitleLabel.hidden = hide
        coolingTitleLabel.hidden = hide
        magicTitleLabel.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(hide ? 0 : 24)
        })
        coolingTitleLabel.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(hide ? 0 : 24)
        })
        skillMagicUseLabel.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(hide ? 0 : 24)
        })
        coolingTimeLabel.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(hide ? 0 : 24)
        })
    }
}
