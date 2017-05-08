//
//  SearchUserCardViewCell.h
//  TradePlatform
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMemberCardModel.h"

@interface SearchUserCardViewCell : UITableViewCell

/** 用户卡 */
@property (strong, nonatomic) UserMemberCardModel *userCardModel;
/** 编辑按钮 */
@property (strong, nonatomic) UIButton *editBtn;
/** 充值按钮 */
@property (strong, nonatomic) UIButton *rechargeBtn;

@end
