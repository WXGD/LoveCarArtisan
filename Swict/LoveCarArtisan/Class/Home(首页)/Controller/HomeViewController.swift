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
        // 布局视图
        homeLayoutView()
        // 请求服务模块数据
        serviceModuleRequestData()
    }
    // MARK: 网络请求
    // 请求服务模块数据
    func serviceModuleRequestData() {
        ServiceModuleModel.requestServiceModuleSuccess { (serviceModelArry: NSMutableArray) in
            self.homeView.serviceModuleView.moduleArray = serviceModelArry
        }
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
        homeView.serviceModuleView.delegate = self
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

extension HomeViewController : ServiceModuleDelegate {
    func moduleBtnDelegate(button: UIButton) {
        let section: NSInteger = button.tag / 1000 % 10
        let row: NSInteger = button.tag / 100 % 10
        let tag: NSInteger = button.tag / 1 % 10
        
        let moduleItem: NSArray = self.homeView.serviceModuleView.moduleArray.object(at: section) as! NSArray
        let itemArray: NSArray = moduleItem.object(at: row) as! NSArray
        let serviceModuleModel: ServiceModuleModel = itemArray.object(at: tag) as! ServiceModuleModel;
        print(section, row, tag, serviceModuleModel.name!)
        
        let menuDic: NSMutableDictionary = NSMutableDictionary()
        
        DCURLRouter.pushURLString(serviceModuleModel.nav_url!, query: menuDic as! [AnyHashable : Any], animated: true)
            
        
    }
}





