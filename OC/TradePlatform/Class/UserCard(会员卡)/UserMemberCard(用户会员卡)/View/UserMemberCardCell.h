//
//  UserMemberCardCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMemberCardCellView.h"
#import "UserMemberCardModel.h"

@interface UserMemberCardCell : UITableViewCell

/** 用户会员卡cellview */
@property (nonatomic, strong) UserMemberCardCellView *userMemberCardCellView;
/** 用户会员卡模型 */
@property (nonatomic, strong) UserMemberCardModel *userMemberCardModel;


@end
