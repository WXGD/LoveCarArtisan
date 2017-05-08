//
//  MarketingCell.h
//  TradePlatform
//
//  Created by apple on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketingProjectModel.h"

@interface MarketingCell : UIView


/** 营销项目logo */
@property (strong, nonatomic) UIImageView *marketingProjectLogo;
/** 营销项目名称 */
@property (strong, nonatomic) UILabel *marketingProjectName;
/** 营销项目副标题 */
@property (strong, nonatomic) UILabel *marketingProjectViceTitle;
/** 营销项目箭头 */
@property (strong, nonatomic) UIImageView *marketingProjectArrowImage;
/** 覆盖按钮 */
@property (strong, nonatomic) UIButton *marketingBtn;

@end
