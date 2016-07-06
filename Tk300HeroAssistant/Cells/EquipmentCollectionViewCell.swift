//
//  EquipmentCollectionViewCell.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/31.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class EquipmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var equipmentLabel: UILabel!
    
    @IBOutlet weak var equipmentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContent(equipment:EquipmentData){
        equipmentLabel.text = equipment.name
        equipmentImage.image = UIImage(named: equipment.id!)
        //equipmentImage.layer.shouldRasterize = true
    }

}
