//
//	List.swift
//  on 10/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class List : NSObject, NSCoding{

	var hero : Hero!
	var heroLevel : Int!
	var matchDate : String!
	var matchID : Int!
	var matchType : Int!
	var result : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		let heroJson = json["Hero"]
		if heroJson != JSON.null{
			hero = Hero(fromJson: heroJson)
		}
		heroLevel = json["HeroLevel"].intValue
		matchDate = json["MatchDate"].stringValue
		matchID = json["MatchID"].intValue
		matchType = json["MatchType"].intValue
		result = json["Result"].intValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if hero != nil{
			dictionary["Hero"] = hero.toDictionary()
		}
		if heroLevel != nil{
			dictionary["HeroLevel"] = heroLevel
		}
		if matchDate != nil{
			dictionary["MatchDate"] = matchDate
		}
		if matchID != nil{
			dictionary["MatchID"] = matchID
		}
		if matchType != nil{
			dictionary["MatchType"] = matchType
		}
		if result != nil{
			dictionary["Result"] = result
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         hero = aDecoder.decodeObjectForKey("Hero") as? Hero
         heroLevel = aDecoder.decodeObjectForKey("HeroLevel") as? Int
         matchDate = aDecoder.decodeObjectForKey("MatchDate") as? String
         matchID = aDecoder.decodeObjectForKey("MatchID") as? Int
         matchType = aDecoder.decodeObjectForKey("MatchType") as? Int
         result = aDecoder.decodeObjectForKey("Result") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if hero != nil{
			aCoder.encodeObject(hero, forKey: "Hero")
		}
		if heroLevel != nil{
			aCoder.encodeObject(heroLevel, forKey: "HeroLevel")
		}
		if matchDate != nil{
			aCoder.encodeObject(matchDate, forKey: "MatchDate")
		}
		if matchID != nil{
			aCoder.encodeObject(matchID, forKey: "MatchID")
		}
		if matchType != nil{
			aCoder.encodeObject(matchType, forKey: "MatchType")
		}
		if result != nil{
			aCoder.encodeObject(result, forKey: "Result")
		}

	}

}