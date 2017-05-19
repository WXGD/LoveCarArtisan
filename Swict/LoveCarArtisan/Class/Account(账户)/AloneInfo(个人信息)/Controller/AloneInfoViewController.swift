//
//  AloneInfoViewController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class AloneInfoViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 布局NAV
        aloneInfoLayoutNAV()
        // 添加视图
        addAloneInfoLayoutView()
    }
    // MARK: 网络请求
    
    // MARK: 按钮点击方法
    func aloneInfoButtonAction(button: UIButton) {
        
    }
    // MARK: 布局NAV
    private func aloneInfoLayoutNAV() {
        navigationItem.title = "个人信息"
    }
    // MARK: 创建控件
    /** 个人信息view */
    lazy var aloneInfoView: AloneInfoView = {
        let view = AloneInfoView()
        return view
    }()
    // MARK: 添加视图
    private func addAloneInfoLayoutView() {
        /** 个人信息view */
        view.addSubview(aloneInfoView)
    }
    // MARK: 布局视图
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /** 个人信息view */
        aloneInfoView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.view.mas_top)
            make.left.equalTo()(self.view.mas_left)
            make.right.equalTo()(self.view.mas_right)
            make.bottom.equalTo()(self.view.mas_bottom)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
