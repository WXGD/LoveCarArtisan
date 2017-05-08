//
//  SelectPremiumViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "CardCategoryModel.h"

@interface SelectPremiumViewController : RootViewController

/** 上级页面选择卡类别 */
@property (assign, nonatomic) NSInteger cardCategoryID;
/** 保存赠品回调 */
@property (copy, nonatomic) void(^KeepsPremiumBlock)(NSString *premiumName, NSString *premiumID, NSString *premiumNumMon, NSMutableArray *keepsGoodsArray, NSMutableArray *currentServiceArray);
/** 之前保存的赠品 */
@property (strong, nonatomic) NSMutableArray *keepsGoodsArray;
/** 之前保存的服务 */
@property (strong, nonatomic) NSMutableArray *currentServiceArray;
/** 之前保存的赠送次数／赠送金额 */
@property (copy, nonatomic) NSString *premiumNumMon;

@end

