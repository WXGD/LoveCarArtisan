//
//  GrantUserCell.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// 模型
#import "UserModel.h"

@interface GrantUserCell : UITableViewCell

/** 用户信息模型 */
@property (strong, nonatomic) UserModel *userModel;

@end
