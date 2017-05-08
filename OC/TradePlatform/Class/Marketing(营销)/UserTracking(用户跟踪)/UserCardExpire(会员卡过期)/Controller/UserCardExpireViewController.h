//
//  UserCardExpireViewController.h
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

// 页面类型
typedef NS_ENUM(NSInteger, ExpireViewType) {
    /** 会员卡过期 */
    UserCardExpireType,
    /** 长期未到店  */
    longNotShopType,
};


#import "RootViewController.h"

@interface UserCardExpireViewController : RootViewController

@property (assign, nonatomic) ExpireViewType expireViewType;

@end
