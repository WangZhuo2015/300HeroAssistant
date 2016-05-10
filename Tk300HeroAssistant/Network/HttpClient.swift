//
//  HttpClient.swift
//  EVReflectionTest
//
//  Created by 王卓 on 16/4/26.
//  Copyright © 2016年 BubbleTeam. All rights reserved.
//

import Foundation
import Alamofire
//import EVReflection
//import AlamofireJsonToObjects
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
    
    
    
//    class func invoke (
//        url:String,
//        parameters:[String: AnyObject]? = nil,
//        complete:((response: NSData?, error: NSError?) -> Void)?){
//        Alamofire.request(.GET, url, parameters: parameters, encoding: .URL, headers: [:]).validate(statusCode: 200..<300).responseJSON { (response:Response<AnyObject, NSError>) -> Void in
//            print(response.result.value)
//            if let handle = complete{
//                handle(response: response.data, error: response.result.error)
//            }
//        }
//    }
//    
//    class func invokeObject< T: EVObject >(
//        url:String,
//        parameters:[String: AnyObject]? = nil,
//        complete:(object: T?, error: NSError?) -> Void){
//        print(url)
//        print(parameters)
//
//        Alamofire.request(.GET, url, parameters: nil, encoding: .URL, headers: [:]).validate(statusCode: 200..<300).responseObject { (URLRequest:NSURLRequest?, HTTPURLResponse:NSHTTPURLResponse?, result:Result< T, NSError>) in
//            //print(result.value)
//            complete(object: result.value, error: result.error)
//            }
//    }
}