//
//  SafeTypeModel.h
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BenefitModel.h"

@interface SafeTypeModel : NSObject

/** 交强险 */
@property (strong, nonatomic) NSMutableArray *jqx;
/** 商业保险 */
@property (strong, nonatomic) NSMutableArray *syx;
/** 保险方案名称字符串 */
@property (copy, nonatomic) NSString *scheme_name;
/** 保险方案名称字符串(带熟悉) */
@property (copy, nonatomic) NSMutableAttributedString *scheme_name_attri;
/** 保险方案ID字符串 */
@property (copy, nonatomic) NSString *scheme_id;

/** 请求保险险种 */
+ (void)requestSafeTypeSuccess:(void(^)(SafeTypeModel *safeTypeModel))success;

@end
