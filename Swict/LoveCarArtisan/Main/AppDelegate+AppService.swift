//
//  AppDelegate+AppService.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

extension AppDelegate {
    // 加载第三方
    func loadThirdParty(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        // URL跳转界面
        urlNavController();
    }
    // 重置user-agent
    func resetUserAgent() {
        let webView: UIWebView = UIWebView(frame: CGRect.zero)
        let oldAgent: String = webView.stringByEvaluatingJavaScript(from: "navigator.userAgent")!
        let newAgent: String = oldAgent + " cheweifang"
        let dictionary: Dictionary<String, String> = ["UserAgent":newAgent]
        UserDefaults.standard.register(defaults: dictionary)
    }
    // URL跳转界面
    func urlNavController() {
        DCURLRouter.loadConfigDict(fromPlist: "DCURLRouter.plist")
    }
}
