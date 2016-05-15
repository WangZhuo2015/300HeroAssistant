//
//  ServiceProxy.swift
//  EVReflectionTest
//
//  Created by 王卓 on 16/3/15.
//  Copyright © 2016年 BubbleTeam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServiceProxy{
    // MARK: -URL
    private static var ServiceEndpointBase : String {
        return "http://300report.jumpw.com/api/"
    }
    //玩家基本信息
    private static func getPlayerBasicInfoURL() -> String {
        return ServiceEndpointBase + "getrole"
    }
    
    private static func getMatchListURL() -> String {
        return ServiceEndpointBase + "getlist"
    }
    private static func getMatchDetailURL() -> String {
        return ServiceEndpointBase + "getmatch"
    }
    
    private static func getRankURL() -> String {
        return ServiceEndpointBase + "getrank"
    }
    
    
    internal static func getPlayerBasicInfo (
        playerName:String,
        complete:(PlayerInfo: RoleAPIBase?, error: NSError?) -> Void){
        HttpClient.invoke(getPlayerBasicInfoURL(), parameters: ["name":playerName]) { (response, error) in
            let json = JSON(data: response!)
            print(json)
            complete(PlayerInfo: RoleAPIBase(fromJson:json), error: error)
        }
    }
    
//    =======================================
//    <<          获取玩家基本信息            >>
//    =======================================
//    [请求地址]
//    /api/getrole
//    [参数](支持get与post方法)
//    name: 召唤师名称(utf8编码)
    internal static func isIDvalid (
        playerName:String,
        complete:(result: Bool,reason:String? , error: NSError?) -> Void){
        HttpClient.invoke(getPlayerBasicInfoURL(), parameters: ["name":playerName]) { (response, error) in
            let json = JSON(data: response!)
            (json["Result"].string == "OK" ) ? complete(result: true,reason: json["Result"].string, error: error) : complete(result: false,reason: json["Result"].string, error: error)
        }
    }

//    =======================================
//    <<          获取最新的战斗列表          >>
//    =======================================
//    [请求地址]
//    /api/getlist
//    [参数](支持get与post方法)
//    name: 召唤师名称(utf8编码)
//    index: 列表索引值(默认为0)
    internal static func getBattleList (
        playerName:String,
        index:Int,
        complete:(MatchBasicAPIBase: MatchBasicAPIBase?, error: NSError?) -> Void){
        HttpClient.invoke(getMatchListURL(), parameters: ["name":playerName,"index":index]) { (response, error) in
            let json = JSON(data: response!)
            complete(MatchBasicAPIBase: MatchBasicAPIBase(fromJson: json), error: error)
        }
    }
    
//    =======================================
//    <<          获取比赛详细信息            >>
//    =======================================
//    [请求地址]
//    /api/getmatch
//    [参数](支持get与post方法)
//    id: 比赛ID
    internal static func getMatchDetail (
        id:Int,
        complete:(MatchDetail: MatchDetail?, error: NSError?) -> Void){
        HttpClient.invoke(getMatchDetailURL(), parameters: ["id":id]) { (response, error) in
            let json = JSON(data: response!)
            complete(MatchDetail: MatchDetail(fromJson: json), error: error)
        }
    }
    
    
//    =======================================
//    <<            获取排行榜信息            >>
//    =======================================
//    [请求地址]
//    /api/getrank
//    [参数](支持get与post方法)
//    type: 排行榜类型(默认为-1)
//    -1:排行榜列表
//    0:最受欢迎玩家
//    1:团队实力排行
//    2:常胜王排行
//    3:重度玩家排行
//    4:个人实力排行
//    5:最新杀人王
//    6:最新必须死
//    7:最新助攻王
//    8:最新拆迁王
//    9:最新小兵终结者
//    10:最新打钱王
//    11:最新金钱获取王
//    12:最新经验获取王
//    13:最新常胜王排行
//    14:最新重度玩家
//    28~156:英雄本命排行（不是所有ID都有）
//    index: 列表索引值(默认为0)
    internal static func getRank (
        type:Int,
        index:Int,
        complete:(data: NSData?, error: NSError?) -> Void){
        HttpClient.invoke(getRankURL(), parameters: ["type":type,"index":index]) { (response, error) in
            let json = JSON(data: response!)
            print(json)
            complete(data: response, error: error)
        }
    }
}