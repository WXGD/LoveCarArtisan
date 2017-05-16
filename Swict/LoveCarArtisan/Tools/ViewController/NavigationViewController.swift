//
//  NavigationViewController.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    var navBar: UINavigationBar!
    var barItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = UINavigationBar.appearance()
        navBar.isTranslucent = false
        navBar.barTintColor = ThemeColor
        navBar.tintColor = WhiteColor
        navBar.titleTextAttributes = {[
            NSForegroundColorAttributeName: WhiteColor,
            NSFontAttributeName: EighteenFontBold
        ]}()
        barItem = UIBarButtonItem.appearance()
        barItem.setTitleTextAttributes(
            [NSFontAttributeName: FifteenFont]
        , for: UIControlState.normal)
    }

    /** 重写这个方法目的：能够拦截所有push进来的控制器 */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            /* 自动显示和隐藏tabbar */
            viewController.hidesBottomBarWhenPushed = true;
            /* 设置导航栏上面的内容 */
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"nav_back"), style: UIBarButtonItemStyle.done, target: self, action: #selector(back))
        }
        super.pushViewController(viewController, animated: animated)
    }
    func back() {
        popViewController(animated: true)
    }
    
    // 默认是灰色，这里设置成白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
