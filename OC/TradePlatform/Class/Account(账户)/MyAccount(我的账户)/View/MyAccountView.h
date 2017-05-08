//
//  MyAccountView.h
//  TradePlatform
//
//  Created by apple on 2017/1/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoWordsLabel.h"

@interface MyAccountView : UIView

/** 可提现余额 */
@property (strong, nonatomic) UILabel *myBalanceLabel;
/** 已提现余额 */
@property (strong, nonatomic) TwoWordsLabel *userBalanceLabel;
/** 提现记录 */
@property (strong, nonatomic) UITableView *recordTableView;
/** 提现记录数据 */
@property (strong, nonatomic) NSMutableArray *recordArray;

/** 申请提现 */
@property (strong, nonatomic) UIButton *applyBtn;

@end
