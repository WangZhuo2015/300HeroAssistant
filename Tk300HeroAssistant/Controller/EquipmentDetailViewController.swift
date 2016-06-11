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
    
    @IBOutlet weak var combineScrollView: HorizontalMenuScrollView!
    
    @IBOutlet weak var subEquipmentScrollView: HorizontalMenuScrollView!
    
    @IBOutlet weak var combineLabel: UIButton!
    
    @IBOutlet weak var subEquipmentLabel: UIButton!
    
    let EquipmentDetailViewControllerID = "EquipmentDetailViewControllerID"
    var currentEquipment:EquipmentData?
    
//    var itemSelect:((index:Int)->Void) = { index in
//        self()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = currentEquipment?.name
        setContent(currentEquipment!)
        combineScrollView.setContent(currentEquipment?.进阶物品id ?? [])
        subEquipmentScrollView.setContent(currentEquipment?.所需物品id ?? [])
        if currentEquipment?.进阶物品id == nil {combineLabel.hidden = true}
        if currentEquipment?.所需物品id == nil {subEquipmentLabel.hidden = true}
        combineScrollView.didSelectItem = { index in
            let storyBoard = UIStoryboard(name: "Equipment", bundle: NSBundle.mainBundle())
            let equipmentDetailVC = storyBoard.instantiateViewControllerWithIdentifier("EquipmentDetailViewControllerID") as! EquipmentDetailViewController
            equipmentDetailVC.setContent(CSVDataManager.sharedInstance.getEquipmentInfoByID(index)!)
            equipmentDetailVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "返回全部装备", style: .Plain, target: self, action: #selector(EquipmentDetailViewController.popToRoot))
            self.navigationController?.pushViewController(equipmentDetailVC, animated: true)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setContent(equipmentData:EquipmentData){
        equipmentImage.image = UIImage(named: equipmentData.id!)
        equipmentName.text = " \(equipmentData.name!) "
        equipmentAttributeLabel.text = equipmentData.属性
        equipmentSkillLabel.text = equipmentData.装备技能
        equipmentPriceLabel.text = equipmentData.售价
    }
    
    func popToRoot(){
        self.navigationController?.popToRootViewControllerAnimated(true)
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
