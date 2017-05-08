//
//  ReviseRangeViewController.h
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

// 页面类型
typedef NS_ENUM(NSInteger, ReviseRangeViewType) {
    /** 会员卡过期 */
    UserCardExpireShowType,
    /** 长期未到店  */
    longNotShopShowType,
    /** 余额 */
    BalanceShowType,
    /** 余次 */
    LeaveSecondShowType,
};

#import "RootViewController.h"

@interface ReviseRangeViewController : RootViewController

/** 区间数据 */
@property (strong, nonatomic) NSMutableArray *rangeArray;
/** 添加成功回调 */
@property (copy, nonatomic) void(^AddDataSectionBlock)();
/** 页面展示类型 */
@property (assign, nonatomic) ReviseRangeViewType reviseRangeType;

@end
