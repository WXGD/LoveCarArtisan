//
//  UserCardTabelView.h
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserCardTabelDelegate <NSObject>

@optional
/** 编辑 */
- (void)userCardCellEditBtnAction:(UIButton *)button;
/** 充值 */
- (void)userCardCellRechargeBtnAction:(UIButton *)button;

@end


@interface UserCardTabelView : UIView

/** 客户卡table */
@property (strong, nonatomic) UITableView *userCardTable;
/** 客户卡信息数据 */
@property (strong, nonatomic) NSMutableArray *userCardArray;
/** 点击用户卡，充值，编辑按钮代理 */
@property (assign, nonatomic) id<UserCardTabelDelegate>delegate;

@end
