//
//  EquipmentViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/31.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class EquipmentViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var equipmentDataArray = [EquipmentData](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    let EquipmentCollectionViewCellIdentifier = "EquipmentCollectionViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        CSVDataManager.loadEquipData { (data) in
            self.equipmentDataArray = data.sort{ (Int($0.售价!)! + Int($1.售价!)!)>0}
            // Do any additional setup after loading the view.
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//    //改变过滤器
//    @IBAction func filterChange(sender: UIBarButtonItem) {
//        let alertSheet = UIAlertController(title: "过滤", message: "选择类型", preferredStyle: .ActionSheet)
//        for type in equipmentTypes{
//            let action = UIAlertAction(title: type, style: .Default, handler: { (_) in
//                self.heroType = type
//            })
//            alertSheet.addAction(action)
//        }
//        let allAction = UIAlertAction(title: "全部", style: .Default, handler: { (_) in
//            self.heroType = ""
//        })
//        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: { (_) in
//            self.heroType = ""
//        })
//        alertSheet.addAction(allAction)
//        alertSheet.addAction(cancelAction)
//        presentViewController(alertSheet, animated: true,completion: nil)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let VC = segue.destinationViewController as! EquipmentDetailViewController
        let indexPath = collectionView.indexPathsForSelectedItems()![0]
        VC.currentEquipment = equipmentDataArray[indexPath.row]
    }
}
