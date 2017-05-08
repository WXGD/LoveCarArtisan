//
//  UserAndPlnViewCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface UserAndPlnViewCell : UITableViewCell

/** 冲突用户模型 */
@property (strong, nonatomic) UserModel *conflictUserModel;
/** cell选中标记 */
@property (strong, nonatomic) UIButton *cellSelectedBtn;

@end
