//
//  SchemeListCell.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchemeListCell : UITableViewCell

/** 方案标题view */
@property (strong, nonatomic) UsedCellView *schemeTitleView;
/** 方案内容Label */
@property (strong, nonatomic) UILabel *schemeCententLabel;

@end
