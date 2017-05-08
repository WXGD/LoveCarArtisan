//
//  SearchUserCarViewCell.h
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCarModel.h"

@interface SearchUserCarViewCell : UITableViewCell

/** 用户车辆 */
@property (strong, nonatomic) UserCarModel *userCarModel;

@end
