//
//  EditPasswordView.h
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPasswordView : UIView

/** 旧密码 */
@property (strong, nonatomic) CustomCell *oldPasswordView;
/** 新密码 */
@property (strong, nonatomic) CustomCell *novelPasswordView;
/** 确认密码 */
@property (strong, nonatomic) CustomCell *confirmPasswordView;
/** 聚合信息信号 */
@property (strong, nonatomic) RACSignal *aggregationInfo;

@end
