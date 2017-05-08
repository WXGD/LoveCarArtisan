//
//  theme.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  全局公用属性

import UIKit

public let NavigationH: CGFloat = 64
public let AppWidth: CGFloat = UIScreen.main.bounds.size.width
public let AppHeight: CGFloat = UIScreen.main.bounds.size.height
public let MainBounds: CGRect = UIScreen.main.bounds

struct theme {
    ///  APP导航条barButtonItem文字大小
    static let SDNavItemFont: UIFont = UIFont.systemFont(ofSize: 16)
    ///  APP导航条titleFont文字大小
    static let SDNavTitleFont: UIFont = UIFont.systemFont(ofSize: 18)
}
