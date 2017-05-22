//
//  CustomCell.h
//  CustomCell
//
//  Created by apple on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomCellStyle) {
    /** 所有控件横向布局(没有主图片，没有副图片) */
    HorizontalLayoutNotMImgAndVImg,
    /** 所有控件横向布局(有主图片，没有副图片) */
    HorizontalLayoutHaveMImgAndNotVImg,
    /** 所有控件横向布局(没有主图片，有副图片，有副按钮) */
    HorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn,
    /** 所有控件横向布局(没有主图片，有副图片，没有副按钮) */
    HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn,
    /** 所有控件横向布局(有主图片，有副图片，有副按钮) */
    HorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn,
    /** 所有控件横向布局(有主图片，有副图片，没有副按钮) */
    HorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn,
    /** 大图片，文字纵向布局(没有副图片) */
    BigImgVerticallyLayoutNotVImg,
    /** 大图片，文字纵向布局(有副图片，没有副按钮) */
    BigImgVerticallyLayoutHaveVImgAndNotVBtn,
    /** 大图片，文字纵向布局(有副图片，有副按钮) */
    BigImgVerticallyLayoutHaveVImgAndHaveVBtn,
    /** 文字纵向布局(没有主图片，没有副图片) */
    VerticallyLayoutNotVImg,
    /** 文字纵向布局(没有主图片，有副图片，没有副按钮) */
    VerticallyLayoutHaveVImgAndNotVBtn,
    /** 文字纵向布局(没有主图片，有副图片，有副按钮) */
    VerticallyLayoutHaveVImgAndHaveVBtn,
    /** 副标题为输入框(没有主图片，没有副图片) */
    ViceTFHorizontalLayoutNotMImgAndNotVImg,
    /** 副标题为输入框(有主图片，没有副图片) */
    ViceTFHorizontalLayoutHaveMImgAndNotVImg,
    /** 副标题为输入框(没有主图片，有副图片，有副按钮) */
    ViceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn,
    /** 副标题为输入框(没有主图片，有副图片，没有副按钮) */
    ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn,
    /** 副标题为输入框(有主图片，有副图片，有副按钮) */
    ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn,
    /** 副标题为输入框(有主图片，有副图片，没有副按钮) */
    ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn,
};

typedef NS_ENUM(NSInteger, DividingLineStyle) {
    /** 全屏 */
    FullScreenLayout,
    /** 居中 */
    CenterLayout,
    /** 局右 */
    RightLayout,
    /** 没有分割线 */
    NotLine,
};


@interface CustomCell : UIView

/** view样式 */
@property (assign, nonatomic) CustomCellStyle cellStyle;
/** 分割线样式 */
@property (assign, nonatomic) DividingLineStyle lineStyle;
/** 分割线高度 */
@property (assign, nonatomic) CGFloat lineHeight;
/** 主图片宽高 */
@property (assign, nonatomic) CGSize mainImgSize;
/** 箭头图片宽高 */
@property (assign, nonatomic) CGSize arrowImgSize;
/** 左边界距离 */
@property (assign, nonatomic) CGFloat leftBorder;
/** 右边界距离 */
@property (assign, nonatomic) CGFloat rightBorder;
/** 主标题距离主图片 */
@property (assign, nonatomic) CGFloat mmImgStep;
/** 主标题下边距离中线 */
@property (assign, nonatomic) CGFloat mTitleBom;
/** 左副标题上边距离主标题下边 */
@property (assign, nonatomic) CGFloat lvTitleTop;
/** 主副标题间距 */
@property (assign, nonatomic) CGFloat mvTitleStep;
/** 副输入框距离左边界 */
@property (assign, nonatomic) CGFloat vTFLeftBorder;
/** 副输入框距离右副标题距离 */
@property (assign, nonatomic) CGFloat vTFrvTitleStep;
/** 右副标题距离右副图片 */
@property (assign, nonatomic) CGFloat rvvImgStep;

/** 分割线 */
@property (strong, nonatomic) UIView *lineView;
/** 主图片 */
@property (strong, nonatomic) UIImageView *mainImg;
/** 主标题 */
@property (strong, nonatomic) UILabel *mainLabel;
/** 左边副标题 */
@property (strong, nonatomic) UILabel *leftViceLabel;
/** 右边副标题 */
@property (strong, nonatomic) UILabel *rightViceLabel;
/** 副输入框 */
@property (strong, nonatomic) UITextField *viceTF;
/** 主按钮 */
@property (strong, nonatomic) UIButton *mainBtn;
/** 箭头图片 */
@property (strong, nonatomic) UIButton *arrowImg;
/** 副按钮 */
@property (strong, nonatomic) UIButton *viceBtn;

@end
