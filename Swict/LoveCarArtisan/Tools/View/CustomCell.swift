//
//  CustomCell.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class CustomCell: UIView {
    // MARK: 加载控件
    /** 分割线 */
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // MARK: 添加
    private func customCell() {
        
    }
    // MARK: 布局
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
