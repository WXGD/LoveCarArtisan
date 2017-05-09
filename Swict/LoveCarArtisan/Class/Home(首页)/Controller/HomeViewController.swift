//
//  HomeViewController.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class HomeViewController: RootViewController {
    // MARK: 首页View
    lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //在页面出现的时候就将黑线隐藏起来
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //在页面消失的时候就让navigationbar还原样式
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        view.backgroundColor = UIColor.orange
        self.navigationItem.titleView = view;
        // 布局视图
        homeLayoutView()
    }
    // MARK: 按钮点击方法
    // 首页按钮操作方法
    func homeButtonAction(button: UIButton) {
        switch button.tag {
            /** 服务管理 */
        case HomeBtnType.ServiceManage.rawValue:
            navigationController?.pushViewController(ServiceViewController(), animated: true)
            break
            /** 客户 */
        case HomeBtnType.Customer.rawValue:
            navigationController?.pushViewController(UserViewController(), animated: true)
            break
        default:
            break
        }
    }
    // MARK: 布局视图
    private func homeLayoutView() {
        // 首页View
        // 用户按钮
        homeView.serviceModuleView.customerBtn.serviceBtn.addTarget(self, action:#selector(homeButtonAction(button:)), for: UIControlEvents.touchUpInside)
        // 服务管理
        homeView.serviceModuleView.serviceBtn.serviceBtn.addTarget(self, action:#selector(homeButtonAction(button:)), for: UIControlEvents.touchUpInside)
        view.addSubview(homeView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 首页View
        homeView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.view.mas_top)
            make.left.mas_equalTo()(self.view.mas_left)
            make.right.mas_equalTo()(self.view.mas_right)
            make.bottom.mas_equalTo()(self.view.mas_bottom)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
