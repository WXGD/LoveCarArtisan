//
//  ServiceModuleView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ServiceModuleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        serviceModuLayoutView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 页面控制器
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.VCBackground
        pageControl.currentPageIndicatorTintColor = UIColor.ThemeColor
        return pageControl
    }()
    // 背景scrollView
    private lazy var backScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.clear
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    // 背景View
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    /** 服务 */
    lazy var serviceBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "服务"
        view.serviceImage.image = #imageLiteral(resourceName: "home_page_service")
        return view
    }()
    /** 会员卡 */
    lazy var membershipCardBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "会员卡"
        view.serviceImage.image = #imageLiteral(resourceName: "home_page_user_card")
        return view
    }()
    /** 客户 */
    lazy var customerBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "用户"
        view.serviceImage.image = #imageLiteral(resourceName: "home_page_customer")
        return view
    }()
    /**  营销 */
    lazy var marketingBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "营销"
        view.serviceImage.image = #imageLiteral(resourceName: "home_page_marketing")
        return view
    }()
    /** 报表 */
    lazy var reportBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "报表"
        view.serviceImage.image = #imageLiteral(resourceName: "home_page_report")
        return view
    }()
    /** 订单 */
    lazy var orderBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "订单"
        view.serviceImage.image = #imageLiteral(resourceName: "home_page_order")
        return view
    }()
    /** 商城 */
    lazy var commercialCityBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "商城"
        view.serviceImage.image = #imageLiteral(resourceName: "home_page_commercial_city")
        return view
    }()
    func serviceModuLayoutView() {
        // 页面控制器
        addSubview(pageControl)
        // 背景scrollView
        addSubview(backScrollView)
        // 背景View
        backScrollView.addSubview(backView)
        /** 服务 */
        backView.addSubview(serviceBtn)
        /** 会员卡 */
        backView.addSubview(membershipCardBtn)
        /** 客户 */
        backView.addSubview(customerBtn)
        /**  营销 */
        backView.addSubview(marketingBtn)
        /** 报表 */
        backView.addSubview(reportBtn)
        /** 订单 */
        backView.addSubview(orderBtn)
        /** 商城 */
        backView.addSubview(commercialCityBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 背景scrollView
        backScrollView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.mas_top)
            make.left.mas_equalTo()(self.mas_left)
            make.right.mas_equalTo()(self.mas_right)
            make.bottom.equalTo()(self.orderBtn.mas_bottom)
        }
        // 背景View
        backView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.backScrollView.mas_top)
            make.left.mas_equalTo()(self.backScrollView.mas_left)
            make.right.mas_equalTo()(self.backScrollView.mas_right)
            make.bottom.mas_equalTo()(self.backScrollView.mas_bottom)
            make.width.mas_equalTo()(AppWidth * 2)
            make.height.mas_equalTo()(self.backScrollView.mas_height)
        }
        /** 服务 */
        serviceBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.backView.mas_left)?.setOffset(16)
            make.top.equalTo()(self.backView.mas_top)
            make.width.equalTo()(self.serviceBtn.mas_width)
        }
        /** 会员卡 */
        membershipCardBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.serviceBtn.mas_right)
            make.top.equalTo()(self.serviceBtn.mas_top)
            make.width.equalTo()(self.serviceBtn.mas_width)
        }
        /** 客户 */
        customerBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.membershipCardBtn.mas_right)
            make.right.equalTo()(self.backView.mas_centerX)?.setOffset(-16)
            make.top.equalTo()(self.serviceBtn.mas_top)
            make.width.equalTo()(self.serviceBtn.mas_width)
        }
        /** 营销 */
        marketingBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.serviceBtn.mas_left)
            make.top.equalTo()(self.serviceBtn.mas_bottom)
            make.width.equalTo()(self.serviceBtn.mas_width)
        }
        /** 报表 */
        reportBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.marketingBtn.mas_right)
            make.top.equalTo()(self.marketingBtn.mas_top)
            make.width.equalTo()(self.serviceBtn.mas_width)
        }
        /** 订单 */
        orderBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.reportBtn.mas_right)
            make.right.equalTo()(self.customerBtn.mas_right)
            make.top.equalTo()(self.marketingBtn.mas_top)
            make.width.equalTo()(self.serviceBtn.mas_width)
        }
        /** 商城 */
        commercialCityBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.backView.mas_centerX)?.setOffset(16)
            make.top.equalTo()(self.serviceBtn.mas_top)
            make.width.equalTo()(self.serviceBtn.mas_width)
        }
        // 页面控制器
        pageControl.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.backScrollView.mas_centerX)
            make.top.equalTo()(self.backScrollView.mas_bottom)
            make.width.equalTo()(100)
            make.height.equalTo()(20)
        }
        mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.pageControl.mas_bottom)
        }
    }
}


extension ServiceModuleView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / AppWidth)
    }
}
