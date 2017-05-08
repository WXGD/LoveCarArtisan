//
//  UserCarView.h
//  TradePlatform
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCarView : UIView

/** 车辆品牌图片 */
@property (strong, nonatomic) UIImageView *carBrandImage;
/** 车辆品牌 */
@property (strong, nonatomic) UILabel *carBrandLabel;
/** 车辆车牌 */
@property (strong, nonatomic) UILabel *carPlnLabel;
/** 编辑按钮 */
@property (strong, nonatomic) UIButton *editBtn;
/** 二手车估值 */
@property (strong, nonatomic) UIButton *useCarValuationBtn;
/** 查保险 */
@property (strong, nonatomic) UIButton *quiryBenefitBtn;

@end
