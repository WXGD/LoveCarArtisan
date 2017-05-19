//
//  AccountViewController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class AccountViewController: RootViewController {
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
        // 布局NAV
        accountLayoutNAV()
        // 添加视图
        addAccountLayoutView()
    }
    // MARK: 网络请求
    
    // MARK: 按钮点击方法
    func accountButtonAction(button: UIButton) {
        switch button.tag {
            /** 当前用户 */
        case AccountBtnAction.CurrentUserBtnAction.rawValue:
            navigationController?.pushViewController(AloneInfoViewController(), animated: true)
            break
            /** 设置 */
        case AccountBtnAction.SetUpBtnAction.rawValue:
            navigationController?.pushViewController(SetUpViewController(), animated: true)
            break
        default:
            break
        }
    }
    // MARK: 布局NAV
    private func accountLayoutNAV() {
        
    }
    // MARK: 创建控件
    lazy var accountView: AccountView = {
        let view = AccountView()
        return view
    }()
    // MARK: 添加视图
    private func addAccountLayoutView() {
        /** 懒加载当前用户 */
        accountView.currentUserView.mainBtn.addTarget(self, action: #selector(accountButtonAction(button:)), for: UIControlEvents.touchUpInside)
        /** 懒加载设置 */
        accountView.setUpView.mainBtn.addTarget(self, action: #selector(accountButtonAction(button:)), for: UIControlEvents.touchUpInside)
        // 我的
        view.addSubview(accountView)
    }
    // MARK: 布局视图
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 我的
        accountView.mas_makeConstraints { (make: MASConstraintMaker!) in
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
