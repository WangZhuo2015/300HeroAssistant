//
//  ServiceProxy.swift
//  EVReflectionTest
//
//  Created by 王卓 on 16/3/15.
//  Copyright © 2016年 BubbleTeam. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection
class ServiceProxy{
    // MARK: -URL
    // MARK: -URL
    private static var ServiceEndpointBase : String {
        return "http://300report.jumpw.com/api/"
    }
    ///APIKey
//    static func getaAPIKey() -> String {
//        return ""
//    }
    
    //玩家基本信息
    private static func getPlayerBasicInfoURL() -> String {
        return ServiceEndpointBase + "getrole"
    }
    
//    =======================================
//    <<          获取玩家基本信息            >>
//    =======================================
//    [请求地址]
//    /api/getrole
//    [参数](支持get与post方法)
//    name: 召唤师名称(utf8编码)
    internal static func getPlayerBasicInfo (
        playerName:String,
        complete:(object: PlayerBasicInfoAPIBase?, error: NSError?) -> Void){
        HttpClient.invokeObject(getPlayerBasicInfoURL(), parameters: ["name":playerName], complete: complete)
    }

    
}