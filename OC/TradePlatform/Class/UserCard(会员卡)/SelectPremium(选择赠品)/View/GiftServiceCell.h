//
//  GiftServiceCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSubNumView.h"
// 模型
#import "PremiumModel.h"

@interface GiftServiceCell : UITableViewCell

/** 赠品标题 */
@property (strong, nonatomic) UsedCellView *delTitleView;
/** 服务类别 */
@property (strong, nonatomic) UsedCellView *serviceClassView;
/** 服务 */
@property (strong, nonatomic) UsedCellView *serviceView;
/** 数量操作 */
@property (strong, nonatomic) AddSubNumView *numOperBtn;

/** 赠品模型 */
@property (strong, nonatomic) PremiumModel *premiumModel;


@end
