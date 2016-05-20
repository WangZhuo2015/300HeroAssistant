//
//  User.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/9.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
class User {
    var userName = ""
    class var sharedUser: User {
        dispatch_once(&Inner.token) {
            Inner.instance = User()
        }
        return Inner.instance!
    }
    private struct Inner {
        static var instance: User?
        static var token: dispatch_once_t = 0
    }
    func setUserName(name:String){
        userName = name
    }
}