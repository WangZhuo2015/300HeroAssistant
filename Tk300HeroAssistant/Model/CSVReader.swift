//
//  CSVReader.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/5/20.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import Foundation
import SwiftCSV
class CSVReader {
    /**
     CSV读取
     
     - parameter fileName:         文件名,路径必须为根目录
     - parameter completionHandle: completionHandle
     */
    class func loadDataFromCSV<T:NSObject>(fileName:String,completionHandle:([T])->Void){
        //异步读取
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv")
            let csvURL = NSURL(fileURLWithPath: filePath!)
            do{
                let csv = try CSV(url: csvURL)
                let dataArray = csv.rows.map({ (dic:[String:String]) -> T in
                    let data = T()
                    dic.forEach({ (key,value) in
                        data.setValue(value, forKey: key)
                    })
                    return data
                })
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandle(dataArray)
                })
            }catch{
                completionHandle([])
            }
        })
    }
    
    
    /**
     CSV读取
     
     - parameter fileName:         文件名,路径必须为根目录
     - parameter completionHandle: completionHandle
     */
    class func loadDataFromCSV<T:NSObject>(fileName:String,keyName:String,orginalDictionary:[String:T] = [String:T](),arrayAttributeName:[String] = [String](),completionHandle:([String:T])->Void){
        //异步读取
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv")
            let csvURL = NSURL(fileURLWithPath: filePath!)
            do{
                let csv = try CSV(url: csvURL)
                var dataDictionary = [String:T]()
                    csv.rows.forEach({ (dic:[String:String]) in
                    //处理每行数据
                        let key = dic[keyName] ?? "error"
                        let data = orginalDictionary[key] ?? T()
                        var arrayAttribute = [String:[String]]()
                        
                        dic.forEach({ (key,value) in
                            //如果是数组类型
                            if arrayAttributeName.contains(key){
                                if arrayAttribute[key] != nil {
                                    arrayAttribute[key]!.append(value)
                                }else{
                                 arrayAttribute[key] = [value]
                                }
                                data.setValue(arrayAttribute[key], forKey: key)
                            }else{
                                //非数组类型
                                data.setValue(value, forKey: key)
                            }
                        })
                        dataDictionary[key] = data
                })
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandle(dataDictionary)
                })
            }catch{
                completionHandle(orginalDictionary)
            }
        })
    
    
    
    
    
//    
//    /**
//     <#Description#>
//     
//     - parameter fileName:         文件名
//     - parameter attributeName:    属性名
//     - parameter orignalArray:     原数组
//     - parameter completionHandle: 回调
//     */
//    class func readArrayFromCSV<T:NSObject>(fileName:String,attributeName:String,orignalArray:[T],completionHandle:([T])->Void){
//        //异步读取
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv")
//            let csvURL = NSURL(fileURLWithPath: filePath!)
//            do{
//                let csv = try CSV(url: csvURL)
//                let dataArray = csv.rows.map({ (dic:[String:String]) -> T in
//                    let data = T()
//                    var array = [String]()
//                    dic.forEach({ (key,value) in
//                        if key == attributeName {
//                            array.append(value)
//                        }else{
//                            data.setValue(value, forKey: key)
//                        }
//                    })
//                    data.setValue(array, forKey: attributeName)
//                    return data
//                })
//                dispatch_async(dispatch_get_main_queue(), {
//                    completionHandle(dataArray)
//                })
//            }catch{
//                completionHandle([])
//            }
//        })
//    }
}