//
//  TabBarViewController.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 遵守tabbar代理
//        self.delegate = self as? UITabBarControllerDelegate;
        // tabBar不透明
        self.tabBar.isTranslucent = false;
        // 设置子控制器
        addChildVC(HomeViewController(), title: "首页", image: "tab_account_normal", selectedImage: "tab_account_pressed")
        addChildVC(NewsViewController(), title: "消息", image: "tab_news_normal", selectedImage: "tab_news_pressed")
        addChildVC(AccountViewController(), title: "我的", image: "tab_account_normal", selectedImage: "tab_account_pressed")
    }

    func addChildVC(_ viewController: UIViewController, title:NSString, image:NSString, selectedImage:NSString) {
        viewController.title = title as String;
        viewController.tabBarItem.image = UIImage(named:image as String);
        // 声明这张图片按照原始样子显示出来，不要自动渲染
        viewController.tabBarItem.selectedImage = UIImage(named:selectedImage as String)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        // 设置文字选中的样式
        let selectedtextAttrs: NSMutableDictionary = NSMutableDictionary()
        selectedtextAttrs[NSForegroundColorAttributeName] = ThemeColor;
        viewController.tabBarItem.setTitleTextAttributes(selectedtextAttrs as? [String : Any], for: UIControlState.selected)
        // 设置导航栏,添加为子控制器
        self.addChildViewController(NavigationViewController.init(rootViewController: viewController))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}







