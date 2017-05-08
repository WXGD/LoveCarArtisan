//
//  PhotographNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotographNetwork : NSObject

+ (void)photographModifyImage:(UIImage *)modifyImage success:(void(^)(NSMutableDictionary *responseObject))success;

@end
