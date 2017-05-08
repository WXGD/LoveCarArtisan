//
//  UserCardListTableViewCell.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMemberCardModel.h"
// view
#import "UserCardListCellView.h"

@interface UserCardListTableViewCell : UITableViewCell

/** 会员卡模型 */
@property (strong, nonatomic) UserMemberCardModel *userCardModel;
/** 会员卡cell */
@property (strong, nonatomic) UserCardListCellView *userCardListCellView;


@end
