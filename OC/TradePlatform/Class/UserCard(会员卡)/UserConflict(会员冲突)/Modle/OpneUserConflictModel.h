//
//  OpneUserConflictModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpneUserConflictModel : NSObject

/** "conflict": "1$###冲突标识", "provider_user_id": "1,2 ###冲突用户id集合"  */

/** 冲突标识 */
@property (nonatomic, assign) NSInteger conflict;
/** 冲突用户id集合 */
@property (nonatomic, copy) NSString *provider_user_id;

@end
