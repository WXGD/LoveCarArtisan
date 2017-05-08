//
//  AlertListModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertListModel : NSObject

/** 选择类别名称 */
@property (copy, nonatomic) NSString *chioceCategoriesName;
/** 选择类别id */
@property (assign, nonatomic) NSInteger chioceCategoriesId;
/** 选中标题 */
@property (assign, nonatomic) BOOL currentTitle;

@end


