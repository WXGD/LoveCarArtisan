//
//  UserCarCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCarModel.h"
#import "UserCarView.h"

@interface UserCarCell : UITableViewCell

/** 用户车辆 */
@property (strong, nonatomic) UserCarView *userCarView;
/** 用户车辆 */
@property (strong, nonatomic) UserCarModel *userCarModel;


@end
