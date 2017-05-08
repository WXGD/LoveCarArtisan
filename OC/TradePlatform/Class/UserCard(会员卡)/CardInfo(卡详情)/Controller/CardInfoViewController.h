//
//  CardInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// 模型
#import "CardTypeModel.h"

@interface CardInfoViewController : RootViewController

/** 卡详情模型 */
@property (strong, nonatomic) CardTypeModel *cardTypeInfoModel;
/** 返回按钮回调 */
@property (copy, nonatomic) void(^CardInfoBlock)(CardTypeModel *cardInfoModel);

@end
