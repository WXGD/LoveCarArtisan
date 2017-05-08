//
//  FilterConditionViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "OrderFilterHandle.h"

@interface FilterConditionViewController : RootViewController

/** 筛选数据 */
@property (strong, nonatomic) NSMutableArray *filterArray;
/** 选中条件 */
@property (strong, nonatomic) NSMutableArray *selectedConditionArray;
/** 保存选中支付方式 */
@property (strong, nonatomic) FiterItemModel *saveSelPay;
/** 保存选中订单类型 */
@property (strong, nonatomic) FiterItemModel *saveSelOrderClass;
/** 保存选中服务类型 */
@property (strong, nonatomic) FiterItemModel *saveSelServiceClass;
/** 开始日期 */
@property (copy, nonatomic) NSString *startDataStr;
/** 结束日期 */
@property (copy, nonatomic) NSString *endDataStr;
/** 完成选择回调 */
@property (nonatomic, copy) void(^makingSelectionBlock)(FiterItemModel *saveSelPay, FiterItemModel *saveSelOrderClass, FiterItemModel *saveSelServiceClass, NSString *startDataStr, NSString *endDataStr, NSString *filterConditionStr, NSMutableArray *filterArray, NSMutableArray *selectedConditionArray);

@end
