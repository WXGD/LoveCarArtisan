//
//  FiterConditionCell.h
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiterConditionCell : UICollectionViewCell

/** 标题 */
@property (strong, nonatomic) UILabel *titleLabel;
/** cell选中 */
@property (assign, nonatomic) BOOL isSelected;

@end
