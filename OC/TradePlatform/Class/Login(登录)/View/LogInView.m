//
//  LogInView.m
//  CarRepairFactory
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LogInView.h"
#import "ZYKeyboardUtil.h"


@interface LogInView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *loginScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *loginView;

/** logo背景 */
@property (strong, nonatomic) UIView *backView;
/** logo图片 */
@property (strong, nonatomic) UIImageView *logoImage;
/** 背景图片 */
@property (strong, nonatomic) UIImageView *backImage;
/** 登录按钮（密码登陆） */
@property (strong, nonatomic) UIButton *passwordLoginShadowImage;
/** 登录按钮（验证码登陆） */
@property (strong, nonatomic) UIButton *verificationLoginShadowImage;


/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation LogInView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self logInLayoutView];
        // 输入框响应
        // 密码登陆输入框响应，控制登陆按钮是否可用
        [self passwordLoginInputSignal];
        // 验证码登陆输入框响应，控制登陆按钮是否可用
        [self verificationLoginInputSignal];
        // 操作键盘弹出
        self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
        @weakify(self)
        [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
            @strongify(self)
            [keyboardUtil adaptiveViewHandleWithAdaptiveView:self, nil];
        }];
    }
    return self;
}
#pragma mark - 按钮点击方法
// 密码登陆，验证码登陆切换
- (void)loginModeBtnAction:(UIButton *)button {
    // 密码登陆，验证码登陆，按钮文字切换
    self.loginMode.selected = !self.loginMode.selected;
    // 用户名（密码登陆)输入框显示或隐藏
    self.passwordUserName.hidden = !self.passwordUserName.hidden;
    // 用户名（验证码登陆）输入框显示或隐藏
    self.verificationUserName.hidden = !self.verificationUserName.hidden;
    // 验证码输入框显示或隐藏
    self.verification.hidden = !self.verification.hidden;
    // 密码输入框隐藏
    self.userPassword.hidden = !self.userPassword.hidden;
    // 验证码输入框内容清空
    self.verification.contentField.text = nil;
    // 密码输入框内容清空
    self.userPassword.contentField.text = nil;
    // 登陆按钮的显示和隐藏
    self.verificationLoginBtn.hidden = !self.verificationLoginBtn.hidden;
    self.verificationLoginShadowImage.hidden = !self.verificationLoginShadowImage.hidden;
    self.passwordLoginBtn.hidden = !self.passwordLoginBtn.hidden;
    self.passwordLoginShadowImage.hidden = !self.passwordLoginShadowImage.hidden;
    // 判断是密码登陆还是验证码登陆
    if (self.loginMode.selected) { // 验证码登陆
        self.verificationUserName.contentField.text = self.passwordUserName.contentField.text;
        [self.verificationUserName.contentField becomeFirstResponder];
        self.passwordUserName.contentField.text = nil;
    }else { // 密码登陆
        self.passwordUserName.contentField.text = self.verificationUserName.contentField.text;
        [self.passwordUserName.contentField becomeFirstResponder];
        self.verificationUserName.contentField.text = nil;
    }
}
// 用户密码显示隐藏
- (void)userPasswordExplicitAndimplicitBtnAction:(UIButton *)button {
    self.userPassword.contentField.secureTextEntry = !self.userPassword.contentField.secureTextEntry;
    self.userPassword.tfBtn.selected  = !self.userPassword.tfBtn.selected;
}
#pragma mark - 布局视图
- (void)logInLayoutView {
    /** 背景scrollview */
    self.loginScrollView = [[UIScrollView alloc] init];
    self.loginScrollView.backgroundColor = WhiteColor;
    [self addSubview:self.loginScrollView];
    /** 填充scrollview的view */
    self.loginView = [[UIView alloc] init];
    self.loginView.backgroundColor = CLEARCOLOR;
    [self.loginScrollView addSubview:self.loginView];
    // 添加回收键盘的手势
    UITapGestureRecognizer *loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTapAction:)];
    [self.loginView addGestureRecognizer:loginTap];
    [self.loginScrollView addGestureRecognizer:loginTap];
    /*==================================登录界面==================================*/
    /** logo背景 */
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = ThemeColor;
    [self.loginView addSubview:self.backView];
    /** logo图片 */
    self.logoImage = [[UIImageView alloc] init];
    self.logoImage.image = [UIImage imageNamed:@"placeholder_logo_colour"];
    [self.backView addSubview:self.logoImage];
    /** 背景图片 */
    self.backImage = [[UIImageView alloc] init];
    self.backImage.image = [UIImage imageNamed:@"home_show_back"];
    [self.backView addSubview:self.backImage];
    
    /** 用户名（密码登陆） */
    self.passwordUserName = [[LoginFieldBtnView alloc] init];
    self.passwordUserName.loginCellStyleType = PureTnputBoxType;
    self.passwordUserName.contentField.placeholder = @"请输入用户名或手机号";
    self.passwordUserName.contentField.font = FifteenTypeface;
    [self.passwordUserName.contentField setValue:FifteenTypeface forKeyPath:@"_placeholderLabel.font"];
    [self.loginView addSubview:self.passwordUserName];
    /** 用户名（验证码登陆） */
    self.verificationUserName = [[LoginFieldBtnView alloc] init];
    self.verificationUserName.contentField.placeholder = @"请输入手机号";
    self.verificationUserName.contentField.font = FifteenTypeface;
    [self.verificationUserName.contentField setValue:FifteenTypeface forKeyPath:@"_placeholderLabel.font"];
    [self.verificationUserName.tfBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verificationUserName.tfBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.verificationUserName.tfBtn.titleLabel.font = FourteenTypeface;
    [self.loginView addSubview:self.verificationUserName];
    [self.verificationUserName setHidden:YES];
    /** 用户密码 */
    self.userPassword = [[LoginFieldBtnView alloc] init];
    self.userPassword.contentField.secureTextEntry = YES;
    self.userPassword.tfDividingLine.hidden = YES;
    self.userPassword.contentField.placeholder = @"请输入6-16位密码";
    self.userPassword.contentField.font = FifteenTypeface;
    [self.userPassword.contentField setValue:FifteenTypeface forKeyPath:@"_placeholderLabel.font"];
    [self.userPassword.tfBtn setImage:[UIImage imageNamed:@"logo_passwork_display"] forState:UIControlStateNormal];
    [self.userPassword.tfBtn setImage:[UIImage imageNamed:@"logo_passwork_hide"] forState:UIControlStateSelected];
    [self.userPassword.tfBtn addTarget:self action:@selector(userPasswordExplicitAndimplicitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView addSubview:self.userPassword];
    /** 验证码 */
    self.verification = [[LoginFieldBtnView alloc] init];
    self.verification.loginCellStyleType = PureTnputBoxType;
    self.verification.contentField.placeholder = @"请输入验证码";
    self.verification.contentField.font = FifteenTypeface;
    [self.verification.contentField setValue:FifteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.verification.contentField.keyboardType = UIKeyboardTypePhonePad;
    [self.loginView addSubview:self.verification];
    [self.verification setHidden:YES];

    
    /** 登录按钮（密码登陆） */
    self.passwordLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.passwordLoginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [self.passwordLoginBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.passwordLoginBtn.titleLabel.font = EighteenTypeface;
    [self.passwordLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_back"] forState:UIControlStateSelected];
    [self.passwordLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_no_btn_back"] forState:UIControlStateNormal];
    self.passwordLoginBtn.adjustsImageWhenHighlighted = NO;
    self.passwordLoginBtn.tag = LoginBtnAction;
    [self.loginView addSubview:self.passwordLoginBtn];
    
    /** 登录按钮（验证码登陆） */
    self.verificationLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.verificationLoginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [self.verificationLoginBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.verificationLoginBtn.titleLabel.font = EighteenTypeface;
    [self.verificationLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_back"] forState:UIControlStateSelected];
    [self.verificationLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_no_btn_back"] forState:UIControlStateNormal];
    self.verificationLoginBtn.adjustsImageWhenHighlighted = NO;
    self.verificationLoginBtn.tag = LoginBtnAction;
    [self.loginView addSubview:self.verificationLoginBtn];
    [self.verificationLoginBtn setHidden:YES];
    
    /** 登录按钮（密码登陆） */
    self.passwordLoginShadowImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.passwordLoginShadowImage setBackgroundImage:[UIImage imageNamed:@"login_btn_shadow"] forState:UIControlStateSelected];
    [self.passwordLoginShadowImage setBackgroundImage:[UIImage imageNamed:@"login_no_btn_shadow"] forState:UIControlStateNormal];
    [self.loginView addSubview:self.passwordLoginShadowImage];
    /** 登录按钮（验证码登陆） */
    self.verificationLoginShadowImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.verificationLoginShadowImage setBackgroundImage:[UIImage imageNamed:@"login_btn_shadow"] forState:UIControlStateSelected];
    [self.verificationLoginShadowImage setBackgroundImage:[UIImage imageNamed:@"login_no_btn_shadow"] forState:UIControlStateNormal];
    [self.loginView addSubview:self.verificationLoginShadowImage];
    [self.verificationLoginShadowImage setHidden:YES];

    
    // 切换登录方式
    self.loginMode = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginMode setTitle:@"验证码登录" forState:UIControlStateNormal];
    [self.loginMode setTitle:@"密码登录" forState:UIControlStateSelected];
    [self.loginMode setTitleColor:GrayH2 forState:UIControlStateNormal];
    self.loginMode.titleLabel.font = FourteenTypeface;
    [self.loginMode addTarget:self action:@selector(loginModeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView addSubview:self.loginMode];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.loginScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.loginScrollView.mas_top);
        make.left.equalTo(self.loginScrollView.mas_left);
        make.bottom.equalTo(self.loginScrollView.mas_bottom);
        make.right.equalTo(self.loginScrollView.mas_right);
        make.width.equalTo(self.loginScrollView.mas_width);
    }];
    /*==================================登录界面==================================*/
    /** logo背景 */
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.loginView.mas_top);
        make.left.equalTo(self.loginView.mas_left);
        make.right.equalTo(self.loginView.mas_right);
        make.height.mas_equalTo(@200);
    }];
    /** logo图片 */
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.backView.mas_centerX);
        make.centerY.equalTo(self.backView.mas_centerY);
    }];
    /** 背景图片 */
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.backView.mas_bottom);
        make.left.equalTo(self.backView.mas_left);
        make.right.equalTo(self.backView.mas_right);
    }];
    
    /** 用户名（密码登陆） */
    [self.passwordUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView.mas_bottom).offset(45);
        make.left.equalTo(self.loginView.mas_left).offset(16);
        make.right.equalTo(self.loginView.mas_right).offset(-16);
        make.height.mas_equalTo(@39);
    }];
    /** 用户名（验证码登陆） */
    [self.verificationUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView.mas_bottom).offset(45);
        make.left.equalTo(self.loginView.mas_left).offset(16);
        make.right.equalTo(self.loginView.mas_right).offset(-16);
        make.height.mas_equalTo(@39);
    }];
    /** 用户密码 */
    [self.userPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.passwordUserName.mas_bottom).offset(10);
        make.left.equalTo(self.loginView.mas_left).offset(16);
        make.right.equalTo(self.loginView.mas_right).offset(-16);
        make.height.mas_equalTo(@44);
    }];
    /** 验证码 */
    [self.verification mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.verificationUserName.mas_bottom).offset(10);
        make.left.equalTo(self.loginView.mas_left).offset(16);
        make.right.equalTo(self.loginView.mas_right).offset(-16);
        make.height.mas_equalTo(@44);
    }];
    // 切换登录方式
    [self.loginMode mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.verification.mas_bottom).offset(20);
        make.right.equalTo(self.loginView.mas_right).offset(-32);
    }];
    
    /** 登录按钮（密码登陆） */
    [self.passwordLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.loginMode.mas_bottom).offset(50);
        make.left.equalTo(self.loginView.mas_left).offset(16);
        make.right.equalTo(self.loginView.mas_right).offset(-16);
        make.height.mas_equalTo(@48);
    }];
    /** 登录按钮（验证码登陆） */
    [self.verificationLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.loginMode.mas_bottom).offset(50);
        make.left.equalTo(self.loginView.mas_left).offset(16);
        make.right.equalTo(self.loginView.mas_right).offset(-16);
        make.height.mas_equalTo(@48);
    }];
    /** 登录按钮（密码登陆） */
    [self.passwordLoginShadowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.verificationLoginBtn.mas_bottom);
        make.left.equalTo(self.verificationLoginBtn.mas_left);
        make.right.equalTo(self.verificationLoginBtn.mas_right);
    }];
    /** 登录按钮（验证码登陆） */
    [self.verificationLoginShadowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.verificationLoginBtn.mas_bottom);
        make.left.equalTo(self.verificationLoginBtn.mas_left);
        make.right.equalTo(self.verificationLoginBtn.mas_right);
    }];
    /** 填充scrollview的高度 */
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.verificationLoginBtn.mas_bottom).offset(50);
    }];
}
#pragma mark - 输入框响应
// 密码登陆输入框响应，控制登陆按钮是否可用
- (void)passwordLoginInputSignal {
    // 获取账户signal
    RACSignal *accountTFSignal = self.passwordUserName.contentField.rac_textSignal;
    // 判断账户输入框输入位是否为空
    RACSignal *accountName =
    [accountTFSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    // 获取账户signal
    RACSignal *passworkTFSignal = self.userPassword.contentField.rac_textSignal;
    // 判断账户输入框最大输入位数
    RACSignal *passworkMaxNumber =
    [passworkTFSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制账号输入框可输入位数
    RAC(self.userPassword.contentField, text) =
    [passworkMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.userPassword.contentField.text substringToIndex:16] : self.userPassword.contentField.text;
    }];
    // 判断账户输入框最小输入位数
    RACSignal *passworkMinNumber =
    [passworkTFSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    // 聚合密码和用户信息
    RACSignal *passworkLoginSignal = [RACSignal combineLatest:@[accountName, passworkMinNumber]
                                            reduce:^id(NSNumber *accountName, NSNumber *passworkMinNumber){
                                                return @([accountName boolValue]&&[passworkMinNumber boolValue]);
                                            }];
    // 根据输入框，修改登陆按钮背景图片属性
    RAC(self.passwordLoginBtn, selected) =
    [passworkLoginSignal map:^id(NSNumber *accountNumberTF){
        return @([accountNumberTF boolValue]);
    }];
    // 根据输入框，修改登陆按钮是否可点击属性
    RAC(self.passwordLoginBtn, enabled) =
    [passworkLoginSignal map:^id(NSNumber *accountNumberTF){
        return @([accountNumberTF boolValue]);
    }];
    // 根据输入框，修改登陆按钮（密码登陆）下方阴影
    RAC(self.passwordLoginShadowImage, selected) =
    [passworkLoginSignal map:^id(NSNumber *accountNumberTF){
        return @([accountNumberTF boolValue]);
    }];
}

// 验证码输入框响应，控制获取验证码按钮是否可用
- (RACSignal *)verificationCodeInputSignal {
    // 获取账户signal
    RACSignal *verificationUserNameTFSignal = self.verificationUserName.contentField.rac_textSignal;
    // 判断账户输入框最大输入位数
    RACSignal *verificationUserNameMaxNumber =
    [verificationUserNameTFSignal map:^id(NSString *text) {
        return @(text.length > 10);
    }];
    // 限制账号输入框可输入位数
    RAC(self.verificationUserName.contentField, text) =
    [verificationUserNameMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.verificationUserName.contentField.text substringToIndex:11] : self.verificationUserName.contentField.text;
    }];
    // 判断账户输入框输入内容，是否为手机号
    RACSignal *iphoneSignal =
    [verificationUserNameTFSignal map:^id(NSString *text) {
        return @([CustomObject checkTel:text]);
    }];
    // 根据账户输入框，修改验证码按钮背景颜色属性
    RAC(self.verificationUserName.tfBtn.titleLabel, textColor) =
    [iphoneSignal map:^id(NSNumber *verificationUserNameTFSignal){
        return[verificationUserNameTFSignal boolValue] ? ThemeColor:NotClick;
    }];
    // 根据账户输入框，修改验证码按钮是否可点击属性
    RAC(self.verificationUserName.tfBtn, enabled) =
    [iphoneSignal map:^id(NSNumber *verificationUserNameTFSignal){
        return@([verificationUserNameTFSignal boolValue]);
    }];
    return iphoneSignal;
}

