//
//  DataGroupHeaderView.h
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataGroupHeaderView : UICollectionReusableView

/** 支付方式 */
@property (strong, nonatomic) UILabel *payWayLabel;
/** 开始日期 */
@property (strong, nonatomic) UIButton *startDataBtn;
/** 结束日期 */
@property (strong, nonatomic) UIButton *endDataBtn;

@end
