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
class MatchViewController: UIViewController {
    @IBOutlet weak var matchTableView: UITableView!
    
    //MatchCell
    let MatchCellIdentifier = "MatchCellIdentifier"
    var matchBasicInfoArray = [List]()
    var matchIndex:Int = 0{
        didSet{
            print("didSet \(matchIndex)")
        }
    }
    
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
        //设置第一次加载的内容
        loadMatchList(index: &matchIndex,loadMore: false)
        //设置刷新
        self.matchTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.matchTableView.mj_header.beginRefreshing()
            self.loadMatchList(index: &self.matchIndex,loadMore: false)
            self.matchTableView.mj_header.endRefreshing()
        })
        matchTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.matchTableView.mj_header.beginRefreshing()
            self.loadMatchList(index: &self.matchIndex)
            self.matchTableView.mj_footer.endRefreshing()
        })
        // Do any additional setup after loading the view.
    }
    
    func userChange(){
        matchIndex = 0
        loadMatchList(index: &matchIndex,loadMore: false)
    }

    
    /**
     获取数据方法
     
     - parameter name:     玩家名
     - parameter index:    index
     - parameter loadMore: 是否加载更多
     */
    func loadMatchList(name:String = User.sharedUser.userName,inout index:Int,loadMore:Bool = true){
        //TODO -:一次获取详细数据
        
        //如果是刷新
        if !loadMore {
            index = 0
            self.matchBasicInfoArray.removeAll()
            matchTableView.reloadData()
        }
        print(index)
        ServiceProxy.getBattleList(name, index: index) { (matchBasicAPIBase, error) in
            guard error == nil else{
                index = 0
                self.matchBasicInfoArray.removeAll()
                return
            }
            self.matchBasicInfoArray.appendContentsOf((matchBasicAPIBase?.list)!)
            self.matchTableView.reloadData()
            index += 1
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
