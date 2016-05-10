//
//	MatchRole.swift
//  on 9/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class MatchRole: NSObject, NSCoding{

//    RoleName      string  // 角色名
//    RoleID        uint    // 角色ID
//    RoleLevel     uint    // 角色等级
//    HeroID        uint    // 英雄ID
//    HeroLevel     uint    // 英雄等级
//    Result        uint    // 比赛结果(1:胜利 2:失败 3:逃跑)
//    TeamResult    uint    // 团队比赛结果(1:胜利 0:失败)
//    IsFirstWin    uint    // 是否首胜(1:首胜)
//    KillCount     uint    // 击杀数
//    DeathCount    uint    // 死亡数
//    AssistCount   uint    // 助攻数
//    TowerDestroy  uint    // 建筑摧毁数
//    KillUnitCount uint    // 小兵击杀数
//    TotalMoney    uint    // 金钱总数
//    SkillID       []uint  // 召唤师技能ID
//    EquipID       []uint  // 装备ID
//    RewardMoney   uint    // 金钱奖励
//    RewardExp     uint    // 经验奖励
//    JumpValue     int     // 节操值
//    WinCount      uint    // 胜场数
//    MatchCount    uint    // 总场数
//    ELO           uint    // 团队(胜负)实力
//    KDA           uint    // 本场表现评分
    var assistCount : Int!
	var deathCount : Int!
	var eLO : Int!
	var equip : [Item]!
	var equipID : [Int]!
	var hero : Item!
	var heroID : Int!
	var heroLevel : Int!
	var isFirstWin : Int!
	var jumpValue : Int!
	var kDA : Int!
	var killCount : Int!
	var killUnitCount : Int!
	var matchCount : Int!
	var result : Int!
	var rewardExp : Int!
	var rewardMoney : Int!
	var roleID : Int!
	var roleLevel : Int!
	var roleName : String!
	var skill : [Item]!
	var skillID : [Int]!
	var teamResult : Int!
	var totalMoney : Int!
	var towerDestroy : Int!
	var winCount : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == nil{
			return
		}
		assistCount = json["AssistCount"].intValue
		deathCount = json["DeathCount"].intValue
		eLO = json["ELO"].intValue
		equip = [Item]()
		let equipArray = json["Equip"].arrayValue
		for equipJson in equipArray{
			let value = Item(fromJson: equipJson)
			equip.append(value)
		}
		equipID = [Int]()
		let equipIDArray = json["EquipID"].arrayValue
		for equipIDJson in equipIDArray{
			equipID.append(equipIDJson.intValue)
		}
		let heroJson = json["Hero"]
		if heroJson != JSON.null{
			hero = Item(fromJson: heroJson)
		}
		heroID = json["HeroID"].intValue
		heroLevel = json["HeroLevel"].intValue
		isFirstWin = json["IsFirstWin"].intValue
		jumpValue = json["JumpValue"].intValue
		kDA = json["KDA"].intValue
		killCount = json["KillCount"].intValue
		killUnitCount = json["KillUnitCount"].intValue
		matchCount = json["MatchCount"].intValue
		result = json["Result"].intValue
		rewardExp = json["RewardExp"].intValue
		rewardMoney = json["RewardMoney"].intValue
		roleID = json["RoleID"].intValue
		roleLevel = json["RoleLevel"].intValue
		roleName = json["RoleName"].stringValue
		skill = [Item]()
		let skillArray = json["Skill"].arrayValue
		for skillJson in skillArray{
			let value = Item(fromJson: skillJson)
			skill.append(value)
		}
		skillID = [Int]()
		let skillIDArray = json["SkillID"].arrayValue
		for skillIDJson in skillIDArray{
			skillID.append(skillIDJson.intValue)
		}
		teamResult = json["TeamResult"].intValue
		totalMoney = json["TotalMoney"].intValue
		towerDestroy = json["TowerDestroy"].intValue
		winCount = json["WinCount"].intValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if assistCount != nil{
			dictionary["AssistCount"] = assistCount
		}
		if deathCount != nil{
			dictionary["DeathCount"] = deathCount
		}
		if eLO != nil{
			dictionary["ELO"] = eLO
		}
		if equip != nil{
			var dictionaryElements = [NSDictionary]()
			for equipElement in equip {
				dictionaryElements.append(equipElement.toDictionary())
			}
			dictionary["Equip"] = dictionaryElements
		}
		if equipID != nil{
			dictionary["EquipID"] = equipID
		}
		if hero != nil{
			dictionary["Hero"] = hero.toDictionary()
		}
		if heroID != nil{
			dictionary["HeroID"] = heroID
		}
		if heroLevel != nil{
			dictionary["HeroLevel"] = heroLevel
		}
		if isFirstWin != nil{
			dictionary["IsFirstWin"] = isFirstWin
		}
		if jumpValue != nil{
			dictionary["JumpValue"] = jumpValue
		}
		if kDA != nil{
			dictionary["KDA"] = kDA
		}
		if killCount != nil{
			dictionary["KillCount"] = killCount
		}
		if killUnitCount != nil{
			dictionary["KillUnitCount"] = killUnitCount
		}
		if matchCount != nil{
			dictionary["MatchCount"] = matchCount
		}
		if result != nil{
			dictionary["Result"] = result
		}
		if rewardExp != nil{
			dictionary["RewardExp"] = rewardExp
		}
		if rewardMoney != nil{
			dictionary["RewardMoney"] = rewardMoney
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
		if skill != nil{
			var dictionaryElements = [NSDictionary]()
			for skillElement in skill {
				dictionaryElements.append(skillElement.toDictionary())
			}
			dictionary["Skill"] = dictionaryElements
		}
		if skillID != nil{
			dictionary["SkillID"] = skillID
		}
		if teamResult != nil{
			dictionary["TeamResult"] = teamResult
		}
		if totalMoney != nil{
			dictionary["TotalMoney"] = totalMoney
		}
		if towerDestroy != nil{
			dictionary["TowerDestroy"] = towerDestroy
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
         assistCount = aDecoder.decodeObjectForKey("AssistCount") as? Int
         deathCount = aDecoder.decodeObjectForKey("DeathCount") as? Int
         eLO = aDecoder.decodeObjectForKey("ELO") as? Int
         equip = aDecoder.decodeObjectForKey("Equip") as? [Item]
         equipID = aDecoder.decodeObjectForKey("EquipID") as? [Int]
         hero = aDecoder.decodeObjectForKey("Hero") as? Item
         heroID = aDecoder.decodeObjectForKey("HeroID") as? Int
         heroLevel = aDecoder.decodeObjectForKey("HeroLevel") as? Int
         isFirstWin = aDecoder.decodeObjectForKey("IsFirstWin") as? Int
         jumpValue = aDecoder.decodeObjectForKey("JumpValue") as? Int
         kDA = aDecoder.decodeObjectForKey("KDA") as? Int
         killCount = aDecoder.decodeObjectForKey("KillCount") as? Int
         killUnitCount = aDecoder.decodeObjectForKey("KillUnitCount") as? Int
         matchCount = aDecoder.decodeObjectForKey("MatchCount") as? Int
         result = aDecoder.decodeObjectForKey("Result") as? Int
         rewardExp = aDecoder.decodeObjectForKey("RewardExp") as? Int
         rewardMoney = aDecoder.decodeObjectForKey("RewardMoney") as? Int
         roleID = aDecoder.decodeObjectForKey("RoleID") as? Int
         roleLevel = aDecoder.decodeObjectForKey("RoleLevel") as? Int
         roleName = aDecoder.decodeObjectForKey("RoleName") as? String
         skill = aDecoder.decodeObjectForKey("Skill") as? [Item]
         skillID = aDecoder.decodeObjectForKey("SkillID") as? [Int]
         teamResult = aDecoder.decodeObjectForKey("TeamResult") as? Int
         totalMoney = aDecoder.decodeObjectForKey("TotalMoney") as? Int
         towerDestroy = aDecoder.decodeObjectForKey("TowerDestroy") as? Int
         winCount = aDecoder.decodeObjectForKey("WinCount") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if assistCount != nil{
			aCoder.encodeObject(assistCount, forKey: "AssistCount")
		}
		if deathCount != nil{
			aCoder.encodeObject(deathCount, forKey: "DeathCount")
		}
		if eLO != nil{
			aCoder.encodeObject(eLO, forKey: "ELO")
		}
		if equip != nil{
			aCoder.encodeObject(equip, forKey: "Item")
		}
		if equipID != nil{
			aCoder.encodeObject(equipID, forKey: "EquipID")
		}
		if hero != nil{
			aCoder.encodeObject(hero, forKey: "Hero")
		}
		if heroID != nil{
			aCoder.encodeObject(heroID, forKey: "HeroID")
		}
		if heroLevel != nil{
			aCoder.encodeObject(heroLevel, forKey: "HeroLevel")
		}
		if isFirstWin != nil{
			aCoder.encodeObject(isFirstWin, forKey: "IsFirstWin")
		}
		if jumpValue != nil{
			aCoder.encodeObject(jumpValue, forKey: "JumpValue")
		}
		if kDA != nil{
			aCoder.encodeObject(kDA, forKey: "KDA")
		}
		if killCount != nil{
			aCoder.encodeObject(killCount, forKey: "KillCount")
		}
		if killUnitCount != nil{
			aCoder.encodeObject(killUnitCount, forKey: "KillUnitCount")
		}
		if matchCount != nil{
			aCoder.encodeObject(matchCount, forKey: "MatchCount")
		}
		if result != nil{
			aCoder.encodeObject(result, forKey: "Result")
		}
		if rewardExp != nil{
			aCoder.encodeObject(rewardExp, forKey: "RewardExp")
		}
		if rewardMoney != nil{
			aCoder.encodeObject(rewardMoney, forKey: "RewardMoney")
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
		if skill != nil{
			aCoder.encodeObject(skill, forKey: "Skill")
		}
		if skillID != nil{
			aCoder.encodeObject(skillID, forKey: "SkillID")
		}
		if teamResult != nil{
			aCoder.encodeObject(teamResult, forKey: "TeamResult")
		}
		if totalMoney != nil{
			aCoder.encodeObject(totalMoney, forKey: "TotalMoney")
		}
		if towerDestroy != nil{
			aCoder.encodeObject(towerDestroy, forKey: "TowerDestroy")
		}
		if winCount != nil{
			aCoder.encodeObject(winCount, forKey: "WinCount")
		}

	}

}