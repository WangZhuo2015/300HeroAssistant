//
//	RoleAPIBase.swift
//  on 10/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class RoleAPIBase : NSObject, NSCoding{

	var rank : [Rank]!
	var result : String!
	var role : Role!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		rank = [Rank]()
		let rankArray = json["Rank"].arrayValue
		for rankJson in rankArray{
			let value = Rank(fromJson: rankJson)
			rank.append(value)
		}
		result = json["Result"].stringValue
		let roleJson = json["Role"]
		if roleJson != JSON.null{
			role = Role(fromJson: roleJson)
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if rank != nil{
			var dictionaryElements = [NSDictionary]()
			for rankElement in rank {
				dictionaryElements.append(rankElement.toDictionary())
			}
			dictionary["Rank"] = dictionaryElements
		}
		if result != nil{
			dictionary["Result"] = result
		}
		if role != nil{
			dictionary["Role"] = role.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         rank = aDecoder.decodeObjectForKey("Rank") as? [Rank]
         result = aDecoder.decodeObjectForKey("Result") as? String
         role = aDecoder.decodeObjectForKey("Role") as? Role

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
		if result != nil{
			aCoder.encodeObject(result, forKey: "Result")
		}
		if role != nil{
			aCoder.encodeObject(role, forKey: "Role")
		}

	}

}