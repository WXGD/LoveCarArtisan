//
//  AloneInfoView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class AloneInfoView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        aloneInfolaoutView()
    }
    // MARK: 创建控件
    /** 账户名view */
    lazy var accountName: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndVImg
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "账户名"
        view.mainLabel.font = FifteenFont
        return view
    }()
    /** 账户手机号view */
    lazy var accountPhone: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndVImg
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "账户手机号"
        view.mainLabel.font = FifteenFont
        return view
    }()
    /** 修改密码view */
    lazy var delPassword: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "修改密码"
        view.mainLabel.font = FifteenFont
        return view
    }()
    // MARK: 视图布局
    func aloneInfolaoutView() {
        /** 账户名view */
        addSubview(accountName)
        /** 账户手机号view */
        addSubview(accountPhone)
        /** 修改密码view */
        addSubview(delPassword)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /** 账户名view */
        accountName.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.setOffset(10)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
        /** 账户手机号view */
        accountPhone.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.accountName.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
        /** 修改密码view */
        delPassword.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.accountPhone.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
    }
}
