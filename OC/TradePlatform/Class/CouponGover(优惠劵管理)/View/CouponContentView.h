//
//  CouponContentView.h
//  TradePlatform
//
//  Created by 弓杰 on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "CouponContentCell.h"

@protocol CouponContentDelegate <NSObject>

@optional
/** 发劵记录 */
- (void)grantRecordAction:(UIButton *)button;
/** 禁用 */
- (void)disableAction:(UIButton *)button;
/** 发劵 */
- (void)grantAction:(UIButton *)button;
/** 编辑优惠劵 */
- (void)editCoupon:(NSIndexPath *)indexPath;
/** 启用 */
- (void)enableAction:(UIButton *)button;

@end

@interface CouponContentView : UIView

/** 新增优惠劵 */
@property (strong, nonatomic) UIButton *addCouponBtn;
/** 代理 */
@property (assign, nonatomic) id<CouponContentDelegate>delegate;
/** 优惠劵状态 */
@property (assign, nonatomic) CouponState couponState;
/** 内容table */
@property (strong, nonatomic) UITableView *contentTable;
/** table数据 */
@property (strong, nonatomic) NSMutableArray *couponArray;

@end
