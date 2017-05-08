//
//  EditUserCardViewController.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "UserMemberCardModel.h"

@interface EditUserCardViewController : RootViewController

/** 会员卡模型 */
@property (strong, nonatomic) UserMemberCardModel *userCard;
/** 会员卡编辑成功 */
@property (copy, nonatomic) void(^EditUserCardSuccessBlock)(UserMemberCardModel *userCard);

@end
