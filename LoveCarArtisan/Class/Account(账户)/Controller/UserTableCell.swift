//
//  UserTableCell.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {

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
    
    func userTableCellLayoutView() {
        // 用户名
        contentView.addSubview(userNameLabel)
        // 用户手机号
        contentView.addSubview(userPhoneLabel)
        // 尖头
        contentView.addSubview(arrowImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 用户名
        userNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.mas_equalTo()(self.contentView.mas_centerY)?.setOffset(-5)
            make.left.mas_equalTo()(self.contentView.mas_left)?.setOffset(16)
        }
        // 用户手机号
        userPhoneLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.userNameLabel.mas_bottom)?.setOffset(10)
            make.left.mas_equalTo()(self.userNameLabel.mas_left)
        }
        // 尖头
        arrowImage.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self.contentView.mas_centerY)
            make.right.mas_equalTo()(self.contentView.mas_right)?.setOffset(-16)
        }
    }
}
