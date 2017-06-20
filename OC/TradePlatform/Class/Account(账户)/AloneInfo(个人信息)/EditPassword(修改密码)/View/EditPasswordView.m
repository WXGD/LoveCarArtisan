//
//  EditPasswordView.m
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditPasswordView.h"

@interface EditPasswordView ()

/** 旧密码标记view */
@property (strong, nonatomic) UIView *oldSignView;
/** 新密码标记view */
@property (strong, nonatomic) UIView *novelSignView;
/** 确认密码标记view */
@property (strong, nonatomic) UIView *confirmSignView;

@end

@implementation EditPasswordView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self editPasswordLayoutView];
        // 修改旧密码，新秘密，确认密码的输入框限制
        [self changePassworkTextFieldSignal];
    }
    return self;
}
#pragma mark - view布局
- (void)editPasswordLayoutView {
    /** 旧密码 */
    self.oldPasswordView = [[CustomCell alloc] init];
    self.oldPasswordView.lineStyle = NotLine;
    self.oldPasswordView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.oldPasswordView.mainLabel.text = @"旧密码";
    self.oldPasswordView.mainLabel.font = FifteenTypeface;
    self.oldPasswordView.mainLabel.textColor = Black;
    self.oldPasswordView.viceTF.placeholder = @"请输入6~16位旧密码";
    self.oldPasswordView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldPasswordView.viceTF.secureTextEntry = YES;
    [self addSubview:self.oldPasswordView];
    self.oldPasswordView.vTFLeftBorder = 95;
    [self.oldPasswordView.mainBtn setHidden:YES];
    /** 旧密码标记view */
    self.oldSignView = [[UIView alloc] init];
    self.oldSignView.backgroundColor = VCBackground;
    [self addSubview:self.oldSignView];
    
    /** 新密码 */
    self.novelPasswordView = [[CustomCell alloc] init];
    self.novelPasswordView.lineStyle = NotLine;
    self.novelPasswordView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.novelPasswordView.mainLabel.text = @"新密码";
    self.novelPasswordView.mainLabel.font = FifteenTypeface;
    self.novelPasswordView.mainLabel.textColor = Black;
    self.novelPasswordView.viceTF.placeholder = @"请输入6~16位新密码";
    self.novelPasswordView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.novelPasswordView.viceTF.secureTextEntry = YES;
    [self addSubview:self.novelPasswordView];
    self.novelPasswordView.vTFLeftBorder = 95;
    [self.novelPasswordView.mainBtn setHidden:YES];
    /** 新密码标记view */
    self.novelSignView = [[UIView alloc] init];
    self.novelSignView.backgroundColor = VCBackground;
    [self addSubview:self.novelSignView];

    /** 确认密码 */
    self.confirmPasswordView = [[CustomCell alloc] init];
    self.confirmPasswordView.lineStyle = NotLine;
    self.confirmPasswordView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.confirmPasswordView.mainLabel.text = @"确认密码";
    self.confirmPasswordView.mainLabel.font = FifteenTypeface;
    self.confirmPasswordView.mainLabel.textColor = Black;
    self.confirmPasswordView.viceTF.placeholder = @"请再次输入6~16位新密码";
    self.confirmPasswordView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirmPasswordView.viceTF.secureTextEntry = YES;
    [self addSubview:self.confirmPasswordView];
    self.confirmPasswordView.vTFLeftBorder = 95;
    [self.confirmPasswordView.mainBtn setHidden:YES];
    /** 确认密码标记view */
    self.confirmSignView = [[UIView alloc] init];
    self.confirmSignView.backgroundColor = VCBackground;
    [self addSubview:self.confirmSignView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 旧密码 */
    [self.oldPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@30);
    }];
    /** 旧密码标记view */
    [self.oldSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.oldPasswordView.viceTF.mas_left);
        make.right.equalTo(self.oldPasswordView.viceTF.mas_right);
        make.bottom.equalTo(self.oldPasswordView.viceTF.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
    /** 新密码 */
    [self.novelPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.oldPasswordView.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 新密码标记view */
    [self.novelSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.novelPasswordView.viceTF.mas_left);
        make.right.equalTo(self.novelPasswordView.viceTF.mas_right);
        make.bottom.equalTo(self.novelPasswordView.viceTF.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
    /** 确认密码 */
    [self.confirmPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.novelPasswordView.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 确认密码标记view */
    [self.confirmSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.confirmPasswordView.viceTF.mas_left);
        make.right.equalTo(self.confirmPasswordView.viceTF.mas_right);
        make.bottom.equalTo(self.confirmPasswordView.viceTF.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
}



#pragma mark - 输入框响应
// 修改旧密码，新秘密，确认密码的输入框限制
- (void)changePassworkTextFieldSignal {
    
    /** 旧密码 */
    // 获取旧密码signal
    RACSignal *oldTFSignal = self.oldPasswordView.viceTF.rac_textSignal;
    // 判断旧密码输入框最大输入位数
    RACSignal *oldMaxNumber =
    [oldTFSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制旧密码输入框可输入位数
    RAC(self.oldPasswordView.viceTF, text) =
    [oldMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.oldPasswordView.viceTF.text substringToIndex:16] : self.oldPasswordView.viceTF.text;
    }];
    // 判断旧密码输入框最小输入位数
    RACSignal *oldMinNumber =
    [oldTFSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    
    /** 新密码 */
    // 获取旧密码signal
    RACSignal *newTFSignal = self.novelPasswordView.viceTF.rac_textSignal;
    // 判断旧密码输入框最大输入位数
    RACSignal *newTFMaxNumber =
    [newTFSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制旧密码输入框可输入位数
    RAC(self.novelPasswordView.viceTF, text) =
    [newTFMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.novelPasswordView.viceTF.text substringToIndex:16] : self.novelPasswordView.viceTF.text;
    }];
    // 判断旧密码输入框最小输入位数
    RACSignal *newTFMinNumber =
    [newTFSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    
    /** 确认密码 */
    // 获取旧密码signal
    RACSignal *confirmTFSignal = self.confirmPasswordView.viceTF.rac_textSignal;
    // 判断旧密码输入框最大输入位数
    RACSignal *confirmTFMaxNumber =
    [confirmTFSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制旧密码输入框可输入位数
    RAC(self.confirmPasswordView.viceTF, text) =
    [confirmTFMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.confirmPasswordView.viceTF.text substringToIndex:16] : self.confirmPasswordView.viceTF.text;
    }];
    // 判断旧密码输入框最小输入位数
    RACSignal *confirmTFMinNumber =
    [confirmTFSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    // 聚合以上信息
    self.aggregationInfo = [RACSignal combineLatest:@[oldMinNumber, newTFMinNumber, confirmTFMinNumber]
                                                   reduce:^id(NSNumber *oldMinNumber, NSNumber *newTFMinNumber, NSNumber *confirmTFMinNumber){
                                                       return @([oldMinNumber boolValue]&&[newTFMinNumber boolValue]&&[confirmTFMinNumber boolValue]);
                                                   }];
}



@end
