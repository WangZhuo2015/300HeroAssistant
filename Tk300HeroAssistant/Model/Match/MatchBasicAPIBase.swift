//
//	MatchBasicAPIBase.swift
//  on 10/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class MatchBasicAPIBase : NSObject, NSCoding{

	var list : [List]!
	var result : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		list = [List]()
		let listArray = json["List"].arrayValue
		for listJson in listArray{
			let value = List(fromJson: listJson)
			list.append(value)
		}
		result = json["Result"].stringValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if list != nil{
			var dictionaryElements = [NSDictionary]()
			for listElement in list {
				dictionaryElements.append(listElement.toDictionary())
			}
			dictionary["List"] = dictionaryElements
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
         list = aDecoder.decodeObjectForKey("List") as? [List]
         result = aDecoder.decodeObjectForKey("Result") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if list != nil{
			aCoder.encodeObject(list, forKey: "List")
		}
		if result != nil{
			aCoder.encodeObject(result, forKey: "Result")
		}

	}

}