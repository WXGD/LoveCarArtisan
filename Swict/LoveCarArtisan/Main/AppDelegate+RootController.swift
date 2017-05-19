//
//  AppDelegate+RootController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    // window实例
    func setAppWindows() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        createLoadingScrollView()
        window?.makeKeyAndVisible()
    }
    // 加载窗口控制器
    func createLoadingScrollView() {
        // 取出上一次的版本号
        let lastVersion:String = UserDefaults.standard.object(forKey: "build") as! String
        // 判断
        if BUILD == lastVersion {
            // 判断是否登陆
            window?.rootViewController = TabBarViewController()
        }else {
            window?.rootViewController = TabBarViewController()
            // 当版本号不同的时候，保存版本号
            UserDefaults.standard.set(BUILD, forKey: "build");
            UserDefaults.standard.synchronize()
        }
    }
}
