//
//  HeroDetailViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/18.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    @IBOutlet weak var heroIcon: UIImageView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heroNameLabel: UILabel!
    
    @IBOutlet weak var attackTypeLabel: UILabel!
    
    @IBOutlet weak var locateLabel: UILabel!
    
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var magicLabel: UILabel!
    
    @IBOutlet weak var phyAttckLabel: UILabel!
    
    @IBOutlet weak var magicLevelLabel: UILabel!
    
    @IBOutlet weak var phyDefLabel: UILabel!
    
    @IBOutlet weak var magicDefLabel: UILabel!
    
    @IBOutlet weak var boomAttackRateLabel: UILabel!
    
    @IBOutlet weak var attackSpeedLabel: UILabel!
    
    @IBOutlet weak var attackRangeLabel: UILabel!
    
    @IBOutlet weak var moveSpeedLabel: UILabel!
    
    let SkillCellIdentifier = "SkillCellIdentifier"
    var hero:HeroData?{
        
        //TODO: -逻辑待优化
        didSet{
//            CSVDataManager.loadSkillData { (data) in
//                self.skillArray = data.filter({ (item) -> Bool in
//                    item.id == self.hero!.id
//                })
//            }
        }
    }
    var skillArray : [SkillData]?{
        didSet{
            guard tableView != nil else{
                return
            }
            tableView.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        setContent(hero!)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setContent(hero:HeroData){
        heroIcon.image = UIImage(named: "hero-" + hero.id! + hero.name!)
        
        heroNameLabel.text = hero.name
        
        attackTypeLabel.text = hero.attype
        
        locateLabel.text = hero.locate
        
        healthLabel.text = hero.生命值
        
        magicLabel.text = hero.魔法值
        
        phyAttckLabel.text = hero.物理攻击
        
        magicLevelLabel.text = hero.法术强度
        
        phyDefLabel.text = hero.物理防御
        
        magicDefLabel.text = hero.魔法抗性
        
        boomAttackRateLabel.text = hero.暴击
        
        attackSpeedLabel.text = hero.攻击速度
        
        attackRangeLabel.text = hero.攻击范围
        
        moveSpeedLabel.text = hero.移动速度
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
