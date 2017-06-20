//
//  StoreInfoView.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//
// 设置页面按钮点击类型
typedef NS_ENUM(NSInteger, StoreButtonAction) {
    /** 店名 */
    StoreNameBtnAction,
    /** 客服电话 */
    StoreTelPhoneBtnAction,
    /** 短信电话 */
    StoreMessagePhoneBtnAction,
    /** 地址 */
    StoreAddressBtnAction,
    /** 营业时间 */
    StoreTimeBtnAction,
    /** 微信公众号 */
    StoreQrBtnAction,
};
#import <UIKit/UIKit.h>

@interface StoreInfoView : UIView

/** 背景视图scroller */
@property (nonatomic, strong) UIScrollView *storeInfoScrollerView;
/** 背景视图stack */
@property (nonatomic, strong) UIStackView *storeInfostackView;
/** 图片bg */
@property (nonatomic, strong) UIView *imageBgView;
/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** 店名 */
@property (nonatomic, strong) UsedCellView *storeNameView;
/** 客服电话 */
@property (nonatomic, strong) UsedCellView *telPhoneView;
/** 短信 */
@property (nonatomic, strong) UsedCellView *messagePhoneView;
/** 地址View */
@property (nonatomic, strong) UsedCellView *addressView;
/** 具体地址 */
@property (nonatomic, strong) UILabel *addressLabel;
/** 营业时间 */
@property (nonatomic, strong) UsedCellView *timeView;
/** VX */
@property (nonatomic, strong) UsedCellView *qrCodeView;

@end
