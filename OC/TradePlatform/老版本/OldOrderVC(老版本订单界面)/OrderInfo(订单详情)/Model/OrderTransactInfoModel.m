//
//  OrderTransactInfoModel.m
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderTransactInfoModel.h"

@implementation OrderTransactInfoModel

- (void)setPay_no:(NSString *)pay_no {
    _pay_no = pay_no;
    if (pay_no.length == 0) {
        _pay_no = @"无";
    }
}

@end
