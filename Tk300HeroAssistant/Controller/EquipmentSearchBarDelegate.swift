//
//  EquipmentSearchBarDelegate.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/1.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
extension EquipmentViewController:UISearchBarDelegate{
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            equipmentDataArray = rawEquipmentDataArray
        }
        else{
            equipmentDataArray = rawEquipmentDataArray.filter{($0.name?.hasPrefix(searchText))!}
        }
    }
}
