//
//  CrashViewController.swift
//  Tk300HeroAssistant
//
//  Created by 王卓 on 16/7/5.
//  Copyright © 2016年 SherryTeam. All rights reserved.
//

import UIKit

class CrashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(#selector(CrashViewController.carsh),withObject: nil,afterDelay: 3)
        // Do any additional setup after loading the view.
    }
    func carsh(){
        let pointer:CVaListPointer = CVaListPointer(_fromUnsafeMutablePointer: UnsafeMutablePointer<Void>(nil))
        NSException.raise(NSGenericException, format: "只是测试，模拟一条崩溃信息。", arguments: pointer)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
