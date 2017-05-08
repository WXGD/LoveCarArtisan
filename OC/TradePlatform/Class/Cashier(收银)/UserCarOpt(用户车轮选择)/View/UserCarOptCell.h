//
//  UserCarOptCell.h
//  TradePlatform
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCarModel.h"

@interface UserCarOptCell : UITableViewCell

/** 用户车辆模型 */
@property (strong, nonatomic) UserCarModel *userCarModel;

/** cell背景view */
@property (strong, nonatomic) UIView *cellBackView;

@end
