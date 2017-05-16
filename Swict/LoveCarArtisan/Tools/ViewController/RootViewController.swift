//
//  RootViewController.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 页面基础信息
        rootVCBasicInfo()
    }
    
    // MARK - 页面基础信息
    func rootVCBasicInfo() {
        view.backgroundColor = GrayH6Color
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
