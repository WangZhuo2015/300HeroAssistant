//
//  EquipmentDetailViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/31.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class EquipmentDetailViewController: UIViewController {

    @IBOutlet weak var equipmentImage: UIImageView!
    
    @IBOutlet weak var equipmentName: UILabel!
    
    @IBOutlet weak var equipmentAttributeLabel: UILabel!
    
    @IBOutlet weak var equipmentSkillLabel: UILabel!
    
    @IBOutlet weak var equipmentPriceLabel: UILabel!
    
    var currentEquipment:EquipmentData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent(currentEquipment!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setContent(equipmentData:EquipmentData){
        equipmentImage.image = UIImage(named: equipmentData.id!)
        equipmentName.text = equipmentData.name
        equipmentAttributeLabel.text = equipmentData.属性
        equipmentSkillLabel.text = equipmentData.装备技能
        equipmentPriceLabel.text = equipmentData.售价
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
