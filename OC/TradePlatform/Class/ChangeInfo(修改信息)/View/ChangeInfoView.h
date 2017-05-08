//
//  ChangeInfoView.h
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeInfoView : UIView

/** 修改信息输入框 */
@property (strong, nonatomic) UITextField *changeTextField;

/** 修改手机号的输入框限制 */
- (RACSignal *)changePhoneTextFieldSignal;
/** 修改姓名的输入框限制 */
- (RACSignal *)changeNameTextFieldSignal;
/** 修改密码的输入框限制 */
- (RACSignal *)changePassWordTextFieldSignal;

@end
