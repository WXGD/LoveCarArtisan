//
//  PayMethodCell.h
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentMethodModel.h"

@interface PayMethodCell : UITableViewCell

/** cell数据模型 */
@property (strong, nonatomic) PaymentMethodModel  *payMethodModel;

@end
