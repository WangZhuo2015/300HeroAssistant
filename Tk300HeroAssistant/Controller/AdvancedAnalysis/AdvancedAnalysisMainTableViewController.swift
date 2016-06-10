//
//  AdvancedAnalysisMainTableViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/10.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class AdvancedAnalysisMainTableViewController: UITableViewController,DataAnalyzerDelegate {

    var dataAnalyzer = DataAnalyzer()
    let HeroWinRateSegue = "HeroWinRateSegue"
    let friendAnalysisSegue = "friendAnalysisSegue"
    var heroBattle: [HeroWinRate]?
    var friend:[(Player,Int)]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        dataAnalyzer.userName = User.sharedUser.userName ?? ""
        dataAnalyzer.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func alreadyLoadList() {
        dataAnalyzer.calculateHeroWinRate { self.heroBattle = $0 }
        tableView.reloadData()
    }
    func alreadyLoadDetail() {
        tableView.reloadData()
        dataAnalyzer.analysisFriend{ self.friend = $0 }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier ?? "" {
        case HeroWinRateSegue:
            let viewController = segue.destinationViewController as! HeroWinRateViewController
            viewController.data = self.heroBattle ?? []
        case friendAnalysisSegue:
            let viewController = segue.destinationViewController as! FriendAnalysisViewController
            viewController.data = self.friend ?? []
        default:
            break
        }
        
    }

}
