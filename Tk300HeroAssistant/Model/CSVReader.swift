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
                        if key != ""{
                            data.setValue(value, forKey: key)
                        }
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
     复杂数据读取
     
     - parameter fileName:           文件名
     - parameter keyName:            主键属性名
     - parameter orginalDictionary:  原Dictionary
     - parameter arrayAttributeName: 属性类型的键名
     - parameter completionHandle:   回调函数
     */
    class func loadComplexDataFromCSV<T:NSObject>(fileName:String,keyName:String,orginalDictionary:[String:T] = [String:T](),arrayAttributeName:[String] = [String](),completionHandle:([String:T])->Void){
        //异步读取
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv")
            let csvURL = NSURL(fileURLWithPath: filePath!)
            do{
                let csv = try CSV(url: csvURL)
                //生成一个新的Dictionary并导入原来的
                var dataDictionary = [String:T]()
                orginalDictionary.forEach{dataDictionary[$0.0] = $0.1}
                //遍历行
                csv.rows.forEach({ (dic:[String:String]) in
                    //处理每行数据
                    //在行中找键属性的值
                    let key = dic[keyName] ?? "error"
                    //拿到已保存的元素
                    let data:T = dataDictionary[key] ?? T()
                    //处理行中每一个属性
                    dic.forEach({ (key,value) in
                        //如果是数组类型
                        if arrayAttributeName.contains(key){
                            var stored = data.valueForKey(key) as? [String] ?? []
                            stored.append(value)
                            data.setValue(stored, forKey: key)
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
    }
}