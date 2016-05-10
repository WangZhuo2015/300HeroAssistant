//
//	Item.swift
//  on 9/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class Item: NSObject, NSCoding{

//    ID        uint    // ID
//    Name      string  // 名称
//    IconFile  string  // 图片相对路径.(在static/images/下)
    var iD : Int!
	var iconFile : String!
	var name : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		iD = json["ID"].intValue
		iconFile = json["IconFile"].stringValue
		name = json["Name"].stringValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if iD != nil{
			dictionary["ID"] = iD
		}
		if iconFile != nil{
			dictionary["IconFile"] = iconFile
		}
		if name != nil{
			dictionary["Name"] = name
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         iD = aDecoder.decodeObjectForKey("ID") as? Int
         iconFile = aDecoder.decodeObjectForKey("IconFile") as? String
         name = aDecoder.decodeObjectForKey("Name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if iD != nil{
			aCoder.encodeObject(iD, forKey: "ID")
		}
		if iconFile != nil{
			aCoder.encodeObject(iconFile, forKey: "IconFile")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "Name")
		}

	}

}