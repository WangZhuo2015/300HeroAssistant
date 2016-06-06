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
    var didSelectItem: ((index: Int)->())?
    let buttonWidth: CGFloat = 60.0
    let padding: CGFloat = 10.0
    let imageSize: CGFloat = 60.0
    
    func setContent(array:[String]){
        guard array.count != 0 else{
            self.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
            return
        }
        self.contentSize = CGSize(width: CGFloat(array.count) * buttonWidth + padding*(CGFloat(array.count)+1), height: self.frame.height/2)
        var i = 0
        for item in array{
            let image = UIImage(named: item)
            print(item)
            let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            imageView.image = image
            imageView.center = CGPoint(x: CGFloat(i+1) * padding + (CGFloat(i)+0.5)*buttonWidth, y: self.frame.height/2)
            imageView.userInteractionEnabled = true
            imageView.tag = Int(item)!
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapImage:")))
            addSubview(imageView)
            
//            let image = UIImage(named: item)
//            let imageView  = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
//            imageView.setImage(image, forState: .Normal)
//            imageView.setImage(image, forState: .Highlighted)
//            imageView.center = CGPoint(x: CGFloat(i+1) * padding + (CGFloat(i)+0.5)*buttonWidth, y: self.frame.height/2)
//            imageView.userInteractionEnabled = true
//            imageView.enabled = true
//            imageView.tag = Int(item)!
//            imageView.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
//            addSubview(imageView)

            i += 1
        }
    }
//    func tapped(sender:UIButton){
//        print("Tapped")
//    }
    
    func didTapImage(tap: UITapGestureRecognizer) {
        print("tapped")
        didSelectItem?(index: tap.view!.tag)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview == nil {
            return
        }
        
        UIView.animateWithDuration(0.4, delay: 0.01, usingSpringWithDamping: 1, initialSpringVelocity: 10.0, options: .CurveEaseIn, animations: {
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
