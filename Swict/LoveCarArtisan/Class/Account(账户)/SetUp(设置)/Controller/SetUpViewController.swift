//
//  SetUpViewController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class SetUpViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 布局NAV
        setUpLayoutNAV()
        // 添加视图
        addSetUpLayoutView()
    }
    // MARK: 网络请求
    
    // MARK: 按钮点击方法
    func setUpButtonAction(button: UIButton) {
        
    }
    // MARK: 布局NAV
    private func setUpLayoutNAV() {
        self.navigationItem.title = "设置"
    }
    // MARK: 创建控件
    /** 设置 */
    lazy var setUpView: SetUpView = {
        let view = SetUpView()
        return view
    }()
    // MARK: 添加视图
    private func addSetUpLayoutView() {
        /** 设置 */
        view.addSubview(setUpView)
    }
    // MARK: 布局视图
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /** 设置 */
        setUpView.mas_makeConstraints { (make: MASConstraintMaker!) in
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
