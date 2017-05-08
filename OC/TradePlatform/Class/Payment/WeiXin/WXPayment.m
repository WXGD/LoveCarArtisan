//
//  WXPayment.m
//  LoveCarEHome
//
//  Created by 弓杰 on 16/3/30.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import "WXPayment.h"
#import "WXApi.h"

@implementation WXPayment

+ (void)callPayment:(NSDictionary *)WXDictionary {
    
    PayReq *request = [[PayReq alloc] init];
    
    request.partnerId = WXDictionary[@"partnerid"];
    
    request.prepayId= WXDictionary[@"prepayid"];
    
    request.package = WXDictionary[@"package"];
    
    request.nonceStr= WXDictionary[@"noncestr"];
    
    request.timeStamp= [WXDictionary[@"timestamp"] intValue];
    
    request.sign= WXDictionary[@"sign"];
    
    [WXApi sendReq:request];
}

@end
