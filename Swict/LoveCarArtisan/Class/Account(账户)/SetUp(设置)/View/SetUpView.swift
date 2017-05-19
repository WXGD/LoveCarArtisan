//
//  SetUpView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class SetUpView: UIView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUplaoutView()
    }
    
    // MARK: 创建控件
    /** 清除缓存 */
    lazy var clearCacheView: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "清除缓存"
        view.mainLabel.font = FifteenFont
        return view
    }()
    /** 当前版本 */
    lazy var currentVersionView: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.ViceTFHorizontalLayoutNotMImgAndNotVImg
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "当前版本"
        view.mainLabel.font = FifteenFont
        return view
    }()
    /** 意见反馈 */
    lazy var feedbackView: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "意见反馈"
        view.mainLabel.font = FifteenFont
        return view
    }()
    /** 关于我们 */
    lazy var aboutUsView: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "关于我们"
        view.mainLabel.font = FifteenFont
        return view
    }()
    /** 客服电话 */
    lazy var serviceNumView: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "客服电话"
        view.mainLabel.font = FifteenFont
        return view
    }()
    /** 功能介绍 */
    lazy var funcIntroView: CustomCell = {
        let view = CustomCell()
        view.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
        view.lineStyle = DividingLineStyle.NotLine
        view.mainLabel.text = "功能介绍"
        view.mainLabel.font = FifteenFont
        return view
    }()
    /** 退出当前账户 */
    lazy var signOutBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = ThemeColor
        button.setTitle("退出当前账户", for: UIControlState.normal)
        button.setTitleColor(WhiteColor, for: UIControlState.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 2
        return button
    }()
    
    // MARK: 视图布局
    func setUplaoutView() {
        /** 清除缓存 */
        addSubview(clearCacheView)
        /** 当前版本 */
        addSubview(currentVersionView)
        /** 意见反馈 */
        addSubview(feedbackView)
        /** 关于我们 */
        addSubview(aboutUsView)
        /** 客服电话 */
        addSubview(serviceNumView)
        /** 功能介绍 */
        addSubview(funcIntroView)
        /** 退出当前账户 */
        addSubview(signOutBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /** 清除缓存 */
        clearCacheView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.setOffset(10)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
        /** 功能介绍 */
        funcIntroView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.clearCacheView.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
        /** 当前版本 */
        currentVersionView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.funcIntroView.mas_bottom)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
        /** 客服电话 */
        serviceNumView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.currentVersionView.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
        /** 意见反馈 */
        feedbackView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.serviceNumView.mas_bottom)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
        /** 关于我们 */
        aboutUsView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.feedbackView.mas_bottom)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.mas_equalTo()(50)
        }
        /** 退出当前账户 */
        signOutBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.aboutUsView.mas_bottom)?.setOffset(20)
            make.left.equalTo()(self.mas_left)?.setOffset(16)
            make.right.equalTo()(self.mas_right)?.setOffset(-16)
            make.height.mas_equalTo()(50)
        }
    }

}
