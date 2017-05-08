//
//  SearchUserViewCell.h
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface SearchUserViewCell : UITableViewCell

/** 用户信息模型 */
@property (strong, nonatomic) UserModel *userModel;

@end
