//
//  NewsCell.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        self.selectionStyle = UITableViewCellSelectionStyle.none
        newsCellLayoutView()
    }
    
    // MARK: 创建控件
    /** 消息时间 */
    lazy var messageTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "2012-03-19 23:00:00"
        label.backgroundColor = UIColor.colorWith(214, green: 214, blue: 214, alpha: 1)
        label.font = TwelveFont
        label.textColor = WhiteColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 2
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    /** 消息具体view */
    lazy var messageSpecificView: UIView = {
        let view = UIView()
        view.backgroundColor = WhiteColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        view.layer.borderWidth = 1
        view.layer.borderColor = GrayH5Color.cgColor
        return view
    }()
    /** 消息类型标志 */
    lazy var messageTypeFlagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "home_page_user")
        return imageView
    }()
    /** 消息名称 */
    lazy var messageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "消息名称"
        label.font = SixteenFont
        label.textColor = BlackColor
        return label
    }()
    /** 消息内容 */
    lazy var messageContentLabel: UILabel = {
        let label = UILabel()
        label.text = "消息内容"
        label.font = TwelveFont
        label.textColor = GrayH1Color
        label.numberOfLines = 0
        return label
    }()
    /** 消息操作 */
    lazy var messageOperationLabel: UILabel = {
        let label = UILabel()
        label.text = "购买正式版"
        label.font = TwelveFont
        label.textColor = UIColor.colorWithHex("ff7043")
        return label
    }()
    // MARK: 布局视图
    private func newsCellLayoutView() {
        /** 消息时间 */
        contentView.addSubview(messageTimerLabel)
        /** 消息具体view */
        contentView.addSubview(messageSpecificView)
        /** 消息类型标志 */
        messageSpecificView.addSubview(messageTypeFlagImage)
        /** 消息名称 */
        messageSpecificView.addSubview(messageNameLabel)
        /** 消息内容 */
        messageSpecificView.addSubview(messageContentLabel)
        /** 消息操作 */
        messageSpecificView.addSubview(messageOperationLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        /** 消息时间 */
        messageTimerLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.setOffset(10)
            make.centerX.equalTo()(self.contentView.mas_centerX);
            make.size.mas_equalTo()(CGSize(width: 139, height: 15))
        }
        /** 消息具体view */
        messageSpecificView.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.messageTimerLabel.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.contentView.mas_left)?.setOffset(16)
            make.right.equalTo()(self.contentView.mas_right)?.setOffset(-16)
            make.bottom.equalTo()(self.messageOperationLabel.mas_bottom)?.setOffset(16)
        }
        /** 消息类型标志 */
        messageTypeFlagImage.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.messageSpecificView.mas_top)?.setOffset(24)
            make.left.equalTo()(self.messageSpecificView.mas_left)?.setOffset(16)
        }
        /** 消息名称 */
        messageNameLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.messageTypeFlagImage.mas_centerY)
            make.left.equalTo()(self.messageTypeFlagImage.mas_right)?.setOffset(10)
        }
        /** 消息内容 */
        messageContentLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.messageTypeFlagImage.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.messageSpecificView.mas_left)?.setOffset(16)
            make.right.equalTo()(self.messageSpecificView.mas_right)?.setOffset(-16)
        }
        /** 消息操作 */
        messageOperationLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.messageContentLabel.mas_bottom)?.setOffset(10)
            make.right.equalTo()(self.messageSpecificView.mas_right)?.setOffset(-16)
        }
    }
}
