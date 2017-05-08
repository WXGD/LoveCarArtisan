//
//  SelectPremiumView.h
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "GiftServiceCell.h"

@protocol SelectPremiumDelegate <NSObject>

@optional

/** 删除赠品 */
- (void)delPremiumBtnDelegate:(UIButton *)button;
/** 服务类别 */
- (void)serviceClassBtnDelegate:(UIButton *)button;
/** 服务 */
- (void)serviceGoodsBtnDelegate:(UIButton *)button;
/** 数量操作 */
- (void)addSubPremiumDelegate:(UIButton *)button;

@end


@interface SelectPremiumView : UIView

/** 赠品View */
@property (strong, nonatomic) UIStackView *selectPremiumStackView;
/** 赠送次数输入背景view */
@property (strong, nonatomic) UIView *giveNumPriceBackView;
/** 赠送次数／金额 */
@property (strong, nonatomic) UsedCellView *giveNumPriceView;
/** 添加赠品 */
@property (strong, nonatomic) UIButton *addGiftBtn;
/** 赠送服务 */
@property (strong, nonatomic) UITableView *giftServiceTable;

/** 赠送商品数组 */
@property (strong, nonatomic) NSMutableArray *giftGoodsArray;

/** 操作代理 */
@property (assign, nonatomic) id<SelectPremiumDelegate>delegate;

@end
