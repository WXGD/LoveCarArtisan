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
    
    
    
    /** 服务 */
    lazy var serviceBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "服务"
        return view
    }()
    /** 会员卡 */
    lazy var membershipCardBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "会员卡"
        return view
    }()
    /** 客户 */
    lazy var customerBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "客户"
        return view
    }()
    /**  营销 */
    lazy var marketingBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "营销"
        return view
    }()
    /** 报表 */
    lazy var reportBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "报表"
        return view
    }()
    /** 订单 */
    lazy var orderBtn: ModuleView = {
        let view = ModuleView()
        view.serviceLabel.text = "订单"
        return view
    }()
    
    
    

    
    
    func serviceModuLayoutView() {
        /** 服务 */
        addSubview(serviceBtn)
        /** 会员卡 */
        addSubview(membershipCardBtn)
        /** 客户 */
        addSubview(customerBtn)
        /**  营销 */
        addSubview(marketingBtn)
        /** 报表 */
        addSubview(reportBtn)
        /** 订单 */
        addSubview(orderBtn)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /** 服务 */
        serviceBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.setOffset(16)
            make.top.equalTo()(self.mas_top)
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
            make.right.equalTo()(self.mas_right)?.setOffset(-16)
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
        

        
        
        mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.orderBtn.mas_bottom)
        }
        
    }
}


extension ServiceModuleView {
    
}
