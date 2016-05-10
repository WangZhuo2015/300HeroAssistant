//
//	Role.swift
//  on 10/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class Role : NSObject, NSCoding{

	var jumpValue : Int!
	var matchCount : Int!
	var roleID : Int!
	var roleLevel : Int!
	var roleName : String!
	var updateTime : String!
	var winCount : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		jumpValue = json["JumpValue"].intValue
		matchCount = json["MatchCount"].intValue
		roleID = json["RoleID"].intValue
		roleLevel = json["RoleLevel"].intValue
		roleName = json["RoleName"].stringValue
		updateTime = json["UpdateTime"].stringValue
		winCount = json["WinCount"].intValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if jumpValue != nil{
			dictionary["JumpValue"] = jumpValue
		}
		if matchCount != nil{
			dictionary["MatchCount"] = matchCount
		}
		if roleID != nil{
			dictionary["RoleID"] = roleID
		}
		if roleLevel != nil{
			dictionary["RoleLevel"] = roleLevel
		}
		if roleName != nil{
			dictionary["RoleName"] = roleName
		}
		if updateTime != nil{
			dictionary["UpdateTime"] = updateTime
		}
		if winCount != nil{
			dictionary["WinCount"] = winCount
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         jumpValue = aDecoder.decodeObjectForKey("JumpValue") as? Int
         matchCount = aDecoder.decodeObjectForKey("MatchCount") as? Int
         roleID = aDecoder.decodeObjectForKey("RoleID") as? Int
         roleLevel = aDecoder.decodeObjectForKey("RoleLevel") as? Int
         roleName = aDecoder.decodeObjectForKey("RoleName") as? String
         updateTime = aDecoder.decodeObjectForKey("UpdateTime") as? String
         winCount = aDecoder.decodeObjectForKey("WinCount") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if jumpValue != nil{
			aCoder.encodeObject(jumpValue, forKey: "JumpValue")
		}
		if matchCount != nil{
			aCoder.encodeObject(matchCount, forKey: "MatchCount")
		}
		if roleID != nil{
			aCoder.encodeObject(roleID, forKey: "RoleID")
		}
		if roleLevel != nil{
			aCoder.encodeObject(roleLevel, forKey: "RoleLevel")
		}
		if roleName != nil{
			aCoder.encodeObject(roleName, forKey: "RoleName")
		}
		if updateTime != nil{
			aCoder.encodeObject(updateTime, forKey: "UpdateTime")
		}
		if winCount != nil{
			aCoder.encodeObject(winCount, forKey: "WinCount")
		}

	}

}