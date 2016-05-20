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
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return heroDataArray.count/4 + (( heroDataArray.count%4 == 0 ) ? 0:1)
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
