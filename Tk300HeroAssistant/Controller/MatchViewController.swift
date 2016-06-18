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
    var matchBasicInfoArray = [List](){
        didSet{
            var count = 0
            matchBasicInfoArray.forEach { (item) in
                if matchDetailDownload.indexForKey(item.matchID) == nil{
                    downloadMatchDetail(item.matchID, completehandle: { (match) in
                        if let detail = match{
                            self.matchDetailDownload[item.matchID] = detail
                        }
                        self.matchTableView.reloadData()
                    })
                }
                count += 1
            }
        }
    }
    var matchDetailDownload = [Int:Match?](){
        didSet{
            matchDetailDownload.forEach { (id,match) in
                if matchPlayerData.indexForKey(id) == nil{
                    var allRoles = [MatchRole]()
                    if let data = match{
                        allRoles.appendContentsOf(data.loseSide)
                        allRoles.appendContentsOf(data.winSide)
                        let role = allRoles.filter{$0.roleName == User.sharedUser.userName}[0]
                        matchPlayerData[id] = (role.killCount,role.deathCount,role.assistCount)
                    }
                }
            }
        }
    }
    var matchPlayerData = [Int:(Int,Int,Int)]()
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
        let name = UIBarButtonItem(title: "  " + (User.sharedUser.userName ?? ""), style: .Done, target: nil, action: nil)
        name.tintColor = UIColor.whiteColor()
        name.enabled = false
        navigationItem.leftBarButtonItem = name
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
        vc.matchData = matchDetailDownload[vc.matchID]!
    }
    
    func downloadMatchDetail(matchID:Int,completehandle:(Match?)->Void){
        ServiceProxy.getMatchDetail(matchID) { (matchDetail, error) in
            if error == nil{
                completehandle(matchDetail?.match)
            }else{
                completehandle(nil)
            }
        }
    }
}