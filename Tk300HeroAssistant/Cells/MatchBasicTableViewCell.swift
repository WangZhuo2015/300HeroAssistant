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

    @IBOutlet weak var matchDataLabel: UILabel!
    
    @IBOutlet weak var matchResult: UILabel!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var matchImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var playerInnerView: UIView!
    
    
    var matchData:(Int,Int,Int)?{
        didSet{
            if let data = matchData{
                matchDataLabel.text = ("\(data.0)\\\(data.1)\\\(data.2)")
            }
        }
    }
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
//        self.heroName.text = matchBasic.hero.name
        self.playerName.text = User.sharedUser.userName
        self.matchDate.text = matchBasic.matchDate
        self.matchResult.text = matchResToStr(matchBasic.result)
        
        switch matchBasic.result {
        case 1:
            playerInnerView.backgroundColor = UIColor ( red: 0.8782, green: 0.3069, blue: 0.2787, alpha: 1.0 )
        case 2:
            playerInnerView.backgroundColor = UIColor ( red: 0.5193, green: 0.9076, blue: 0.4013, alpha: 1.0 )
        case 3:
            playerInnerView.backgroundColor = UIColor ( red: 0.884, green: 0.6607, blue: 0.3519, alpha: 1.0 )
        default:
            playerInnerView.backgroundColor = UIColor ( red: 0.2794, green: 0.8725, blue: 0.8918, alpha: 1.0 )
        }
        
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
