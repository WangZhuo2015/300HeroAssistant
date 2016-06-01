//
//  MatchViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import PKHUD
class MatchViewController: UIViewController {
    @IBOutlet weak var matchTableView: UITableView!
    
    //MatchCell
    let MatchCellIdentifier = "MatchCellIdentifier"
    var matchBasicInfoArray = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置TableView
        matchTableView.dataSource = self
        matchTableView.delegate = self


        //设置导航栏
        navigationItem.title = "战绩查询"
        //设置用户切换时间
        userChange()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.userChange), name: userChangedNotification, object: nil)
        //设置刷新
        let header = MJRefreshNormalHeader(refreshingBlock: {
            self.matchTableView.mj_header.beginRefreshing()
            self.loadMatchList(loadMore: false)
            self.matchTableView.mj_header.endRefreshing()
        })
        header.stateLabel.textColor = UIColor.whiteColor()
        header.lastUpdatedTimeLabel.textColor = UIColor.whiteColor()
        //TODO: 箭头颜色
        self.matchTableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.matchTableView.mj_footer.beginRefreshing()
            self.loadMatchList(loadMore: true)
            self.matchTableView.mj_footer.endRefreshing()
        })
        footer.stateLabel.textColor = UIColor.whiteColor()
        matchTableView.mj_footer = footer
        // Do any additional setup after loading the view.
    }
    
    func userChange(){
        self.navigationController?.popToRootViewControllerAnimated(false)
        loadMatchList(loadMore: false)
    }

    
    /**
     获取数据方法
     
     - parameter name:     玩家名
     - parameter loadMore: 是否加载更多
     */
    func loadMatchList(name:String = User.sharedUser.userName ?? "",loadMore:Bool = true){
        //TODO -:一次获取详细数据
        
        //如果是刷新
        if !loadMore {
            self.matchBasicInfoArray.removeAll()
            matchTableView.reloadData()
        }
        ServiceProxy.getBattleList(name, index: matchBasicInfoArray.count) { (matchBasicAPIBase, error) in
            guard error == nil else{
                HUD.flash(.LabeledError(title: "连接出错", subtitle: nil),delay: 1)
                self.matchBasicInfoArray.removeAll()
                return
            }
            if matchBasicAPIBase?.list.count == 0{
                HUD.flash(.LabeledError(title: "没有更多信息", subtitle: nil),delay: 1)
            }else{
                HUD.flash(.Success,delay: 0.3)
            }
            self.matchBasicInfoArray.appendContentsOf((matchBasicAPIBase?.list)!)
            self.matchTableView.reloadData()
        }
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
