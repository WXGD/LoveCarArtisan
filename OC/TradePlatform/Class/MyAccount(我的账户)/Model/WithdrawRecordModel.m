//
//  WithdrawRecordModel.m
//  TradePlatform
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WithdrawRecordModel.h"

@implementation WithdrawRecordModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"operator_name" : @"operator"};
}
@end
