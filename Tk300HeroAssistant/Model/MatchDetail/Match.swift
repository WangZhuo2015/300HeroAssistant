//
//	Match.swift
//  on 9/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class Match : NSObject, NSCoding{
    /// 失败方角色信息
    var loseSide : [MatchRole]!
    /// 失败方杀人数
	var loseSideKill : Int!
    /// 比赛日期
	var matchDate : String!
    /// 比赛类型(1:竟技场 2:战场)
	var matchType : Int!
    /// 比赛所使用的时间(秒)
	var usedTime : Int!
    /// 胜利方角色信息
	var winSide : [MatchRole]!
    /// 胜利方杀人数
	var winSideKill : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		loseSide = [MatchRole]()
		let loseSideArray = json["LoseSide"].arrayValue
		for loseSideJson in loseSideArray{
			let value = MatchRole(fromJson: loseSideJson)
			loseSide.append(value)
		}
		loseSideKill = json["LoseSideKill"].intValue
		matchDate = json["MatchDate"].stringValue
		matchType = json["MatchType"].intValue
		usedTime = json["UsedTime"].intValue
		winSide = [MatchRole]()
		let winSideArray = json["WinSide"].arrayValue
		for winSideJson in winSideArray{
			let value = MatchRole(fromJson: winSideJson)
			winSide.append(value)
		}
		winSideKill = json["WinSideKill"].intValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if loseSide != nil{
			var dictionaryElements = [NSDictionary]()
			for loseSideElement in loseSide {
				dictionaryElements.append(loseSideElement.toDictionary())
			}
			dictionary["LoseSide"] = dictionaryElements
		}
		if loseSideKill != nil{
			dictionary["LoseSideKill"] = loseSideKill
		}
		if matchDate != nil{
			dictionary["MatchDate"] = matchDate
		}
		if matchType != nil{
			dictionary["MatchType"] = matchType
		}
		if usedTime != nil{
			dictionary["UsedTime"] = usedTime
		}
		if winSide != nil{
			var dictionaryElements = [NSDictionary]()
			for winSideElement in winSide {
				dictionaryElements.append(winSideElement.toDictionary())
			}
			dictionary["WinSide"] = dictionaryElements
		}
		if winSideKill != nil{
			dictionary["WinSideKill"] = winSideKill
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         loseSide = aDecoder.decodeObjectForKey("LoseSide") as? [MatchRole]
         loseSideKill = aDecoder.decodeObjectForKey("LoseSideKill") as? Int
         matchDate = aDecoder.decodeObjectForKey("MatchDate") as? String
         matchType = aDecoder.decodeObjectForKey("MatchType") as? Int
         usedTime = aDecoder.decodeObjectForKey("UsedTime") as? Int
         winSide = aDecoder.decodeObjectForKey("WinSide") as? [MatchRole]
         winSideKill = aDecoder.decodeObjectForKey("WinSideKill") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if loseSide != nil{
			aCoder.encodeObject(loseSide, forKey: "MatchRole")
		}
		if loseSideKill != nil{
			aCoder.encodeObject(loseSideKill, forKey: "LoseSideKill")
		}
		if matchDate != nil{
			aCoder.encodeObject(matchDate, forKey: "MatchDate")
		}
		if matchType != nil{
			aCoder.encodeObject(matchType, forKey: "MatchType")
		}
		if usedTime != nil{
			aCoder.encodeObject(usedTime, forKey: "UsedTime")
		}
		if winSide != nil{
			aCoder.encodeObject(winSide, forKey: "WinSide")
		}
		if winSideKill != nil{
			aCoder.encodeObject(winSideKill, forKey: "WinSideKill")
		}

	}

}