//
//	Rank.swift
//  on 10/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class Rank : NSObject, NSCoding{

	var rank : Int!
	var rankChange : Int!
	var rankIndex : Int!
	var rankName : String!
	var type : Int!
	var value : String!
	var valueName : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		rank = json["Rank"].intValue
		rankChange = json["RankChange"].intValue
		rankIndex = json["RankIndex"].intValue
		rankName = json["RankName"].stringValue
		type = json["Type"].intValue
		value = json["Value"].stringValue
		valueName = json["ValueName"].stringValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if rank != nil{
			dictionary["Rank"] = rank
		}
		if rankChange != nil{
			dictionary["RankChange"] = rankChange
		}
		if rankIndex != nil{
			dictionary["RankIndex"] = rankIndex
		}
		if rankName != nil{
			dictionary["RankName"] = rankName
		}
		if type != nil{
			dictionary["Type"] = type
		}
		if value != nil{
			dictionary["Value"] = value
		}
		if valueName != nil{
			dictionary["ValueName"] = valueName
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         rank = aDecoder.decodeObjectForKey("Rank") as? Int
         rankChange = aDecoder.decodeObjectForKey("RankChange") as? Int
         rankIndex = aDecoder.decodeObjectForKey("RankIndex") as? Int
         rankName = aDecoder.decodeObjectForKey("RankName") as? String
         type = aDecoder.decodeObjectForKey("Type") as? Int
         value = aDecoder.decodeObjectForKey("Value") as? String
         valueName = aDecoder.decodeObjectForKey("ValueName") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if rank != nil{
			aCoder.encodeObject(rank, forKey: "Rank")
		}
		if rankChange != nil{
			aCoder.encodeObject(rankChange, forKey: "RankChange")
		}
		if rankIndex != nil{
			aCoder.encodeObject(rankIndex, forKey: "RankIndex")
		}
		if rankName != nil{
			aCoder.encodeObject(rankName, forKey: "RankName")
		}
		if type != nil{
			aCoder.encodeObject(type, forKey: "Type")
		}
		if value != nil{
			aCoder.encodeObject(value, forKey: "Value")
		}
		if valueName != nil{
			aCoder.encodeObject(valueName, forKey: "ValueName")
		}

	}

}