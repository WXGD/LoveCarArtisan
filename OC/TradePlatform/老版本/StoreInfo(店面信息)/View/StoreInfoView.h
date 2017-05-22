//
//  StoreInfoView.h
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

// 商户信息按钮点击类型
typedef NS_ENUM(NSInteger, StoreInfoBottonAction) {
    /** 门头图片 */
    StoreInfoBigImageBtnAction,
    /** 名称 */
    StoreInfoNameBtnAction,
    /** 电话 */
    StoreInfoPhoneBtnAction,
    /** 地址 */
    StoreInfoAddressBtnAction,
};


#import <UIKit/UIKit.h>

@interface StoreInfoView : UIView

/** 门头图片 */
@property (strong, nonatomic) UsedCellView *storeBigImageView;
/** 名称 */
@property (strong, nonatomic) UsedCellView *storeNameView;
/** 电话 */
@property (strong, nonatomic) UsedCellView *storePhoneView;
/** 地址 */
@property (strong, nonatomic) UsedCellView *storeAddressView;

@end


