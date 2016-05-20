//
//  DataViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import SwiftCSV
class HeroViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var heroDataArray = [HeroData]()
    var skillDataArray = [SkillData]()
    
    let HeroDataCellIdentifier = "HeroDataCellIdentifier"
    let HeroCollectionViewCellIdentifier = "HeroCollectionViewCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        CSVDataManager.loadHeroData { (dataArray) in
            self.heroDataArray = dataArray
            self.collectionView.reloadData()
        }
        CSVDataManager.loadSkillData { (dataArray) in
            self.skillDataArray = dataArray
        }
        
        
        // Do any additional setup after loading the view.
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
        let VC = segue.destinationViewController as! HeroDetailViewController
        let indexPath = collectionView.indexPathsForSelectedItems()![0]
        VC.hero = heroDataArray[indexPath.section*4 + indexPath.row]
        VC.skillArray = skillDataArray.filter({ (data) -> Bool in
            data.id == heroDataArray[indexPath.section*4 + indexPath.row].id
        })
    }
}