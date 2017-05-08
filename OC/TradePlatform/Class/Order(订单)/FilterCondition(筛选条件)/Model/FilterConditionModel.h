//
//  FilterConditionModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FiterItemModel.h"

@interface FilterConditionModel : NSObject

/** {
 name = "order_category_id";
 title = "订单类型";
 value =      ()     **/


/** 分类 */
@property (nonatomic, strong) NSArray *value;
/** 分类名称 */
@property (nonatomic, copy) NSString *name;
/** 分类标题 */
@property (nonatomic, copy) NSString *title;


@end
