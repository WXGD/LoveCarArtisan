//
//  ChangeInfoView.m
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChangeInfoView.h"

@interface ChangeInfoView ()


@end

@implementation ChangeInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self changeInfoLayoutView];
    }
    return self;
}

- (void)changeInfoLayoutView {

    /** 修改信息输入框 */
    self.changeTextField = [[UITextField alloc] init];
    self.changeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.changeTextField setValue:FifteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.changeTextField.font = FifteenTypeface;
    [self addSubview:self.changeTextField];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 修改信息输入框 */
    [self.changeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    /** self高度 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
}

#pragma mark - 输入框响应
// 修改姓名的输入框限制
- (RACSignal *)changeNameTextFieldSignal {
    // 获取姓名signal
    RACSignal *phoneSignal = self.changeTextField.rac_textSignal;
    // 判断姓名输入框输入位数
    RACSignal *phoneNum = [phoneSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    return phoneNum;
}

// 修改密码的输入框限制
- (RACSignal *)changePassWordTextFieldSignal {
    // 获取密码signal
    RACSignal *passworkTFSignal = self.changeTextField.rac_textSignal;
    // 判断账户输入框最大输入位数
    RACSignal *passworkMaxNumber =
    [passworkTFSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制账号输入框可输入位数
    RAC(self.changeTextField, text) =
    [passworkMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.changeTextField.text substringToIndex:16] : self.changeTextField.text;
    }];
    // 判断账户输入框最小输入位数
    RACSignal *passworkMinNumber =
    [passworkTFSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    return passworkMinNumber;
}

// 修改手机号的输入框限制
- (RACSignal *)changePhoneTextFieldSignal {
    // 获取手机号signal
    RACSignal *phoneSignal = self.changeTextField.rac_textSignal;
    // 判断账户输入框输入位数
    RACSignal *phoneNum = [phoneSignal map:^id(NSString *text) {
        return @(text.length > 10);
    }];
    // 限制账号输入框可输入位数
    RAC(self.changeTextField, text) =
    [phoneNum map:^id(NSNumber *phoneNumberTF){
        return [phoneNumberTF boolValue] ? [self.changeTextField.text substringToIndex:11] : self.changeTextField.text;
    }];
    RACSignal *phoneType = [phoneSignal map:^id(NSString *text) {
        return @([CustomObject checkTel:text]);
    }];
    // 聚合以上信息,获取手机号限制
    RACSignal *phoneSig = [RACSignal combineLatest:@[phoneNum, phoneType]
                                      reduce:^id(NSNumber *phoneNum, NSNumber *phoneType){
                                          return @([phoneNum boolValue]&&[phoneType boolValue]);
                                      }];
    return phoneSig;
}


@end
