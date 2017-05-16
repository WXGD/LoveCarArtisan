//
//  ShowDataView.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ShowDataView: UIView {
    /** 实时订单背景view */
    lazy var showDataBackView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor
        return view
    }()
    lazy var showDataBackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "home_show_back")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    /** 营业额 */
    lazy var turnoverTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "今日营业总额"
        label.font = FourteenFont
        label.textColor = UIColor.colorWith(255, green: 255, blue: 255, alpha: 0.8)
        return label
    }()
    lazy var turnoverLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = FortyFiveFont
        label.textColor = WhiteColor
        return label
    }()
    lazy var chiefLabel: UILabel = {
        let label = UILabel()
        label.text = "元"
        label.font = FourteenFont
        label.textColor = WhiteColor
        return label
    }()
    /** 订单数 */
    lazy var orderNumView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var orderNumTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "今日订单数"
        label.font = ThirteenFont
        label.textColor = UIColor.colorWith(255, green: 255, blue: 255, alpha: 0.6)
        return label
    }()
    lazy var orderNumLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = TwelveFont
        label.textColor = WhiteColor
        return label
    }()
    /** 分割线 */
    lazy var dividingLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorWith(255, green: 255, blue: 255, alpha: 0.4)
        return view
    }()
    /** 消费人数 */
    lazy var csmPleNumView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var csmPleNumTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "今日服务人数"
        label.font = ThirteenFont
        label.textColor = UIColor.colorWith(255, green: 255, blue: 255, alpha: 0.6)
        return label
    }()
    lazy var csmPleNumLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = TwelveFont
        label.textColor = WhiteColor
        return label
    }()
    /** 收银，扫一扫view */
    lazy var cashierScanImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "home_cashier_scan")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    /** 收银 */
    lazy var cashierBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("收银", for: UIControlState.normal)
        button.setTitleColor(ThemeColor, for: UIControlState.normal)
        button.titleLabel?.font = FifteenFont
        return button
    }()
    /** 分割线 */
    lazy var cashierScanLineView: UIView = {
        let view = UIView()
        view.backgroundColor = GrayH5Color
        return view
    }()
    /** 扫一扫 */
    lazy var scanBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(#imageLiteral(resourceName: "home_page_scan"), for: UIControlState.normal)
        button.setTitleColor(ThemeColor, for: UIControlState.normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        showDataLayoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showDataLayoutView() {
        /** 实时订单背景view */
        addSubview(showDataBackView)
        showDataBackView.addSubview(showDataBackImage)
        /** 营业额 */
        showDataBackView.addSubview(turnoverTitleLabel)
        showDataBackView.addSubview(turnoverLabel)
        showDataBackView.addSubview(chiefLabel)
        /** 订单数 */
        showDataBackView.addSubview(orderNumView)
        orderNumView.addSubview(orderNumTitleLabel)
        orderNumView.addSubview(orderNumLabel)
        /** 分割线 */
        showDataBackView.addSubview(dividingLineView)
        /** 消费人数 */
        showDataBackView.addSubview(csmPleNumView)
        csmPleNumView.addSubview(csmPleNumTitleLabel)
        csmPleNumView.addSubview(csmPleNumLabel)
        /** 收银，扫一扫view */
        addSubview(cashierScanImage)
        cashierScanImage.addSubview(cashierBtn)
        cashierScanImage.addSubview(cashierScanLineView)
        cashierScanImage.addSubview(scanBtn)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        /** 实时订单背景view */
        showDataBackView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.bottom.equalTo()(self.dividingLineView.mas_bottom)?.setOffset(48)
        }
        showDataBackImage.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.showDataBackView.mas_bottom)
            make.left.equalTo()(self.showDataBackView.mas_left)
            make.right.equalTo()(self.showDataBackView.mas_right)
        }
        /** 营业额 */
        turnoverTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.showDataBackView.mas_centerX)
            make.top.equalTo()(self.showDataBackView.mas_top)?.setOffset(32)
        }
        turnoverLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.showDataBackView.mas_centerX)
            make.top.equalTo()(self.turnoverTitleLabel.mas_bottom)?.setOffset(18)
        }
        chiefLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.turnoverLabel.mas_bottom)?.setOffset(-10)
            make.left.equalTo()(self.turnoverLabel.mas_right)?.setOffset(9)
        }
        /** 订单数 */
        orderNumView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.turnoverLabel.mas_bottom)?.setOffset(36)
            make.left.equalTo()(self.showDataBackView.mas_left)
            make.right.equalTo()(self.dividingLineView.mas_left)
            make.bottom.equalTo()(self.orderNumTitleLabel.mas_bottom)
        }
        orderNumLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.orderNumView.mas_top)
            make.centerX.equalTo()(self.orderNumView.mas_centerX)
        }
        orderNumTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.orderNumLabel.mas_bottom)?.setOffset(12)
            make.centerX.equalTo()(self.orderNumView.mas_centerX)
        }
        /** 分割线 */
        dividingLineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.turnoverLabel.mas_bottom)?.setOffset(36)
            make.centerX.equalTo()(self.showDataBackView.mas_centerX)
            make.width.mas_equalTo()(0.5)
            make.height.mas_equalTo()(40)
        }
        /** 消费人数 */
        csmPleNumView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.turnoverLabel.mas_bottom)?.setOffset(36)
            make.left.equalTo()(self.dividingLineView.mas_right)
            make.right.equalTo()(self.showDataBackView.mas_right)
            make.bottom.equalTo()(self.csmPleNumTitleLabel.mas_bottom)
        }
        csmPleNumLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.csmPleNumView.mas_top)
            make.centerX.equalTo()(self.csmPleNumView.mas_centerX)
        }
        csmPleNumTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.csmPleNumLabel.mas_bottom)?.setOffset(12)
            make.centerX.equalTo()(self.csmPleNumView.mas_centerX)
        }
        /** 收银，扫一扫view */
        cashierScanImage.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.mas_bottom)
            make.centerX.equalTo()(self.mas_centerX)
            make.width.mas_equalTo()(161)
            make.height.mas_equalTo()(60)
        }
        cashierScanLineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.cashierScanImage.mas_centerY)
            make.centerX.equalTo()(self.cashierScanImage.mas_centerX)
            make.width.mas_equalTo()(0.5)
            make.height.mas_equalTo()(20)
        }
        scanBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.cashierScanImage.mas_left)
            make.right.equalTo()(self.cashierScanLineView.mas_left)
            make.top.equalTo()(self.cashierScanImage.mas_top)
            make.bottom.equalTo()(self.cashierScanImage.mas_bottom)
        }
        cashierBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.cashierScanLineView.mas_right)
            make.right.equalTo()(self.cashierScanImage.mas_right)
            make.top.equalTo()(self.cashierScanImage.mas_top)
            make.bottom.equalTo()(self.cashierScanImage.mas_bottom)
        }
        
        // self高度
        mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.showDataBackView.mas_bottom)?.setOffset(30)
        }
    }
    
    
    
}
