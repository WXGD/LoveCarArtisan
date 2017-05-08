//
//  CardCategoryCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GJBaseTableViewCell.h"
#import "CardCategoryModel.h"

@interface CardCategoryCell : GJBaseTableViewCell

/** 卡类别模型 */
@property (nonatomic, strong) CardCategoryModel *cardCategoryModel;

@end
