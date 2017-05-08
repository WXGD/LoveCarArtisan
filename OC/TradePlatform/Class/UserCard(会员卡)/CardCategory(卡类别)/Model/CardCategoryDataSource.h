//
//  CardCategoryDataSource.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJBaseDataSource.h"
#import "CardCategoryCell.h"

@interface CardCategoryDataSource : GJBaseDataSource
// 请求会员卡类别数据
- (void)requestCardTypeData;

@end
