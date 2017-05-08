//
//  UserCardView.h
//  TradePlatform
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

// 会员卡页面点击类型
typedef NS_ENUM(NSInteger, UserCardBottonAction) {
    /** 新增卡类型 */
    AddCardTypeBtnAction,
    /** 自定义开卡 */
    CustomOpenCardBtnAction,
};

#import <UIKit/UIKit.h>
// view
#import "TopBotBtn.h"
#import "CardTypeCell.h"

@protocol UserCardDelegate <NSObject>

@optional
// 会员卡类型点击
- (void)tableView:(UITableView *)tableView CardTypeCellClickIndexPath:(NSIndexPath *)indexPath;
// 用户会员卡按钮点击
- (void)userCardClickAction:(NSInteger)tag;
// 开卡按钮点击
- (void)openCardClickAction:(NSInteger)tag;

@end

@interface UserCardView : UIView

/** 会员卡类型列表table */
@property (strong, nonatomic) UITableView *userCardTypeTable;
/** 会员卡类型列表数据 */
@property (strong, nonatomic) NSMutableArray *userCardTypeArray;
/** 新增卡类型 */
@property (strong, nonatomic) TopBotBtn *addCardTypeBtn;
/** 自定义开卡 */
@property (strong, nonatomic) TopBotBtn *customOpenCardBtn;
/** 代理 */
@property (assign, nonatomic) id<UserCardDelegate>delegate;


@end
