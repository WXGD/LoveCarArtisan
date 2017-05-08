//
//  CardCategoryModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJBaseModel.h"

@interface CardCategoryModel : GJBaseModel

/** 卡类别名称 */
@property (nonatomic, copy) NSString *name;
/** 卡类别（1次卡，2储值卡,3年卡） */
@property (nonatomic, assign) NSInteger card_category_id;
/** 当前选中标记 */
@property (nonatomic, assign) BOOL checkMark;


@end
