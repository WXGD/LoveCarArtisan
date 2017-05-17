//
//  CustomCell.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

public enum CustomCellStyle : Int {
    /** 所有控件横向布局(没有主图片，没有副图片) */
    case HorizontalLayoutNotMImgAndVImg
    /** 所有控件横向布局(有主图片，没有副图片) */
    case HorizontalLayoutHaveMImgAndNotVImg
    /** 所有控件横向布局(没有主图片，有副图片，有副按钮) */
    case HorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn
    /** 所有控件横向布局(没有主图片，有副图片，没有副按钮) */
    case HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn


//    /** 所有控件横向布局(有主图片，有副图片，有副按钮) */
//    case AllViewHorizontalLayout
//    /** 所有控件横向布局(有主图片，有副图片，没有副按钮) */
//    case AllViewHorizontalLayout
//    /** 大图片，文字纵向布局(没有副图片，没有副按钮) */
//    case BigPictureVerticallyLayout
//    /** 大图片，文字纵向布局(有副图片，没有副按钮) */
//    case BigPictureVerticallyLayout
//    /** 大图片，文字纵向布局(有副图片，有副按钮) */
//    case BigPictureVerticallyLayout
//    /** 副标题为输入框(没有主图片，没有副图片) */
//    case ViceTFHorizontalLayout
//    /** 副标题为输入框(有主图片，没有副图片) */
//    case ViceTFHorizontalLayout
//    /** 副标题为输入框(没有主图片，有副图片) */
//    case ViceTFHorizontalLayout
//    /** 副标题为输入框(没有主图片，有副图片，有副按钮) */
//    case ViceTFHorizontalLayout
//    /** 副标题为输入框(没有主图片，有副图片，没有副按钮) */
//    case ViceTFHorizontalLayout
//    /** 副标题为输入框(有主图片，有副图片，没有副按钮) */
//    case ViceTFHorizontalLayout
//    /** 副标题为输入框(有主图片，有副图片，有副按钮) */
//    case ViceTFHorizontalLayout
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
    var cellStyle: CustomCellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
    /** view样式 */
    var lineStyle: DividingLineStyle = DividingLineStyle.FullScreenLayout
    /** 主图片宽高 */
    var mainImgSize: CGSize?
    /** 左边界距离 */
    var leftBorder: CGFloat = 16
    /** 右边界距离 */
    var rightBorder: CGFloat = -16
    /** 主标题距离主图片 */
    var mmImgStep: CGFloat = 16
    /** 主副标题间距 */
    var mvTitleStep: CGFloat = 16
    /** 右副标题距离右副图片 */
    var rvvImgStep: CGFloat = -16
    
