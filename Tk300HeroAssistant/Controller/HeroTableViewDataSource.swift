//
//  HeroTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension HeroViewController:UICollectionViewDelegate,UICollectionViewDataSource{
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableView.tableViewDisplayWith("数据加载ing...", ifNecessaryForRowCount: 0)
//        return heroDataArray.count
//    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(HeroDataCellIdentifier) as! HeroTableViewCell
//        cell.setContent(heroDataArray[indexPath.row])
//        return cell
//    }
    //调整collectionViewCell大小
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        return CGSizeMake((UIScreen.mainScreen().bounds.width - 50)/4, (UIScreen.mainScreen().bounds.width - 50)/4 + 20)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        collectionView.collectionViewDisplayWith("数据加载ing", ifNecessaryForRowCount: 0)
        return heroDataArray.count/4 + (( heroDataArray.count % 4 == 0 ) ? 0:1)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == (heroDataArray.count/4 + (( heroDataArray.count%4 == 0 ) ? 0:1)-1)) ? heroDataArray.count % 4 : 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HeroCollectionViewCellIdentifier, forIndexPath: indexPath) as! HeroCollectionViewCell
        cell.setContent(heroDataArray[indexPath.section * 4 + indexPath.row ])
        return cell
    }
}
