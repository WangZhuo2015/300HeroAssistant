//
//  HorizontalMenuScrollView.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/5.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import SnapKit
class HorizontalMenuScrollView: UIScrollView {
    var didSelectItem: ((index: String)->())?
    let buttonWidth: CGFloat = 60.0
    let padding: CGFloat = 10.0
    let imageSize: CGFloat = 60.0
    var containerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var stackView = UIStackView()
    override func awakeFromNib() {
        addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.snp_edges)
            make.height.equalTo(80)
        }
        containerView.addSubview(stackView)
        stackView.snp_makeConstraints { (make) in
            make.edges.equalTo(containerView.snp_edges)
        }
        stackView.spacing = 10
        stackView.distribution = .FillEqually
        stackView.alignment = .Center
    }
    
    func setContent(array:[String]){
        guard array.count != 0 else{
            self.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
            return
        }
        self.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(81)
        })
        containerView.snp_updateConstraints { (make) in
            make.width.equalTo(CGFloat(array.count) * buttonWidth + padding*(CGFloat(array.count)+1))
        }
        
        for item in array{
            let image = UIImage(named: item)
            print(item)
            let imageView  = UIImageView()
            imageView.snp_makeConstraints(closure: { (make) in
                make.height.equalTo(imageView.snp_width)
            })
            imageView.image = image
            imageView.userInteractionEnabled = true
            imageView.tag = Int(item)!
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HorizontalMenuScrollView.didTapImage(_:))))
            stackView.addArrangedSubview(imageView)
        }
    }
    func didTapImage(tap: UITapGestureRecognizer) {
        print("tapped")
        didSelectItem?(index: "\(tap.view!.tag)")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview == nil {
            return
        }
        
        UIView.animateWithDuration(1, delay: 0.01, usingSpringWithDamping: 1, initialSpringVelocity: 10.0, options: .CurveEaseIn, animations: {
            self.alpha = 1.0
            self.center.x -= self.frame.size.width
            }, completion: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
