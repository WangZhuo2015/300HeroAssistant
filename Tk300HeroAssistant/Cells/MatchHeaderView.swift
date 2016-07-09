//
//  MatchHeaderView.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class MatchHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func setContent(section:Int,kill:Int?,assistant:Int?,death:Int?,money:Int?){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 28))
        let stackView = UIStackView()
        stackView.alignment = .Center
        stackView.axis = .Horizontal
        stackView.distribution = .Fill
        stackView.spacing = 2
        
        let killImage = UIImageView(image: UIImage(named: "kill"))
        killImage.backgroundColor = UIColor.clearColor()

        let killLabel = UILabel()
        killLabel.backgroundColor = UIColor.clearColor()
        killLabel.textColor = UIColor.whiteColor()
        killLabel.text = "\(kill ?? 0)"
        
        let assistantImage = UIImageView(image: UIImage(named: "killHelp"))
        assistantImage.backgroundColor = UIColor.clearColor()
        let assistantLabel = UILabel()
        assistantLabel.backgroundColor = UIColor.clearColor()
        assistantLabel.textColor = UIColor.whiteColor()
        assistantLabel.text = "\(assistant ?? 0)"
        
        let deathImage = UIImageView(image: UIImage(named: "death"))
        deathImage.backgroundColor = UIColor.clearColor()
        let deathLabel = UILabel()
        deathLabel.backgroundColor = UIColor.clearColor()
        deathLabel.textColor = UIColor.whiteColor()
        deathLabel.text = "\(death ?? 0)"
        
        let moneyImage = UIImageView(image: UIImage(named: "coins"))
        moneyImage.backgroundColor = UIColor.clearColor()
        let moneyLabel = UILabel()
        moneyLabel.backgroundColor = UIColor.clearColor()
        moneyLabel.textColor = UIColor.whiteColor()
        moneyLabel.text = "\(money ?? 0)"
        
        self.backgroundColor = ApplicationColorManager.SectionSeparatorColor
        label.textColor = UIColor.whiteColor()
        label.text = {
            switch section {
            case 0:
                return "    Winner"
            case 1:
                return "    Loser"
            default:
                return "    error"
            }}()
        self.addSubview(label)
        stackView.addArrangedSubview(killImage)
        stackView.addArrangedSubview(killLabel)
        stackView.addArrangedSubview(assistantImage)
        stackView.addArrangedSubview(assistantLabel)
        stackView.addArrangedSubview(deathImage)
        stackView.addArrangedSubview(deathLabel)
        stackView.addArrangedSubview(moneyImage)
        stackView.addArrangedSubview(moneyLabel)
        self.addSubview(stackView)
        setSquare(killImage,containerView: stackView)
        setSquare(assistantImage,containerView: stackView)
        setSquare(deathImage,containerView: stackView)
        setSquare(moneyImage,containerView: stackView)
        label.snp_makeConstraints { (make) in
            make.leading.equalTo(8)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
        }
        killImage.snp_makeConstraints { (make) in
            make.width.equalTo(self.snp_height)
        }
        
        
        stackView.snp_makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-8)
            make.centerY.equalTo(self)
            //make.width.equalTo(28)
            make.height.equalTo(28)
        }
    }

    func setSquare(view:UIView,containerView:UIView){
        view.snp_makeConstraints { (make) in
            make.width.equalTo(self.snp_height).offset(-2)
            make.height.equalTo(containerView.snp_height)
        }
    }
}
