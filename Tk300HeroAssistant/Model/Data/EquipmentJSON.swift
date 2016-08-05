//
//	EquipmentJSON.swift
// on 5/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct EquipmentJSON{

	var combineItem : [Int]!
	var combineprice : String!
	var fullPrice : String!
	var id : Int!
	var image : String!
	var info : String!
	var keywords : [String]!
	var name : String!
	var pro : [String]!
	var subItem : [Int]!
	var subPage : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		combineItem = dictionary["combineItem"] as? [Int]
		combineprice = dictionary["combineprice"] as? String
		fullPrice = dictionary["fullPrice"] as? String
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		info = dictionary["info"] as? String
		keywords = dictionary["keywords"] as? [String]
		name = dictionary["name"] as? String
		pro = dictionary["pro"] as? [String]
		subItem = dictionary["subItem"] as? [Int]
		subPage = dictionary["subPage"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if combineItem != nil{
			dictionary["combineItem"] = combineItem
		}
		if combineprice != nil{
			dictionary["combineprice"] = combineprice
		}
		if fullPrice != nil{
			dictionary["fullPrice"] = fullPrice
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if info != nil{
			dictionary["info"] = info
		}
		if keywords != nil{
			dictionary["keywords"] = keywords
		}
		if name != nil{
			dictionary["name"] = name
		}
		if pro != nil{
			dictionary["pro"] = pro
		}
		if subItem != nil{
			dictionary["subItem"] = subItem
		}
		if subPage != nil{
			dictionary["subPage"] = subPage
		}
		return dictionary
	}

}