//
//  DailyUserView.h
//  TradePlatform
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoWordsLabel.h"

@interface DailyUserView : UIView

/** 总用户数量 */
@property (strong, nonatomic) UILabel *userNum;
/** 男 */
@property (strong, nonatomic) TwoWordsLabel *maleSexLabel;
/** 女 */
@property (strong, nonatomic) TwoWordsLabel *femaleSexLabel;
/** 未知 */
@property (strong, nonatomic) TwoWordsLabel *unknownSexLabel;
/** 日期选择按钮 */
@property (strong, nonatomic) UIButton *detaChioceBtn;

@end
