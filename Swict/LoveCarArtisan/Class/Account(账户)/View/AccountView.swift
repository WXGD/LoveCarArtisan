//
//  AccountView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

/** 按钮点击类型 */
public enum AccountBtnAction : Int {
    /** 当前用户 */
    case CurrentUserBtnAction
    /** 设置 */
    case SetUpBtnAction
}


class AccountView: UIView {
    // MARK: 创建控件
    /** 懒加载当前用户 */
    lazy var currentUserView: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn
        view.lineStyle = DividingLineStyle.NotLine
        view.backgroundColor = ThemeColor
        view.mainImg.image = #imageLiteral(resourceName: "account_current_user")
        view.arrowImg.setImage(#imageLiteral(resourceName: "right_arrow_white"), for: UIControlState.normal)
        view.mainLabel.text = "当前用户"
        view.mainLabel.textColor = WhiteColor
        view.mainLabel.font = EighteenFontBold
        view.rightViceLabel.text = "修改密码"
        view.rightViceLabel.textColor = WhiteColor
        view.rightViceLabel.font = ThirteenFont
        view.mainBtn.tag = AccountBtnAction.CurrentUserBtnAction.rawValue
        return view
    }()
    /** 懒加载设置 */
    lazy var setUpView: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn
        view.lineStyle = DividingLineStyle.NotLine
        view.mainImg.image = #imageLiteral(resourceName: "account_set_up")
        view.mainLabel.text = "设置"
        view.mainLabel.font = FifteenFont
        view.mainBtn.tag = AccountBtnAction.SetUpBtnAction.rawValue
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        accountlaoutView()
    }
    
    // MARK: 视图布局
    func accountlaoutView() {
        /** 当前用户 */
        addSubview(currentUserView)
        /** 设置 */
        addSubview(setUpView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /** 当前用户 */
        currentUserView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(65)
        }
        /** 设置 */
        setUpView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.currentUserView.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
    }
}
