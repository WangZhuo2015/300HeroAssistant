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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor ( red: 0.4627, green: 0.7725, blue: 0.9804, alpha: 1.0 )
        topHideValue = searchBarTop.constant
        searchBarTop.constant += 44
        topNormalValue = searchBarTop.constant
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
        VC.currentEquipment = equipmentDataArray[indexPath.section * 4 + indexPath.row]
    }
}
