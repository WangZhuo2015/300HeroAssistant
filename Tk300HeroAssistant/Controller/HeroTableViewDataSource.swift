//
//  HeroTableViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/15.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension HeroViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //调整collectionViewCell大小
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        let width = (UIScreen.mainScreen().bounds.width - CGFloat(colPerRow + 1) * 15)/CGFloat(colPerRow)
        return CGSizeMake(width, width + 20)
    }
    //Section个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        collectionView.collectionViewDisplayWith("数据加载                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ing", ifNecessaryForRowCount: heroDataArray.count)
        return Int(ceil(Double(heroDataArray.count)/Double(colPerRow)))
    }
    //每个Section Item个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let lastRow = Int(floor(Double(heroDataArray.count)/Double(colPerRow)))
        if section == lastRow{
            return heroDataArray.count % colPerRow
        }
        return colPerRow
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.heroCollectionViewCellIdentifier, forIndexPath: indexPath) ?? HeroCollectionViewCell()
        cell.setContent(heroDataArray[indexPath.section * colPerRow + indexPath.row ])
        return cell
    }
}