    // MARK: 加载控件
    /** 分割线 */
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = GrayH5Color
        return view
    }()
    /** 主图片 */
    lazy var mainImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "home_page_report")
        return imageView
    }()
    /** 主标题 */
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = FourteenFont
        label.textColor = BlackColor
        label.text = "主标题"
        return label
    }()
    /** 左边副标题 */
    lazy var leftViceLabel: UILabel = {
        let label = UILabel()
        label.font = TwelveFont
        label.textColor = GrayH1Color
        label.text = "左边副标题"
        return label
    }()
    /** 右边副标题 */
    lazy var rightViceLabel: UILabel = {
        let label = UILabel()
        label.font = TwelveFont
        label.textColor = GrayH1Color
        label.text = "右边副标题"
        return label
    }()
    /** 副输入框 */
    lazy var viceTF: UITextField = {
        let textField = UITextField()
        textField.font = FourteenFont
        textField.textColor = BlackColor
        textField.text = "副输入框"
        return textField
    }()
    /** 主按钮 */
    lazy var mainBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        return button
    }()
    /** 箭头图片 */
    lazy var arrowImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "right_arrow")
        return imageView
    }()
    /** 副按钮 */
    lazy var viceBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customCell()
    }
    
    // MARK: 添加
    private func customCell() {
        /** 分割线 */
        addSubview(lineView)
        /** 主标题 */
        addSubview(mainLabel)
        /** 左边副标题 */
        addSubview(leftViceLabel)
        /** 右边副标题 */
        addSubview(rightViceLabel)
        /** 主按钮 */
        addSubview(mainBtn)
        
        // cell样式
        switch cellStyle {
            /** 所有控件横向布局(有主图片，没有副图片) */
        case CustomCellStyle.HorizontalLayoutHaveMImgAndNotVImg:
            /** 主图片 */
            addSubview(mainImg)
            break
            /** 所有控件横向布局(没有主图片，有副图片，有副按钮) */
        case CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn:
            /** 箭头图片 */
            addSubview(arrowImg)
            /** 副按钮 */
            addSubview(viceBtn)
            break
            /** 所有控件横向布局(没有主图片，有副图片，没有副按钮) */
        case CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn:
            /** 箭头图片 */
            addSubview(arrowImg)
            break
        default: break
        }
        
        
        
        
        
        /** 副输入框 */
        addSubview(viceTF)
    }
    // MARK: 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        // 分割线布局方式
        lineLayout()
        // cell样式
        switch cellStyle {
            /** 所有控件横向布局(没有主图片，没有副图片) */
        case CustomCellStyle.HorizontalLayoutNotMImgAndVImg:
            horizontalLayoutNotMImgAndVImg()
            break
            /** 所有控件横向布局(有主图片，没有副图片) */
        case CustomCellStyle.HorizontalLayoutHaveMImgAndNotVImg:
            horizontalLayoutHaveMImgAndNotVImg()
            break
            /** 所有控件横向布局(没有主图片，有副图片，有副按钮) */
        case CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn:
            horizontalLayoutNotMImgAndHaveVImgAndHaveVBtn()
            break
            /** 所有控件横向布局(没有主图片，有副图片，没有副按钮) */
        case CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn:
            horizontalLayoutNotMImgAndHaveVImgAndNotVBtn()
            break
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
            /** 分割线 */
            lineView.mas_makeConstraints { (make: MASConstraintMaker!) in
                make.left.equalTo()(self.mas_left)?.setOffset(16);
                make.right.equalTo()(self.mas_right)?.setOffset(-16);
                make.bottom.equalTo()(self.mas_bottom);
                make.height.mas_equalTo()(0.5);
            }
            break
            /** 局右 */
        case DividingLineStyle.RightLayout:
            /** 分割线 */
            lineView.mas_makeConstraints { (make: MASConstraintMaker!) in
                make.left.equalTo()(self.mas_left)?.setOffset(16);
                make.right.equalTo()(self.mas_right);
                make.bottom.equalTo()(self.mas_bottom);
                make.height.mas_equalTo()(0.5);
            }
            break
            /** 没有分割线 */
        case DividingLineStyle.NotLine:
            /** 分割线 */
            lineView.isHidden = true
            break
        }
    }
    
    // MARK: cell样式布局方式
    /** 所有控件横向布局(没有主图片，没有副图片) */
    private func horizontalLayoutNotMImgAndVImg() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
        }
        /** 右边副标题 */
        rightViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
        }
        /** 主按钮 */
        mainBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left);
            make.right.equalTo()(self.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
        }
    }
    /** 所有控件横向布局(有主图片，没有副图片) */
    private func horizontalLayoutHaveMImgAndNotVImg() {
        /** 主图片 */
        mainImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
            if self.mainImgSize != nil {
                make.size.mas_equalTo()(self.mainImgSize);
            }
        }
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mainImg.mas_right)?.setOffset(self.mmImgStep);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
        }
        /** 右边副标题 */
        rightViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
        }
        /** 主按钮 */
        mainBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left);
            make.right.equalTo()(self.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
        }
    }
    /** 所有控件横向布局(没有主图片，有副图片，有副按钮) */
    private func horizontalLayoutNotMImgAndHaveVImgAndHaveVBtn() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
        }
        /** 副按钮 */
        viceBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right);
            make.left.equalTo()(self.arrowImg.mas_left);
        }
        /** 右边副标题 */
        rightViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.arrowImg.mas_left)?.setOffset(self.rvvImgStep);
        }
        /** 主按钮 */
        mainBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left);
            make.right.equalTo()(self.viceBtn.mas_left);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
        }
    }
    /** 所有控件横向布局(没有主图片，有副图片，没有副按钮) */
    private func horizontalLayoutNotMImgAndHaveVImgAndNotVBtn() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
        }
        /** 右边副标题 */
        rightViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.arrowImg.mas_left)?.setOffset(self.rvvImgStep);
        }
        /** 主按钮 */
        mainBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left);
            make.right.equalTo()(self.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
        }
    }
}
