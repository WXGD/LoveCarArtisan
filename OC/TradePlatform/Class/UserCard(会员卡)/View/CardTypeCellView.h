//
//  CardTypeCellView.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardTypeCellView : UIView

/** 卡号 */
@property (nonatomic, strong) UILabel *cardNumLabel;
/** 卡名称 */
@property (nonatomic, strong) UILabel *cardNameLabel;
/** 卡类型 */
@property (nonatomic, strong) UILabel *cardTypeLabel;
/** 可用服务 */
@property (nonatomic, strong) UILabel *availableServiceLabel;
/** 用户会员卡 */
@property (strong, nonatomic) UIButton *userCardBtn;
/** 开卡 */
@property (strong, nonatomic) UIButton *openCardBtn;


@end
