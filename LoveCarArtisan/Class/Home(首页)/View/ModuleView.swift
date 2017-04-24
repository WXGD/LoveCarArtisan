//
//  ModuleView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ModuleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        moduleLayoutView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 服务图片 */
    lazy var serviceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_page_marketing")
        return imageView
    }()
    /** 服务名称 */
    lazy var serviceLabel: UILabel = {
        let label = UILabel()
        label.text = "UIColor.black"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    /** 服务按钮 */
    lazy var serviceBtn: UIButton = {
        let serviceBtn = UIButton(type: UIButtonType.custom)
        return serviceBtn
    }()


    func moduleLayoutView() {
        /** 服务图片 */
        addSubview(serviceImage)
        /** 服务名称 */
        addSubview(serviceLabel)
        /** 服务按钮 */
        addSubview(serviceBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /** 服务图片 */
        serviceImage.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_centerX)
            make.top.equalTo()(self.mas_top)?.setOffset(21)
        }
        /** 服务名称 */
        serviceLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_centerX)
            make.top.equalTo()(self.serviceImage.mas_bottom)?.setOffset(12)
        }
        /** 服务按钮 */
        serviceBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.bottom.equalTo()(self.mas_bottom)
        }
        /** self */
        mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.serviceLabel.mas_bottom)?.setOffset(21)
        }

    }
}
