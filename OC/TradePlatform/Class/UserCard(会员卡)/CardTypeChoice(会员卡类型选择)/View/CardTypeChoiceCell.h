//
//  CardTypeChoiceCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenCardInfoView.h"
// 模型
#import "CardTypeModel.h"

@interface CardTypeChoiceCell : UITableViewCell

/** 选择卡类型模型 */
@property (nonatomic, strong) OpenCardInfoView *cardInfoCellView;
/** 选择卡按钮 */
@property (nonatomic, strong) UIButton *choiceCardBtn;
/** 会员卡信息模型 */
@property (nonatomic, strong) CardTypeModel *cardInfoModel;

@end
