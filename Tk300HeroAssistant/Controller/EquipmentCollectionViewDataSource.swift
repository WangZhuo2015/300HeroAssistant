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
        return CGSizeMake((UIScreen.mainScreen().bounds.width - 50)/4, (UIScreen.mainScreen().bounds.width - 50)/4 + 20)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        collectionView.collectionViewDisplayWith("数据加载ing", ifNecessaryForRowCount: equipmentDataArray.count)
        return equipmentDataArray.count/4 + (( equipmentDataArray.count % 4 == 0 ) ? 0:1)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == (equipmentDataArray.count/4 + (( equipmentDataArray.count%4 == 0 ) ? 0:1)-1)) ? equipmentDataArray.count % 4 : 4
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
