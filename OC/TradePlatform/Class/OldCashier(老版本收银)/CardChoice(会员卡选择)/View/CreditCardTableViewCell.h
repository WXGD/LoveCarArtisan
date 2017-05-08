//
//  CreditCardTableViewCell.h
//  CarRepairFactory
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMemberCardModel.h"

@interface CreditCardTableViewCell : UITableViewCell

/** 会员卡模型 */
@property (strong, nonatomic) UserMemberCardModel *userCard;

@end
