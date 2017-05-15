//
//  SelectFirmCell.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// model
#import "BenefitFirmModel.h"

@interface SelectFirmCell : UITableViewCell

/** 保险公司 */
@property (strong, nonatomic) BenefitFirmModel *firmModel;

@end
