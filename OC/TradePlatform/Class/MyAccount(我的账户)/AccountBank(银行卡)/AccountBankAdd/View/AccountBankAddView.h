//
//  AccountBankAddView.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountBankAddView : UIView
/** 提示view */
@property (strong, nonatomic) UsedCellView *bankAddNoteView;
/** 持卡人view */
@property (strong, nonatomic) UsedCellView *bankAddNameView;
/** 银行view */
@property (strong, nonatomic) UsedCellView *bankAddBankNameView;
/** 卡号view */
@property (strong, nonatomic) UsedCellView *bankAddCardView;
/** 分行view */
@property (strong, nonatomic) UsedCellView *bankAddbranchView;
@end
