//
//  ConfictCarViewCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWFUserCarModel.h"

@interface ConfictCarViewCell : UITableViewCell

/** 车辆模型 */
@property (strong, nonatomic) CWFUserCarModel *confictCarModel;

@end
