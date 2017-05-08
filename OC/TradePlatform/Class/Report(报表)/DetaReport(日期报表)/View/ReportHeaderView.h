//
//  ReportHeaderView.h
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoWordsLabel.h"

@interface ReportHeaderView : UIView

/** 页面标题 */
@property (strong, nonatomic) UILabel *pageTitleLabel;
/** 客户数量 */
@property (strong, nonatomic) TwoWordsLabel *customerView;
/** 交易额 */
@property (strong, nonatomic) TwoWordsLabel *turnoverByView;
/** 客户数环比 */
@property (strong, nonatomic) TwoWordsLabel *customerMomView;
/** 交易额环比 */
@property (strong, nonatomic) TwoWordsLabel *turnoverByMomView;

@end
