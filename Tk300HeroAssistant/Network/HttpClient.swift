//
//  HttpClient.swift
//  EVReflectionTest
//
//  Created by 王卓 on 16/4/26.
//  Copyright © 2016年 BubbleTeam. All rights reserved.
//

import Foundation
import Alamofire
class HttpClient{
    class func invoke (
        url:String,
        parameters:[String: AnyObject]? = nil,
        complete:((response: NSData?, error: NSError?) -> Void)?){
        Alamofire.Manager.sharedInstance.request(.GET, url, parameters: parameters, encoding: .URL, headers: [:]).validate(statusCode: 200..<300).responseJSON { (response:Response<AnyObject, NSError>) in
            if let handle = complete{
                handle(response: response.data, error: response.result.error)
            }
        }
    }
}