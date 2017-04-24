//
//  HomeViewController.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class HomeViewController: RootViewController {

    //MARK: 懒加载实时数据View
    lazy var showDataView: ShowDataView = {
        let view = ShowDataView()
        view.backgroundColor = UIColor.WhiteColor
        return view
    }()
    //MARK: 懒加载服务模块View
    lazy var serviceModuleView: ServiceModuleView = {
        let view = ServiceModuleView()
        view.backgroundColor = UIColor.WhiteColor
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
        // 实时数据
        view.addSubview(showDataView)
        // 服务模块
        view.addSubview(serviceModuleView)

        

    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 实时数据
        showDataView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.view.mas_top)
            make.left.mas_equalTo()(self.view.mas_left)
            make.right.mas_equalTo()(self.view.mas_right)
        }
        // 服务模块
        serviceModuleView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.showDataView.mas_bottom)
            make.left.mas_equalTo()(self.view.mas_left)
            make.right.mas_equalTo()(self.view.mas_right)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
