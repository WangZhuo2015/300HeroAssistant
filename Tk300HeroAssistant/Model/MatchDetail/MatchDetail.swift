//
//	MatchDetail.swift
//  on 9/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class MatchDetail : NSObject, NSCoding{

	var match : Match!
	var result : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		let matchJson = json["Match"]
		if matchJson != JSON.null{
			match = Match(fromJson: matchJson)
		}
		result = json["Result"].stringValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if match != nil{
			dictionary["Match"] = match.toDictionary()
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
         match = aDecoder.decodeObjectForKey("Match") as? Match
         result = aDecoder.decodeObjectForKey("Result") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if match != nil{
			aCoder.encodeObject(match, forKey: "Match")
		}
		if result != nil{
			aCoder.encodeObject(result, forKey: "Result")
		}

	}

}