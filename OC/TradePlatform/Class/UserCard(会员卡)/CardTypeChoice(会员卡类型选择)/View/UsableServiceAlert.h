//
//  UsableServiceAlert.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsableServiceAlert : UIView

/** 显示 */
- (void)show;
/** 销毁 */
- (void)dismiss;


/** 可用服务内容 */
@property (nonatomic, strong) UILabel *usableServiceContentLabel;

@end