// 验证码登陆输入框响应，控制登陆按钮是否可用
- (void)verificationLoginInputSignal {
    // 验证码输入框响应，控制获取验证码按钮是否可用
    RACSignal *iphoneSignal = [self verificationCodeInputSignal];
    // 获取密码signal
    RACSignal *verificationCodeTFSignal = self.verification.contentField.rac_textSignal;
    // 判断密码输入框位数
    RACSignal *verificationCodeNmuber =
    [verificationCodeTFSignal map:^id(NSString *text) {
        return @(text.length > 3);
    }];
    // 限制账号输入框位数
    RAC(self.verification.contentField, text) =
    [verificationCodeNmuber map:^id(NSNumber *verificationCodeTF){
        return [verificationCodeTF boolValue] ? [self.verification.contentField.text substringToIndex:4] : self.verification.contentField.text;
    }];
    // 聚合密码和用户信息
    RACSignal *verificationLoginSignal = [RACSignal combineLatest:@[iphoneSignal, verificationCodeNmuber]
                                                       reduce:^id(NSNumber *iphoneSignal, NSNumber *verificationCodeNmuber){
                                                           return @([iphoneSignal boolValue]&&[verificationCodeNmuber boolValue]);
                                                       }];
    // 根据输入框，修改登陆按钮背景图片属性
    RAC(self.verificationLoginBtn, selected) =
    [verificationLoginSignal map:^id(NSNumber *accountNumberTF){
        return @([accountNumberTF boolValue]);
    }];
    // 根据输入框，修改登陆按钮是否可点击属性
    RAC(self.verificationLoginBtn, enabled) =
    [verificationLoginSignal map:^id(NSNumber *accountNumberTF){
        return@([accountNumberTF boolValue]);
    }];
    // 根据输入框，修改登陆按钮（验证码登陆）下方阴影
    RAC(self.verificationLoginShadowImage, selected) =
    [verificationLoginSignal map:^id(NSNumber *accountNumberTF){
        return @([accountNumberTF boolValue]);
    }];
}


#pragma mark - 回收键盘的方法
- (void)loginTapAction:(UIButton *)button {
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end

