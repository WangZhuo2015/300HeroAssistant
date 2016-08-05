//
//  EquipmentViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/31.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import SnapKit
class EquipmentViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var searchBarTop: NSLayoutConstraint!
    
    let pageName = "EquipmentViewController"
    var colPerRow = 4
    
    var lastScrollOffest:CGFloat = 0.0
    var topNormalValue: CGFloat = 0.0
    var topHideValue: CGFloat = 0.0
    
    var rawEquipmentDataArray = [EquipmentData]()
    var equipmentDataArray = [EquipmentData](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colPerRow = AppManager.checkDviceType() == .iPad ? 8: 4
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.backgroundColor = ApplicationColorManager.AppMainBackgroundColor
        //searchBar setting
        searchBar.delegate = self
        searchBar.placeholder = "查找装备"
        topHideValue = searchBarTop.constant
        searchBarTop.constant += 44
        topNormalValue = searchBarTop.constant
        //
        CSVDataManager.sharedInstance.loadEquipData { (data) in
            self.rawEquipmentDataArray = data//.sort{ (Int($0.售价!)! + Int($1.售价!)!)>0}
            self.equipmentDataArray = data
            // Do any additional setup after loading the view.
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        AVAnalytics.beginLogPageView(pageName)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        AVAnalytics.endLogPageView(pageName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        searchBar.resignFirstResponder()
        let VC = segue.destinationViewController as! EquipmentDetailViewController
        let indexPath = collectionView.indexPathsForSelectedItems()![0]
        VC.currentEquipment = equipmentDataArray[indexPath.section * colPerRow + indexPath.row]
    }
}
