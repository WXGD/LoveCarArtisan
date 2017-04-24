//
//  HomeView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        homeLayoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 背景scrollView
    private lazy var backScrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    // 背景View
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    // 懒加载实时数据View
    lazy var showDataView: ShowDataView = {
        let view = ShowDataView()
        view.backgroundColor = UIColor.WhiteColor
        return view
    }()
    // 懒加载服务模块View
    lazy var serviceModuleView: ServiceModuleView = {
        let view = ServiceModuleView()
        view.backgroundColor = UIColor.WhiteColor
        return view
    }()
    func homeLayoutView() {
        // 背景scrollView
        addSubview(backScrollView)
        // 背景View
        backScrollView.addSubview(backView)
        // 实时数据
        backView.addSubview(showDataView)
        // 服务模块
        backView.addSubview(serviceModuleView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 背景scrollView
        backScrollView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.mas_top)
            make.left.mas_equalTo()(self.mas_left)
            make.right.mas_equalTo()(self.mas_right)
            make.bottom.mas_equalTo()(self.mas_bottom)
        }
        // 背景View
        backView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.backScrollView.mas_top)
            make.left.mas_equalTo()(self.backScrollView.mas_left)
            make.right.mas_equalTo()(self.backScrollView.mas_right)
            make.bottom.mas_equalTo()(self.backScrollView.mas_bottom)
            make.width.mas_equalTo()(self.backScrollView.mas_width)
            make.height.mas_equalTo()(1000)
        }
        // 实时数据
        showDataView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.backView.mas_top)
            make.left.mas_equalTo()(self.backView.mas_left)
            make.right.mas_equalTo()(self.backView.mas_right)
        }
        // 服务模块
        serviceModuleView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.showDataView.mas_bottom)
            make.left.mas_equalTo()(self.backView.mas_left)
            make.right.mas_equalTo()(self.backView.mas_right)
        }
    }
    
}
