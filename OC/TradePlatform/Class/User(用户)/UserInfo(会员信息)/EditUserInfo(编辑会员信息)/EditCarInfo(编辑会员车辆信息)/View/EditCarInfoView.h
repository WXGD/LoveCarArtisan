//
//  EditCarInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCarInfoView : UIView

/** 车牌号 */
@property (strong, nonatomic) CustomCell *editPln;
/** 品牌车系 */
@property (strong, nonatomic) CustomCell *editCar;
/** 品牌图片 */
@property (strong, nonatomic) UIImageView *editCarImage;
/** 聚合信息 */
@property (strong, nonatomic) RACSignal *aggregationInfo;

@end
