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
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var rawHeroDataArray = [HeroData](){
        didSet{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.rawHeroDataArray.forEach({ (data) in
                    self.heroTypes.insert( data.locate! )
                })
            })
            heroType = ""
        }
    }
    var heroDataArray = [HeroData](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    var skillDataArray = [SkillData]()
    var heroTypes = Set<String>()
    var heroType = ""{
        didSet{
            heroDataArray.removeAll()
            self.heroDataArray.appendContentsOf(self.rawHeroDataArray.filter({ (data) -> Bool in
                guard self.heroType != "" else{ return true }
                return data.locate == self.heroType
            }))
        }
    }
    
    let HeroDataCellIdentifier = "HeroDataCellIdentifier"
    let HeroCollectionViewCellIdentifier = "HeroCollectionViewCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        CSVDataManager.sharedInstance.loadHeroData { (dataArray) in
            self.rawHeroDataArray = dataArray
        }
        CSVDataManager.sharedInstance.loadSkillData { (dataArray) in
            self.skillDataArray = dataArray
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //改变过滤器
    @IBAction func filterChange(sender: UIBarButtonItem) {
        let alertSheet = UIAlertController(title: "过滤", message: "选择类型", preferredStyle: .ActionSheet)
        for type in heroTypes{
            let action = UIAlertAction(title: type, style: .Default, handler: { (_) in
                self.heroType = type
            })
            alertSheet.addAction(action)
        }
        let allAction = UIAlertAction(title: "全部", style: .Default, handler: { (_) in
            self.heroType = ""
        })
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: { (_) in
            self.heroType = ""
        })
        alertSheet.addAction(allAction)
        alertSheet.addAction(cancelAction)
        presentViewController(alertSheet, animated: true,completion: nil)
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
