//
//  EquipmentCollectionViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/31.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
import UIKit
extension EquipmentViewController:UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    
    //调整collectionViewCell大小
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        let width = (UIScreen.mainScreen().bounds.width - CGFloat(colPerRow + 1) * 15)/CGFloat(colPerRow)
        return CGSizeMake(width, width + 20)
    }
    //Section个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        collectionView.collectionViewDisplayWith("数据加载                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ing", ifNecessaryForRowCount: equipmentDataArray.count)
        return Int(ceil(Double(equipmentDataArray.count)/Double(colPerRow)))
    }
    //每个Section Item个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let lastRow = Int(floor(Double(equipmentDataArray.count)/Double(colPerRow)))
        if section == lastRow{
            return equipmentDataArray.count % colPerRow
        }
        return colPerRow
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.equipmentCollectionViewCellIdentifier, forIndexPath: indexPath) ?? EquipmentCollectionViewCell()
        cell.setContent(equipmentDataArray[indexPath.section * 4 + indexPath.row ])
        return cell
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastScrollOffest = scrollView.contentOffset.y
        print(scrollView.contentOffset.y)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y - lastScrollOffest > 0 && searchBarTop.constant > topHideValue{
            //隐藏
            searchBarTop.constant -= scrollView.contentOffset.y - lastScrollOffest
            if searchBarTop.constant < topHideValue{
                searchBarTop.constant = topHideValue
            }else{
                searchBar.resignFirstResponder()
            }
            searchBar.layoutIfNeeded()
        }else if scrollView.contentOffset.y - lastScrollOffest < 0 && searchBarTop.constant < topNormalValue{
            //展现
            searchBarTop.constant -= scrollView.contentOffset.y - lastScrollOffest
            if searchBarTop.constant > topNormalValue{
                searchBarTop.constant = topNormalValue
            }
            searchBar.layoutIfNeeded()
        }
        lastScrollOffest = scrollView.contentOffset.y
        print(scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        lastScrollOffest = scrollView.contentOffset.y
    }

}
