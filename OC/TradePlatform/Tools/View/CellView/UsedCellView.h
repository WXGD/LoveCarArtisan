//
//  UsedCellView.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

// 自定义cell样式类型
typedef NS_ENUM(NSInteger, UsedCellTypeChoice) {
    /** 所有控件横向布局 */
    AllViewHorizontalLayout,
    /** 大图片，文字纵向布局 */
    BigPictureVerticallyLayout,
    /** 描述信息为图片 */
    DescribeImageHorizontalLayout,
    /** 描述信息有图片和文字 */
    DescribeImageTextHorizontalLayout,
    /** 所有控件纵向居中分布 */
    AllViewVerticallyCenterLayout,
    /** 副标题为输入框 */
    ViceTextFiledHorizontalLayout,
    /** 只有一个输入框输入框 */
    OnlyTextFiledLayout,
};

// 分割线样式类型
typedef NS_ENUM(NSInteger, DividingLineTypeChoice) {
    /** 全屏 */
    DividingLineFullScreenLayout = 10,
    /** 居中 */
    DividingLineCenterLayout = 11,
    /** 局右 */
    DividingLineRightLayout = 12,
};


@interface UsedCellView : UIView

/** 分割线(yes:没有分割线) */
@property (assign, nonatomic) BOOL isSplistLine;
/** 箭头(yes:没有箭头) */
@property (assign, nonatomic) BOOL isArrow;
/** 图片(yes:没有图片) */
@property (assign, nonatomic) BOOL isCellImage;
/** 按钮(yes:没有按钮) */
@property (assign, nonatomic) BOOL isCellBtn;
/** 是否自定义cell图片大小（yus:需要） */
@property (assign, nonatomic) BOOL isCellImageSize;
/** cell图片尺寸 */
@property (assign, nonatomic) CGSize cellImageSize;
/** 按钮点击 */
@property (strong, nonatomic) UIButton *usedCellBtn;
/** 图片 */
@property (strong, nonatomic) UIImageView *cellImage;
/** 箭头 */
@property (strong, nonatomic) UIButton *arrowImage;
/** 文字 */
@property (strong, nonatomic) UILabel *cellLabel;
/** 副标题 */
@property (strong, nonatomic) UILabel *viceLabel;
/** 输入框副标题 */
@property (strong, nonatomic) UITextField *viceTextFiled;
/** 描述文字 */
@property (strong, nonatomic) UILabel *describeLabel;
/** 描述图片 */
@property (strong, nonatomic) UIImageView *describeImage;
/** view样式 */
@property (assign, nonatomic) UsedCellTypeChoice usedCellTypeChoice;
/** 分割线样式 */
@property (assign, nonatomic) DividingLineTypeChoice dividingLineChoice;

/*** 大图样式专用 ****/
/** 大图距离上边（所有控件纵向居中分布，专用） */
@property (assign, nonatomic) CGFloat bigImageTop;
/** 描述图片 */
@property (assign, nonatomic) CGSize describeImageSize;

@end
