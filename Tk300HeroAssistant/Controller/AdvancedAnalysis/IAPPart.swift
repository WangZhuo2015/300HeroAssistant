//
//  IAPPart.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/6/11.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit
import StoreKit
import PKHUD
extension PersonalInfoViewController:SKProductsRequestDelegate,SKPaymentTransactionObserver{
    func buyButton(){
        if SKPaymentQueue.canMakePayments() {
            let set = NSSet(array: ["AdvancedFunctionPackage"])
            requestProducts(set)
        }else{
            print("不允许IAP")
        }
    }
    
    /****************************************************************************
     ******************************可调用的方法*************************************
     *****************************************************************************/
    
    /**
     向苹果服务器请求可销售商品,填写itunes connect中添加的商品id
     Set Example: let set = NSSet(array: ["com.secstudio.neonboard.light_bulb"])
     */
    
    internal func requestProducts(set: NSSet){
        let request = SKProductsRequest(productIdentifiers: set as! Set<String>)
        request.delegate = self;
        request.start()
    }
    
    internal func restoreProducts(productId: String){
        self.restorePurchase();
    }
    
    /**
     点击购买产品后触发的
     */
    internal func purchaseProduct(productId: String){
        //先判断是否支持内购
        if(SKPaymentQueue.canMakePayments()){
            guard productDict != nil else{
                print("商品列表还未加载")
                return
            }
            buyProduct(productDict[productId] as! SKProduct)
        }
        else{
            HUD.flash(.Label("未打开App内部购买功能"))
            print("不支持内购功能")
            removeTransactionObserver()
        }
        
    }
    
    /****************************************************************************
     ******************************购买业务中需要实现的方法***************************
     *****************************************************************************/
    
    /**
     商品列表请求成功后的回调函数
     */
    internal func afterRequestProducts(){
        //商品列表请求成功
        purchaseProduct("AdvancedFunctionPackage")
        //HUD.flash(.LabeledProgress(title: "购买中ing", subtitle: "请等待"))
    }
    
    /**
     商品购买成功后的方法
     */
    internal func productPurchased(transaction: SKPaymentTransaction){
        AppManager.boughtIAP()
        HUD.flash(.LabeledSuccess(title: "成功", subtitle: "购买成功"))
        //重写方法，购买成功
    }
    
    /**
     商品购买失败后的方法
     */
    internal func productFailed(transaction: SKPaymentTransaction){
        HUD.flash(.LabeledError(title: "错误", subtitle: "购买失败"),delay: 1)
        //重写方法，购买失败
    }
    
    /**
     商品重复购买时需要回复用户的商品
     */
    internal func productRestored(transaction: SKPaymentTransaction){
        AppManager.boughtIAP()
        HUD.flash(.LabeledSuccess(title: "成功", subtitle: "内购恢复成功"))
        //重写方法，重复购买
    }
    
    internal func productPurchasing(transaction: SKPaymentTransaction){
        HUD.flash(.LabeledProgress(title: "购买中ing", subtitle: "正在购买"))
        //商品购买正在处理
    }
    internal func productDeferred(transaction: SKPaymentTransaction){
        //商品购买推迟
    }
    
    internal func productRestoreFailed(error: NSError){
        HUD.flash(.LabeledError(title: "错误", subtitle: "恢复购买失败"),delay: 1)
        //恢复内购失败
    }
    
    
    /****************************************************************************
     ******************************下面的方法就别动了*******************************
     *****************************************************************************/
    
    // 以上查询的回调函数
    internal func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        if ( productDict == nil) {
            print("product loaded nil")
            productDict = NSMutableDictionary(capacity: response.products.count)
        }
        for product in response.products  {
            // 激活了对应的销售操作按钮，相当于商店的商品上架允许销售
            print("product loaded")
            //            print("Product id:\(product.productIdentifier)")
            //            print("产品标题:\(product.localizedTitle)")
            //            print("产品描述信息:\(product.localizedDescription)")
            //            print("价格: \(product.price)")
            // 填充商品字典
            productDict.setObject(product, forKey: product.productIdentifier)
        }
        afterRequestProducts()
    }
    
    
    private func addTransactionObserver(){
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
    }
    func removeTransactionObserver(){
        SKPaymentQueue.defaultQueue().removeTransactionObserver(self)
    }
    
    private func restorePurchase(){
        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }
    
    // 购买对应的产品
    private func buyProduct(product: SKProduct){
        let payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    internal func paymentQueue(queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: NSError) {
        print(error)
        productRestoreFailed(error)
    }
    internal func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        print("finished restore")
    }
    
    internal func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]){
        // 调试
        for transaction in transactions {
            // 如果小票状态是购买完成
            if (SKPaymentTransactionState.Purchased == transaction.transactionState) {
                // 更新界面或者数据，把用户购买得商品交给用户
                // 验证购买凭据
                self.verifyPruchase()
                productPurchased(transaction)
                // 将交易从交易队列中删除
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                
            }
            else if(SKPaymentTransactionState.Failed == transaction.transactionState){
                productFailed(transaction)
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            }
            else if (SKPaymentTransactionState.Restored == transaction.transactionState) {
                // 恢复购买
                // 更新界面或者数据，把用户购买得商品交给用户
                productRestored(transaction)
                // 将交易从交易队列中删除
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            }else if(SKPaymentTransactionState.Purchasing == transaction.transactionState){
                productPurchasing(transaction)
                print("purchasing")
            }else if(SKPaymentTransactionState.Deferred == transaction.transactionState){
                productDeferred(transaction)
                print("Deferred")
            }
            
        }
        
    }
    
    
    private func verifyPruchase(){
        // 验证凭据，获取到苹果返回的交易凭据
        // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
        let receiptURL = NSBundle.mainBundle().appStoreReceiptURL
        // 从沙盒中获取到购买凭据
        let receiptData = NSData(contentsOfURL: receiptURL!)
        // 发送网络POST请求，对购买凭据进行验证
        let url = NSURL(string: ITMS_SANDBOX_VERIFY_RECEIPT_URL)
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        let encodeStr = receiptData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
        
        let payload = NSString(string: "{\"receipt-data\" : \"" + encodeStr! + "\"}")
        //        print(payload)
        let payloadData = payload.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = payloadData;
        
        let session = NSURLSession.sharedSession()
        let semaphore = dispatch_semaphore_create(0)
        
        let dataTask = session.dataTaskWithRequest(request,
                                                   completionHandler: {(data, response, error) -> Void in
                                                    if error != nil{
                                                        print(error?.code)
                                                        print(error?.description)
                                                    }else{
                                                        
                                                        //                    let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
                                                        //                    print(str)
                                                        // 官方验证结果为空
                                                        if (data==nil) {
                                                            //验证失败
                                                            return
                                                        }
                                                        do{
                                                            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                                                            if (jsonResult.count != 0) {
                                                                // 比对字典中以下信息基本上可以保证数据安全
                                                                // bundle_id&application_version&product_id&transaction_id
                                                                // 凭证验证成功
                                                                let receipt = jsonResult["receipt"] as! NSDictionary
                                                                print(receipt["bundle_id"])
                                                            }
                                                        }catch{
                                                            print("验证凭证出错")
                                                        }
                                                    }
                                                    
                                                    dispatch_semaphore_signal(semaphore)
        }) as NSURLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
}