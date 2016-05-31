//
//  EquipmentCollectionViewDataSource.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/31.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
import UIKit
extension EquipmentViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //调整collectionViewCell大小
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        return CGSizeMake((UIScreen.mainScreen().bounds.width - 50)/4, (UIScreen.mainScreen().bounds.width - 50)/4 + 20)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        collectionView.collectionViewDisplayWith("数据加载ing", ifNecessaryForRowCount: 0)
        return equipmentDataArray.count/4 + (( equipmentDataArray.count % 4 == 0 ) ? 0:1)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == (equipmentDataArray.count/4 + (( equipmentDataArray.count%4 == 0 ) ? 0:1)-1)) ? equipmentDataArray.count % 4 : 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EquipmentCollectionViewCellIdentifier, forIndexPath: indexPath) as! EquipmentCollectionViewCell
        cell.setContent(equipmentDataArray[indexPath.section * 4 + indexPath.row ])
        return cell
    }
}
