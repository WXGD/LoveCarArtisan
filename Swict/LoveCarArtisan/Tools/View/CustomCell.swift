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
    /** 所有控件横向布局(有主图片，有副图片，有副按钮) */
    case HorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn
    /** 所有控件横向布局(有主图片，有副图片，没有副按钮) */
    case HorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn
    /** 大图片，文字纵向布局(没有副图片) */
    case BigImgVerticallyLayoutNotVImg
    /** 大图片，文字纵向布局(有副图片，没有副按钮) */
    case BigImgVerticallyLayoutHaveVImgAndNotVBtn
    /** 大图片，文字纵向布局(有副图片，有副按钮) */
    case BigImgVerticallyLayoutHaveVImgAndHaveVBtn
    /** 文字纵向布局(没有主图片，没有副图片) */
    case VerticallyLayoutNotVImg
    /** 文字纵向布局(没有主图片，有副图片，没有副按钮) */
    case VerticallyLayoutHaveVImgAndNotVBtn
    /** 文字纵向布局(没有主图片，有副图片，有副按钮) */
    case VerticallyLayoutHaveVImgAndHaveVBtn
    /** 副标题为输入框(没有主图片，没有副图片) */
    case ViceTFHorizontalLayoutNotMImgAndNotVImg
    /** 副标题为输入框(有主图片，没有副图片) */
    case ViceTFHorizontalLayoutHaveMImgAndNotVImg
    /** 副标题为输入框(没有主图片，有副图片，有副按钮) */
    case ViceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn
    /** 副标题为输入框(没有主图片，有副图片，没有副按钮) */
    case ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
    /** 副标题为输入框(有主图片，有副图片，有副按钮) */
    case ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn
    /** 副标题为输入框(有主图片，有副图片，没有副按钮) */
    case ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn
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
    /** view样式 */
    var cellStyle: CustomCellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
    /** 分割线样式 */
    var lineStyle: DividingLineStyle = DividingLineStyle.FullScreenLayout
    /** 分割线高度 */
    var lineHeight: CGFloat = 0.5
    /** 主图片宽高 */
    var mainImgSize: CGSize?
    /** 尖头图片宽高 */
    var arrowImgSize: CGSize?
    /** 左边界距离 */
    var leftBorder: CGFloat = 16
    /** 右边界距离 */
    var rightBorder: CGFloat = -16
    /** 主标题距离主图片 */
    var mmImgStep: CGFloat = 16
    /** 主标题下边距离中线 */
    var mTitleBom: CGFloat = -5
    /** 左副标题上边距离主标题下边 */
    var lvTitleTop: CGFloat = 10
    /** 主副标题间距 */
    var mvTitleStep: CGFloat = 16
    /** 副输入框距离左边界 */
    var vTFLeftBorder: CGFloat?
    /** 副输入框距离右副标题距离 */
    var vTFrvTitleStep: CGFloat = -16
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
        imageView.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        imageView.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        return imageView
    }()
    /** 主标题 */
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = FourteenFont
        label.textColor = BlackColor
        label.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        return label
    }()
    /** 左边副标题 */
    lazy var leftViceLabel: UILabel = {
        let label = UILabel()
        label.font = TwelveFont
        label.textColor = GrayH1Color
        label.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        return label
    }()
    /** 右边副标题 */
    lazy var rightViceLabel: UILabel = {
        let label = UILabel()
        label.font = TwelveFont
        label.textColor = GrayH1Color
        label.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        return label
    }()
    /** 副输入框 */
    lazy var viceTF: UITextField = {
        let textField = UITextField()
        textField.font = FourteenFont
        textField.textColor = BlackColor
        return textField
    }()
    /** 主按钮 */
    lazy var mainBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        return button
    }()
    /** 箭头图片 */
    lazy var arrowImg: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(#imageLiteral(resourceName: "right_arrow"), for: UIControlState.normal)
        button.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        button.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
        return button
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
        self.backgroundColor = WhiteColor
        customCell()
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
        /** 箭头图片 */
        addSubview(arrowImg)
        /** 副输入框 */
        addSubview(viceTF)
        /** 主按钮 */
        addSubview(mainBtn)
        /** 副按钮 */
        addSubview(viceBtn)
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
            /** 所有控件横向布局(有主图片，有副图片，有副按钮) */
        case CustomCellStyle.HorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn:
            horizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn()
            break
            /** 所有控件横向布局(有主图片，有副图片，没有副按钮) */
        case CustomCellStyle.HorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn:
            horizontalLayoutHaveMImgAndHaveVImgAndNotVBtn()
            break
            /** 大图片，文字纵向布局(没有副图片) */
        case CustomCellStyle.BigImgVerticallyLayoutNotVImg:
            bigImgVerticallyLayoutNotVImg()
            break
            /** 大图片，文字纵向布局(有副图片，没有副按钮) */
        case CustomCellStyle.BigImgVerticallyLayoutHaveVImgAndNotVBtn:
            bigImgVerticallyLayoutHaveVImgAndNotVBtn()
            break
            /** 大图片，文字纵向布局(有副图片，有副按钮) */
        case CustomCellStyle.BigImgVerticallyLayoutHaveVImgAndHaveVBtn:
            bigImgVerticallyLayoutHaveVImgAndHaveVBtn()
            break
            /** 文字纵向布局(没有主图片，没有副图片) */
        case CustomCellStyle.VerticallyLayoutNotVImg:
            verticallyLayoutNotVImg()
            break
            /** 文字纵向布局(没有主图片，有副图片，没有副按钮) */
        case CustomCellStyle.VerticallyLayoutHaveVImgAndNotVBtn:
            verticallyLayoutHaveVImgAndNotVBtn()
            break
            /** 文字纵向布局(没有主图片，有副图片，有副按钮) */
        case CustomCellStyle.VerticallyLayoutHaveVImgAndHaveVBtn:
            verticallyLayoutHaveVImgAndHaveVBtn()
            break
            /** 副标题为输入框(没有主图片，没有副图片) */
        case CustomCellStyle.ViceTFHorizontalLayoutNotMImgAndNotVImg:
            // 隐藏主按钮
            mainBtn.isHidden = true
            viceTFHorizontalLayoutNotMImgAndNotVImg()
            break
            /** 副标题为输入框(有主图片，没有副图片) */
        case CustomCellStyle.ViceTFHorizontalLayoutHaveMImgAndNotVImg:
            // 隐藏主按钮
            mainBtn.isHidden = true
            viceTFHorizontalLayoutHaveMImgAndNotVImg()
            break
            /** 副标题为输入框(没有主图片，有副图片，有副按钮) */
        case CustomCellStyle.ViceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn:
            // 隐藏主按钮
            mainBtn.isHidden = true
            viceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn()
            break
            /** 副标题为输入框(没有主图片，有副图片，没有副按钮) */
        case CustomCellStyle.ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn:
            // 隐藏主按钮
            mainBtn.isHidden = true
            viceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn()
            break
            /** 副标题为输入框(有主图片，有副图片，有副按钮) */
        case CustomCellStyle.ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn:
            // 隐藏主按钮
            mainBtn.isHidden = true
            viceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn()
            break
            /** 副标题为输入框(有主图片，有副图片，没有副按钮) */
        case CustomCellStyle.ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn:
            // 隐藏主按钮
            mainBtn.isHidden = true
            viceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn()
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
                make.height.mas_equalTo()(self.lineHeight);
            }
            break
            /** 居中 */
        case DividingLineStyle.CenterLayout:
            /** 分割线 */
            lineView.mas_makeConstraints { (make: MASConstraintMaker!) in
                make.left.equalTo()(self.mas_left)?.setOffset(16);
                make.right.equalTo()(self.mas_right)?.setOffset(-16);
                make.bottom.equalTo()(self.mas_bottom);
                make.height.mas_equalTo()(self.lineHeight);
            }
            break
            /** 局右 */
        case DividingLineStyle.RightLayout:
            /** 分割线 */
            lineView.mas_makeConstraints { (make: MASConstraintMaker!) in
                make.left.equalTo()(self.mas_left)?.setOffset(16);
                make.right.equalTo()(self.mas_right);
                make.bottom.equalTo()(self.mas_bottom);
                make.height.mas_equalTo()(self.lineHeight);
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
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
        }
        /** 副按钮 */
        viceBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right);
            make.left.equalTo()(self.rightViceLabel.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
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
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
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
    /** 所有控件横向布局(有主图片，有副图片，有副按钮) */
    private func horizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn() {
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
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
        }
        /** 副按钮 */
        viceBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right);
            make.left.equalTo()(self.rightViceLabel.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
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
    /** 所有控件横向布局(有主图片，有副图片，没有副按钮) */
    private func horizontalLayoutHaveMImgAndHaveVImgAndNotVBtn() {
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
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
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
    
    /** 大图片，文字纵向布局(没有副图片) */
    private func bigImgVerticallyLayoutNotVImg() {
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
            make.bottom.equalTo()(self.mas_centerY)?.setOffset(self.mTitleBom);
            make.left.equalTo()(self.mainImg.mas_right)?.setOffset(self.mmImgStep);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mainLabel.mas_bottom)?.setOffset(self.lvTitleTop);
            make.left.equalTo()(self.mainLabel.mas_left);
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
    /** 大图片，文字纵向布局(有副图片，没有副按钮) */
    private func bigImgVerticallyLayoutHaveVImgAndNotVBtn() {
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
            make.bottom.equalTo()(self.mas_centerY)?.setOffset(self.mTitleBom);
            make.left.equalTo()(self.mainImg.mas_right)?.setOffset(self.mmImgStep);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mainLabel.mas_bottom)?.setOffset(self.lvTitleTop);
            make.left.equalTo()(self.mainLabel.mas_left);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
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
    /** 大图片，文字纵向布局(有副图片，有副按钮) */
    private func bigImgVerticallyLayoutHaveVImgAndHaveVBtn() {
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
            make.bottom.equalTo()(self.mas_centerY)?.setOffset(self.mTitleBom);
            make.left.equalTo()(self.mainImg.mas_right)?.setOffset(self.mmImgStep);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mainLabel.mas_bottom)?.setOffset(self.lvTitleTop);
            make.left.equalTo()(self.mainLabel.mas_left);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
        }
        /** 副按钮 */
        viceBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right);
            make.left.equalTo()(self.rightViceLabel.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
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
    /** 文字纵向布局(没有主图片，没有副图片) */
    private func verticallyLayoutNotVImg() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.bottom.equalTo()(self.mas_centerY)?.setOffset(self.mTitleBom);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mainLabel.mas_bottom)?.setOffset(self.lvTitleTop);
            make.left.equalTo()(self.mainLabel.mas_left);
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
    /** 文字纵向布局(没有主图片，有副图片，没有副按钮) */
    private func verticallyLayoutHaveVImgAndNotVBtn() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.bottom.equalTo()(self.mas_centerY)?.setOffset(self.mTitleBom);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mainLabel.mas_bottom)?.setOffset(self.lvTitleTop);
            make.left.equalTo()(self.mainLabel.mas_left);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
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
    /** 文字纵向布局(没有主图片，有副图片，有副按钮) */
    private func verticallyLayoutHaveVImgAndHaveVBtn() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.bottom.equalTo()(self.mas_centerY)?.setOffset(self.mTitleBom);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 左边副标题 */
        leftViceLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.top.equalTo()(self.mainLabel.mas_bottom)?.setOffset(self.lvTitleTop);
            make.left.equalTo()(self.mainLabel.mas_left);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
        }
        /** 副按钮 */
        viceBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right);
            make.left.equalTo()(self.rightViceLabel.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
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
    /** 副标题为输入框(没有主图片，没有副图片) */
    private func viceTFHorizontalLayoutNotMImgAndNotVImg() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 副输入框 */
        viceTF.mas_makeConstraints { (make: MASConstraintMaker!) in
            if self.vTFLeftBorder != nil {
                make.left.equalTo()(self.mas_left)?.setOffset(self.vTFLeftBorder!);
            }else {
                make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
            }
            make.right.equalTo()(self.rightViceLabel.mas_left)?.setOffset(self.vTFrvTitleStep);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
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
    /** 副标题为输入框(有主图片，没有副图片) */
    private func viceTFHorizontalLayoutHaveMImgAndNotVImg() {
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
        /** 副输入框 */
        viceTF.mas_makeConstraints { (make: MASConstraintMaker!) in
            if self.vTFLeftBorder != nil {
                make.left.equalTo()(self.mas_left)?.setOffset(self.vTFLeftBorder!);
            }else {
                make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
            }
            make.right.equalTo()(self.rightViceLabel.mas_left)?.setOffset(self.vTFrvTitleStep);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
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
    /** 副标题为输入框(没有主图片，有副图片，有副按钮) */
    private func viceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 副输入框 */
        viceTF.mas_makeConstraints { (make: MASConstraintMaker!) in
            if self.vTFLeftBorder != nil {
                make.left.equalTo()(self.mas_left)?.setOffset(self.vTFLeftBorder!);
            }else {
                make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
            }
            make.right.equalTo()(self.rightViceLabel.mas_left)?.setOffset(self.vTFrvTitleStep);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
        }
        /** 副按钮 */
        viceBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right);
            make.left.equalTo()(self.rightViceLabel.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
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
    /** 副标题为输入框(没有主图片，有副图片，没有副按钮) */
    private func viceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn() {
        /** 主标题 */
        mainLabel.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.left.equalTo()(self.mas_left)?.setOffset(self.leftBorder);
        }
        /** 副输入框 */
        viceTF.mas_makeConstraints { (make: MASConstraintMaker!) in
            if self.vTFLeftBorder != nil {
                make.left.equalTo()(self.mas_left)?.setOffset(self.vTFLeftBorder!);
            }else {
                make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
            }
            make.right.equalTo()(self.rightViceLabel.mas_left)?.setOffset(self.vTFrvTitleStep);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
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
    /** 副标题为输入框(有主图片，有副图片，有副按钮) */
    private func viceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn() {
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
        /** 副输入框 */
        viceTF.mas_makeConstraints { (make: MASConstraintMaker!) in
            if self.vTFLeftBorder != nil {
                make.left.equalTo()(self.mas_left)?.setOffset(self.vTFLeftBorder!);
            }else {
                make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
            }
            make.right.equalTo()(self.rightViceLabel.mas_left)?.setOffset(self.vTFrvTitleStep);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
        }
        /** 副按钮 */
        viceBtn.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right);
            make.left.equalTo()(self.rightViceLabel.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
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
    /** 副标题为输入框(有主图片，有副图片，没有副按钮) */
    private func viceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn() {
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
        /** 副输入框 */
        viceTF.mas_makeConstraints { (make: MASConstraintMaker!) in
            if self.vTFLeftBorder != nil {
                make.left.equalTo()(self.mas_left)?.setOffset(self.vTFLeftBorder!);
            }else {
                make.left.equalTo()(self.mainLabel.mas_right)?.setOffset(self.mvTitleStep);
            }
            make.right.equalTo()(self.rightViceLabel.mas_left)?.setOffset(self.vTFrvTitleStep);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom);
        }
        /** 箭头图片 */
        arrowImg.mas_makeConstraints { (make: MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY);
            make.right.equalTo()(self.mas_right)?.setOffset(self.rightBorder);
            if self.arrowImgSize != nil {
                make.size.mas_equalTo()(self.arrowImgSize);
            }
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
