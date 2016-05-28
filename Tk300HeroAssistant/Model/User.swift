//
//  User.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/9.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
class User {
    var userName:String? = nil
    private var storedNames = [String](){
        didSet{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(storedNames, forKey: "names")
        }
    }
    class var sharedUser: User {
        dispatch_once(&Inner.token) {
            Inner.instance = User()
        }
        return Inner.instance!
    }
    private init(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        storedNames = (userDefaults.arrayForKey("names") as? [String]) ?? []
    }
    
    private struct Inner {
        static var instance: User?
        static var token: dispatch_once_t = 0
    }
    func setUserName(name:String?){
        userName = name
        if let settinName = name{
            if !storedNames.contains(settinName){
                storedNames.append(settinName)
            }
        }
        NSUserDefaults.standardUserDefaults().setObject(User.sharedUser.userName, forKey: "userName")
    }
    func getNames() -> [String]{
        return storedNames
    }
    class func deleteUserName(name:String){
        if name == User.sharedUser.userName{
            User.sharedUser.setUserName(nil)
        }
        User.sharedUser.storedNames = User.sharedUser.storedNames.filter{ $0 != name }
    }
    
    class func login(name:String,successHandle:()->Void,failHandle:(reaon:String?)->Void){
        ServiceProxy.isIDvalid(name, complete: { (result, reason, error) in
            if result{
                User.sharedUser.setUserName(name)
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userChangedNotification, object: nil))
                successHandle()
            }
            else{failHandle(reaon: reason)}
        })
    }
}