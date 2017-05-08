//
//  ChangePassworkView.h
//  TradePlatform
//
//  Created by apple on 2017/1/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePassworkView : UIView

/** 旧密码 */
@property (strong, nonatomic) UILabel *PWOldTitle;
/** 旧密码 */
@property (strong, nonatomic) UITextField *PWOldTF;

/** 新密码 */
@property (strong, nonatomic) UILabel *PWNewTitle;
/** 新密码 */
@property (strong, nonatomic) UITextField *PWNewTF;

/** 确认密码 */
@property (strong, nonatomic) UILabel *PWConfirmTitle;
/** 确认密码 */
@property (strong, nonatomic) UITextField *PWConfirmTF;

/** 修改旧密码，新秘密，确认密码的输入框限制 */
- (RACSignal *)changePassworkTextFieldSignal;

@end
