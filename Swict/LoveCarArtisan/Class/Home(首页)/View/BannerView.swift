//
//  BannerView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class BannerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        bannerLayoutView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 标题标志
    lazy var titleSignView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor
        return view
    }()
    // 标题
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "工匠资讯"
        label.textColor = BlackColor
        label.font = FourteenFont
        return label
    }()
    // 轮播图
    lazy var bannerView: LLCycleScrollView = {
        let bannerView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 16, y: 10, width: UIScreen.main.bounds.width - 32, height: 150))
        // 是否自动滚动
        bannerView.autoScroll = true
        // 加载状态图
        bannerView.placeHolderImage = #imageLiteral(resourceName: "s1")
        // 没有数据时候的封面图
        bannerView.coverImage = #imageLiteral(resourceName: "s2")
        // 是否无限循环，此属性修改了就不存在轮播的意义了 😄
        bannerView.infiniteLoop = true
        // 滚动间隔时间(默认为2秒)
        bannerView.autoScrollTimeInterval = 2.0
        // 设置图片显示方式=UIImageView的ContentMode
        bannerView.imageViewContentMode = .scaleToFill
        // 设置滚动方向（ vertical || horizontal ）
        bannerView.scrollDirection = .horizontal
        // 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
        bannerView.customPageControlStyle = .snake
        // 非.system的状态下，设置PageControl的tintColor
        bannerView.customPageControlInActiveTintColor = UIColor.white
        bannerView.customPageControlTintColor = ThemeColor;
        // 非.system的状态下，设置PageControl的间距(默认为8.0)
        bannerView.customPageControlIndicatorPadding = 8.0
        return bannerView
    }()
    func bannerLayoutView () {
        // 标题标志
        addSubview(titleSignView)
        // 标题
        addSubview(titleLabel)
        // 轮播图
        addSubview(bannerView)

        
        bannerView.imagePaths = [
            "s3.jpg",
            "http://www.g-photography.net/file_picture/3/3587/4.jpg",
            "http://img2.zjolcdn.com/pic/0/13/66/56/13665652_914292.jpg",
            "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
            "http://img3.redocn.com/tupian/20150806/weimeisheyingtupian_4779232.jpg",
        ]
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 标题标志
        titleSignView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.setOffset(10)
            make.left.equalTo()(self.mas_left)?.setOffset(16)
            make.width.equalTo()(2)
            make.height.equalTo()(20)
        }
        // 标题
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.titleSignView.mas_centerY);
            make.left.equalTo()(self.titleSignView.mas_right)?.setOffset(10);
        }
        // 轮播图
        bannerView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.titleLabel.mas_bottom)?.setOffset(10)
            make.left.equalTo()(self.mas_left)?.setOffset(16)
            make.right.equalTo()(self.mas_right)?.setOffset(-16)
            make.height.equalTo()(150)
        }
        // self
        mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(self.bannerView.mas_bottom)?.setOffset(16);
        }
    }
}
