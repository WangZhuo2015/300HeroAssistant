//
//  PlayerBasicInfoAPIBase.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/8.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
import EVReflection
class PlayerBasicInfoAPIBase:EVObject {
    var Result = ""
    var Role:Player = Player()
    var Rank = [PlayerRank]()
}