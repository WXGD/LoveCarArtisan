//
//  AccountBankCell.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountBankModel.h"

@interface AccountBankCell : UITableViewCell
@property (assign, nonatomic) int bankViewFrom;
@property (strong, nonatomic) NSIndexPath *indP;
@property (strong, nonatomic) BankCommonModel *bankCommonModel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;
@property (weak, nonatomic) IBOutlet UILabel *bankNumLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setBtnWidthConstraint;

/** 解绑block */
@property(copy, nonatomic) void (^cancelBtnClick)(BankCommonModel *bankCommonModel);
/** 设为默认账户block */
@property(copy, nonatomic) void (^setDefaultBtnClick)(BankCommonModel *bankCommonModel);
@end
