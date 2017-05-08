//
//  ExpireCell.h
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

// cell样式
typedef NS_ENUM(NSInteger, ExpireCellType) {
    /** 会员卡过期 */
    UserCardExpireCellShowType,
    /** 长期未到店  */
    longNotShopExpireCellShowType,
    /** 余额 */
    BalanceExpireCellShowType,
    /** 余次 */
    LeaveSecondExpireCellShowType,
};


#import <UIKit/UIKit.h>
#import "ExpircUserModel.h"

@interface ExpireCell : UITableViewCell

/** 区间查询用户信息 */
@property (strong, nonatomic) ExpircUserModel *expircUserModel;
/** cell样式 */
@property (assign, nonatomic) ExpireCellType expireCellType;

@end
