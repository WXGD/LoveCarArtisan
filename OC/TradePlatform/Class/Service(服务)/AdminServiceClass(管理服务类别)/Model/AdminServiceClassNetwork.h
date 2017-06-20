//
//  AdminServiceClassNetwork.h
//  TradePlatform
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminServiceClassNetwork : UIView

/** 修改服务类别 */
+ (void)editServiceClass:(NSMutableDictionary *)params success:(void(^)())success;


@end
