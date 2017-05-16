//
//  CustomCell.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

public enum CustomCellStyle : Int {
    /** 所有控件横向布局 */
    case AllViewHorizontalLayout
    /** 大图片，文字纵向布局 */
    case BigPictureVerticallyLayout
    /** 描述信息为图片 */
    case DescribeImageHorizontalLayout
    /** 描述信息有图片和文字 */
    case DescribeImageTextHorizontalLayout
    /** 所有控件纵向居中分布 */
    case AllViewVerticallyCenterLayout
    /** 副标题为输入框 */
    case ViceTextFiledHorizontalLayout
    /** 只有一个输入框输入框 */
    case OnlyTextFiledLayout
}


public enum DividingLineStyle : Int {
    /** 全屏 */
    case FullScreenLayout
    /** 居中 */
    case CenterLayout
    /** 局右 */
    case RightLayout
    /** 没有分割线 */
    case NotLine
}





class CustomCell: UIView {
    // MARK: 定义控件
    var cellStyle: CustomCellStyle = CustomCellStyle.AllViewHorizontalLayout
    /** view样式 */
    var lineStyle: DividingLineStyle = DividingLineStyle.FullScreenLayout
    // MARK: 加载控件
    /** 分割线 */
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    /** 主图片 */
    lazy var mainImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    /** 主标题 */
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = FourteenFont
        label.textColor = BlackColor
        return label
    }()
    /** 左边副标题 */
    lazy var leftViceLabel: UILabel = {
        let label = UILabel()
        label.font = TwelveFont
        label.textColor = GrayH1Color
        return label
    }()
    /** 右边副标题 */
    lazy var rightViceLabel: UILabel = {
        let label = UILabel()
        label.font = TwelveFont
        label.textColor = GrayH1Color
        return label
    }()
    /** 副输入框 */
    lazy var viceTF: UITextField = {
        let textField = UITextField()
        textField.font = FourteenFont
        textField.textColor = BlackColor
        return textField
    }()
    /** 箭头图片 */
    lazy var arrowImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "right_arrow")
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // MARK: 添加
    private func customCell() {
        /** 分割线 */
        addSubview(lineView)
        /** 主图片 */
        addSubview(mainImg)
        /** 主标题 */
        addSubview(mainLabel)
        /** 左边副标题 */
        addSubview(leftViceLabel)
        /** 右边副标题 */
        addSubview(rightViceLabel)
        /** 副输入框 */
        addSubview(viceTF)
        /** 箭头图片 */
        addSubview(arrowImg)
    }
    // MARK: 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /** 主图片 */
        mainImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            
        }
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            
        }
        /** 右边副标题 */
        rightViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            
        }
        /** 副输入框 */
        viceTF.mas_makeConstraints { (make: MASConstraintMaker!) in
            
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            
        }
    }
    
    
    // MARK: 分割线布局方式
    private func lineLayout() {
        switch lineStyle {
            /** 全屏 */
        case DividingLineStyle.FullScreenLayout:
            /** 分割线 */
            lineView.mas_makeConstraints { (make: MASConstraintMaker!) in
                make.left.equalTo()(self.mas_left);
                make.right.equalTo()(self.mas_right);
                make.bottom.equalTo()(self.mas_bottom);
                make.height.mas_equalTo()(0.5);
            }
            break
            /** 居中 */
        case DividingLineStyle.CenterLayout:
            break
            /** 局右 */
        case DividingLineStyle.RightLayout:
            break
            /** 没有分割线 */
        case DividingLineStyle.NotLine:
            break
        }
    }
}
