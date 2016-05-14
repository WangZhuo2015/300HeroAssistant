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
    
    @IBOutlet weak var innerView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.layer.cornerRadius = 6
        innerView.clipsToBounds = true
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setContent(matchBasic:List){
        self.matchImage.kf_setImageWithURL(NSURL(string: "http://300report.jumpw.com/static/images/"+matchBasic.hero.iconFile)!)
        self.heroLevel.text = "\(matchBasic.heroLevel)"
        self.heroName.text = matchBasic.hero.name
        self.matchDate.text = matchBasic.matchDate
        self.matchResult.text = matchResToStr(matchBasic.result)
        self.matchType.text = "竞技场"
    }
    func matchResToStr(res:Int)->String?{
        switch res {
        case 1:
            return "胜利"
        case 2:
            return "失败"
        case 3:
            return "逃跑"
        default:
            return nil
        }
    }
}
