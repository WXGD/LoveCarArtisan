//
//  CouponViewCell.h
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//


// 优惠券cell类型
typedef NS_ENUM(NSInteger, CouponCellType) {
    /** 选择使用优惠券 */
    ChoiceUseCouponStyle,
    /** 选择发放优惠券 */
    ChoiceGrantCouponStyle,
};

#import <UIKit/UIKit.h>
#import "CouponModel.h"


@interface CouponViewCell : UITableViewCell

/** 赠送／以赠送按钮 */
@property (assign, nonatomic) CouponCellType couponCellType;
/** 优惠券模型 */
@property (strong, nonatomic) CouponInfoModel *couponInfoModel;
/** 赠送／以赠送按钮 */
@property (strong, nonatomic) UIButton *giveBtn;

@end
