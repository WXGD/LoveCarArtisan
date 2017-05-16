//
//  ScrollBottomView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ScrollBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollBottomLayoutView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 爱车工匠
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "爱车工匠已陪伴您"
        label.textColor = GrayH4Color
        label.font = TwelveFont
        return label
    }()
    // 提示语View
    lazy var signView: UIView = {
        let view = UIView()
        return view
    }()
    // 提示语
    lazy var signLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = GrayH2Color
        label.font = EighteenFont
        return label
    }()
    // 天
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "天"
        label.textColor = GrayH2Color
        label.font = TwelveFont
        return label
    }()
    // 左分割线
    lazy var leftDividingLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorWith(221, green: 221, blue: 221, alpha: 1)
        return view
    }()
    // 右分割线
    lazy var rightDividingLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorWith(221, green: 221, blue: 221, alpha: 1)
        return view
    }()
    
    func scrollBottomLayoutView() {
        // 爱车工匠
        addSubview(appNameLabel)
        // 提示语View
        addSubview(signView)
        // 提示语
        signView.addSubview(signLabel)
        // 天
        signView.addSubview(dayLabel)
        // 左分割线
        addSubview(leftDividingLineView)
        // 右分割线
        addSubview(rightDividingLineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 爱车工匠
        appNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.setOffset(20);
            make.centerX.equalTo()(self.mas_centerX);
        }
        // 提示语View
        signView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.appNameLabel.mas_bottom)?.setOffset(20);
            make.centerX.equalTo()(self.mas_centerX);
            make.bottom.equalTo()(self.signLabel.mas_bottom);
            make.right.equalTo()(self.dayLabel.mas_right);
        }
        // 提示语
        signLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.signView.mas_top);
            make.left.equalTo()(self.signView.mas_left);
        }
        // 天
        dayLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.signLabel.mas_centerY);
            make.left.equalTo()(self.signLabel.mas_right)?.setOffset(5);
        }
        // 左分割线
        leftDividingLineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.signView.mas_centerY);
            make.right.equalTo()(self.signView.mas_left)?.setOffset(-20);
            make.width.equalTo()(50)
            make.height.equalTo()(1)
        }
        // 右分割线
        rightDividingLineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.signView.mas_centerY);
            make.left.equalTo()(self.signView.mas_right)?.setOffset(20);
            make.width.equalTo()(50)
            make.height.equalTo()(1)
        }
        // self
        mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.signView.mas_bottom)?.setOffset(20);
        }
    }
}
