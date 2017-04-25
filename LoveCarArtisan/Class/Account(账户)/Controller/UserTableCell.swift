//
//  UserTableCell.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {

    var userModel : UserModel? {
        didSet {
            // 用户名
            userNameLabel.text = userModel!.name
            if (userModel!.name as NSString).length == 0 {
                userNameLabel.text = "无姓名"
            }
            // 用户手机号
            userPhoneLabel.text = String.init(format: "%ld", userModel!.mobile)
            // 车牌号
            if (userModel!.car_plate_no! as NSString).length == 0 {
                plnView.isHidden = true
            }
            plnLabel.text = userModel!.car_plate_no
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        userTableCellLayoutView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 用户名
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "用户名"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.BlackColor
        return label
    }()
    // 用户手机号
    private lazy var userPhoneLabel: UILabel = {
        let label = UILabel()
        label.text = "用户手机号"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.GrayH1
        return label
    }()
    // 尖头
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "right_arrow")
        return imageView
    }()
    // 车牌号view
    private lazy var plnView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorWithHex("f0f9ff")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor.DividingLine.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
    
    // 车牌号label
    private lazy var plnLabel: UILabel = {
        let label = UILabel()
        label.text = "车牌号"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.BlackColor
        return label
    }()
    
    func userTableCellLayoutView() {
        // 用户名
        contentView.addSubview(userNameLabel)
        // 用户手机号
        contentView.addSubview(userPhoneLabel)
        // 尖头
        contentView.addSubview(arrowImage)
        // 车牌号view
        contentView.addSubview(plnView)
        // 车牌号label
        plnView.addSubview(plnLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 用户名
        userNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.contentView.mas_centerY)?.setOffset(-5)
            make.left.equalTo()(self.contentView.mas_left)?.setOffset(16)
        }
        // 用户手机号
        userPhoneLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.userNameLabel.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.userNameLabel.mas_left)
        }
        // 尖头
        arrowImage.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.contentView.mas_centerY)
            make.right.equalTo()(self.contentView.mas_right)?.setOffset(-16)
        }
        // 车牌号view
        plnView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.contentView.mas_centerY)
            make.right.equalTo()(self.arrowImage.mas_left)?.setOffset(-16)
            make.left.equalTo()(self.plnLabel.mas_left)?.setOffset(-10)
            make.height.mas_equalTo()(20)
        }
        // 车牌号label
        plnLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.plnView.mas_centerY);
            make.centerX.equalTo()(self.plnView.mas_centerX);
        }
    }
}
