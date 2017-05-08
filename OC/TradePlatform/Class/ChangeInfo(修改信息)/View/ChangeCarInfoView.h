//
//  ChangeCarInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeCarInfoView : UIView

/** 车牌号 */
@property (strong, nonatomic) UsedCellView *editPln;
/** 品牌车系 */
@property (strong, nonatomic) UsedCellView *editCar;

/** 修改车牌号的输入框限制 */
- (RACSignal *)changePlnTextFieldSignal;


@end
