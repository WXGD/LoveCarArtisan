//
//  CardTypeCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTypeCellView.h"
// 模型
#import "CardTypeModel.h"

@interface CardTypeCell : UITableViewCell

/** 卡类型cellview */
@property (nonatomic, strong) CardTypeCellView *cardTypeCellView;
/** 卡类型模型 */
@property (nonatomic, strong) CardTypeModel *cardTypeModel;

@end
