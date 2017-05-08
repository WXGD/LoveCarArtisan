//
//  OrderPayStateModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderPayStateModel : NSObject

/** 选择类别名称 */
@property (nonatomic, copy) NSString *chioceCategoriesName;
/** 选择类别id */
@property (nonatomic, assign) NSInteger chioceCategoriesId;
/** 选中标题 */
@property (nonatomic, assign) BOOL checkMark;

@end
