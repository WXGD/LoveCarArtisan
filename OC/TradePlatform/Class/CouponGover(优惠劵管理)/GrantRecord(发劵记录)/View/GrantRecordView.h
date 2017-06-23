//
//  GrantRecordView.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "CouponInfoView.h"
#import "SearchView.h"
#import "GrantRecordCell.h"

@interface GrantRecordView : UIView

/** 优惠劵信息view */
@property (strong, nonatomic) CouponInfoView *couponInfoView;
/** 优惠劵搜索view */
@property (strong, nonatomic) SearchView *couponSearchView;
/** 发劵记录table */
@property (strong, nonatomic) UITableView *grantRecordTable;
/** 发劵记录数据 */
@property (strong, nonatomic) NSMutableArray *grantRecordArray;

@end
