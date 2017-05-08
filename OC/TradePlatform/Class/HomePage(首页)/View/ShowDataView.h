//
//  ShowDataView.h
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoWordsLabel.h"

@interface ShowDataView : UIView

/** 店铺时时数据 */
@property (strong, nonatomic) UsedCellView *showDataView;
/** 消费人数 */
@property (strong, nonatomic) TwoWordsLabel *csmPleNumView;
/** 营业额 */
@property (strong, nonatomic) TwoWordsLabel *turnoverView;

@end
