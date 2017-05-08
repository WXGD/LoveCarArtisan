//
//  SearchVCView.h
//  TradePlatform
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTableView.h"
#import "UserCarTableView.h"
#import "UserCardTabelView.h"

@protocol SearchVCDelegate <NSObject>

@optional
- (void)searchVCbuttonAction:(UIButton *)button;

@end

@interface SearchVCView : UIView

/** 背景ScrollView */
@property (strong, nonatomic) UIScrollView *backScrollView;
/** 用户Tabel */
@property (strong, nonatomic) UserTableView *userTableView;
/** 用户车Tabel */
@property (strong, nonatomic) UserCarTableView *userCarTableView;
/** 用户卡Tabel */
@property (strong, nonatomic) UserCardTabelView *userCardTableView;
/** 切换搜索类型代理 */
@property (assign, nonatomic) id<SearchVCDelegate>delegate;

@end
