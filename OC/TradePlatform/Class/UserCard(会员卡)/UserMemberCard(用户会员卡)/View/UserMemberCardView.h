//
//  UserMemberCardView.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "UserMemberCardCell.h"
#import "TopBotText.h"

@protocol UserMemberCardDelegate <NSObject>

@optional

/** 编辑 */
- (void)editClickAction:(NSInteger)tag;
/** 充值 */
- (void)rechargeClickAction:(NSInteger)tag;
  
@end

@interface UserMemberCardView : UIView

/** 总储值次数 */
@property (strong, nonatomic) TopBotText *totalSaveNumLabel;
/** 总储值金额 */
@property (strong, nonatomic) TopBotText *totalSaveMoneyLabel;

/** 用户会员卡列表table */
@property (strong, nonatomic) UITableView *userMemberCardTypeTable;
/** 用户会员卡列表数据 */
@property (strong, nonatomic) NSMutableArray *userMemberCardTypeArray;
/** 代理 */
@property (assign, nonatomic) id<UserMemberCardDelegate>delegate;


@end
