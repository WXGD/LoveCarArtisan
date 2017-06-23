//
//  CouponContentCell.h
//  TradePlatform
//
//  Created by 弓杰 on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

// 优惠劵状态
typedef NS_ENUM(NSInteger, CouponState) {
    /** 禁用 */
    DisableState,
    /** 启用 */
    EnableState,
    /** 过期 */
    ExpireState,
};


#import <UIKit/UIKit.h>
// 模型
#import "CouponGoverModel.h"

@interface CouponContentCell : UITableViewCell

/** 优惠劵模型 */
@property (strong, nonatomic) CouponGoverModel *couponGoverModel;
/** 优惠劵状态 */
@property (assign, nonatomic) CouponState couponState;
/** 发劵记录 */
@property (strong, nonatomic) UIButton *grantRecordBtn;
/** 禁用 */
@property (strong, nonatomic) UIButton *disableBtn;
/** 发劵 */
@property (strong, nonatomic) UIButton *grantBtn;
/** 启用 */
@property (strong, nonatomic) UIButton *enableBtn;

@end
