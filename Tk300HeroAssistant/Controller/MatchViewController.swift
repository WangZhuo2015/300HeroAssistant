//
//  MatchViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import Alamofire
class MatchViewController: UIViewController {
    @IBOutlet weak var matchTableView: UITableView!
    
    //MatchCell
    let MatchCellIdentifier = "MatchCellIdentifier"
    var matchBasicInfoArray = [List]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchTableView.dataSource = self
        matchTableView.delegate = self
        
        
        ServiceProxy.getBattleList("NextStep", index: 0) { (matchBasicAPIBase, error) in
            self.matchBasicInfoArray = (matchBasicAPIBase?.list)!
            self.matchTableView.reloadData()
        }        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! MatchDetailViewController
        vc.matchID = matchBasicInfoArray [matchTableView.indexPathForSelectedRow!.row].matchID
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
