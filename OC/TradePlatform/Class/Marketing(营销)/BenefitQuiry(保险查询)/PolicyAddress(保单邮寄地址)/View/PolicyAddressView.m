//
//  PolicyAddressView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PolicyAddressView.h"
#import "ZYKeyboardUtil.h"

@interface PolicyAddressView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *policyAddressScrollView;
/** 空白view */
@property (strong, nonatomic) UIView *whiteUpView;
@property (strong, nonatomic) UIView *whiteDownView;
/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation PolicyAddressView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self policyAddressLayoutView];
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

- (void)policyAddressLayoutView {
    /** 背景scrollview */
    self.policyAddressScrollView = [[UIScrollView alloc] init];
    self.policyAddressScrollView.backgroundColor = VCBackground;
    [self addSubview:self.policyAddressScrollView];
    /** 填充scrollview的view */
    self.policyAddressBackView = [[UIStackView alloc] init];
    self.policyAddressBackView.axis = UILayoutConstraintAxisVertical;
    [self.policyAddressScrollView addSubview:self.policyAddressBackView];
    UITapGestureRecognizer *policyAddressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(policyAddressTapAction)];
    [self.policyAddressBackView addGestureRecognizer:policyAddressTap];
    /** 空白view */
    self.whiteUpView = [[UIView alloc] init];
    self.whiteUpView.backgroundColor = WhiteColor;
    [self.policyAddressBackView addArrangedSubview:self.whiteUpView];
    /** 受保车辆 */
    self.theCarNumView = [[UsedCellView alloc] init];
    self.theCarNumView.cellLabel.text = @"";
    self.theCarNumView.cellLabel.font = FourteenTypeface;
    self.theCarNumView.cellLabel.textColor = Black;
    self.theCarNumView.describeLabel.font = FourteenTypeface;
    self.theCarNumView.describeLabel.textColor = BlackH1;
    self.theCarNumView.isArrow = YES;
    self.theCarNumView.isCellImage = YES;
    self.theCarNumView.isCellBtn = YES;
    self.theCarNumView.isSplistLine = YES;
    [self.policyAddressBackView addArrangedSubview:self.theCarNumView];
    /** 保单实付金额 */
    self.theAmountView = [[UsedCellView alloc] init];
    self.theAmountView.cellLabel.text = @"保单实付金额：";
    self.theAmountView.cellLabel.font = FourteenTypeface;
    self.theAmountView.cellLabel.textColor = BlackH1;
    self.theAmountView.viceLabel.font = FourteenTypeface;
    self.theAmountView.viceLabel.textColor = HEXSTR_RGB(@"ef5350");
    self.theAmountView.isArrow = YES;
    self.theAmountView.isCellImage = YES;
    self.theAmountView.isCellBtn = YES;
    self.theAmountView.isSplistLine = YES;
    [self.policyAddressBackView addArrangedSubview:self.theAmountView];
    /** 空白view */
    self.whiteDownView = [[UIView alloc] init];
    self.whiteDownView.backgroundColor = WhiteColor;
    [self.policyAddressBackView addArrangedSubview:self.whiteDownView];
    /** 车主信息 */
    self.theCarInfoView = [[UsedCellView alloc] init];
    self.theCarInfoView.backgroundColor = VCBackground;
    self.theCarInfoView.cellLabel.text = @"车主信息";
    self.theCarInfoView.cellLabel.font = FifteenTypeface;
    self.theCarInfoView.cellLabel.textColor = HEXSTR_RGB(@"1a1a1a");
    self.theCarInfoView.isArrow = YES;
    self.theCarInfoView.isCellImage = YES;
    self.theCarInfoView.isCellBtn = YES;
    self.theCarInfoView.isSplistLine = YES;
    [self.policyAddressBackView addArrangedSubview:self.theCarInfoView];
    /** 车主姓名 */
    self.theNameView = [[UsedCellView alloc] init];
    self.theNameView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.theNameView.dividingLineChoice = DividingLineFullScreenLayout;
    self.theNameView.cellLabel.text = @"车主姓名";
    self.theNameView.cellLabel.font = FourteenTypeface;
    self.theNameView.cellLabel.textColor = Black;
    self.theNameView.viceTextFiled.font = FourteenTypeface;
    self.theNameView.viceTextFiled.textColor = Black;
    self.theNameView.viceTextFiled.placeholder = @"请输入车主姓名";
    self.theNameView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.theNameView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.theNameView.isArrow = YES;
    self.theNameView.isCellImage = YES;
    self.theNameView.isCellBtn = YES;
    [self.policyAddressBackView addArrangedSubview:self.theNameView];
    /** 身份证号 */
    self.theCardIdView = [[UsedCellView alloc] init];
    self.theCardIdView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.theCardIdView.dividingLineChoice = DividingLineFullScreenLayout;
    self.theCardIdView.cellLabel.text = @"身份证号";
    self.theCardIdView.cellLabel.font = FourteenTypeface;
    self.theCardIdView.cellLabel.textColor = Black;
    self.theCardIdView.viceTextFiled.font = FourteenTypeface;
    self.theCardIdView.viceTextFiled.textColor = Black;
    self.theCardIdView.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.theCardIdView.viceTextFiled.placeholder = @"请输入车主身份证号";
    self.theCardIdView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.theCardIdView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.theCardIdView.viceTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.theCardIdView.isArrow = YES;
    self.theCardIdView.isCellImage = YES;
    self.theCardIdView.isCellBtn = YES;
    self.theCardIdView.isSplistLine = YES;
    [self.policyAddressBackView addArrangedSubview:self.theCardIdView];
    /** 收件信息 */
    self.theRecipientInfoView = [[UsedCellView alloc] init];
    self.theRecipientInfoView.backgroundColor = VCBackground;
    self.theRecipientInfoView.cellLabel.text = @"收件信息";
    self.theRecipientInfoView.cellLabel.font = FifteenTypeface;
    self.theRecipientInfoView.cellLabel.textColor = HEXSTR_RGB(@"1a1a1a");
    self.theRecipientInfoView.isArrow = YES;
    self.theRecipientInfoView.isCellImage = YES;
    self.theRecipientInfoView.isCellBtn = YES;
    self.theRecipientInfoView.isSplistLine = YES;
    [self.policyAddressBackView addArrangedSubview:self.theRecipientInfoView];
    /** 收件人姓名 */
    self.theRecipientNameView = [[UsedCellView alloc] init];
    self.theRecipientNameView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.theRecipientNameView.dividingLineChoice = DividingLineFullScreenLayout;
    self.theRecipientNameView.cellLabel.text = @"收件人姓名";
    self.theRecipientNameView.cellLabel.font = FourteenTypeface;
    self.theRecipientNameView.cellLabel.textColor = Black;
    self.theRecipientNameView.viceTextFiled.font = FourteenTypeface;
    self.theRecipientNameView.viceTextFiled.textColor = Black;
    self.theRecipientNameView.viceTextFiled.placeholder = @"请输入收件人姓名";
    self.theRecipientNameView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.theRecipientNameView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.theRecipientNameView.isArrow = YES;
    self.theRecipientNameView.isCellImage = YES;
    self.theRecipientNameView.isCellBtn = YES;
    [self.policyAddressBackView addArrangedSubview:self.theRecipientNameView];
    /** 收件人手机号 */
    self.theRecipientPhoneView = [[UsedCellView alloc] init];
    self.theRecipientPhoneView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.theRecipientPhoneView.dividingLineChoice = DividingLineFullScreenLayout;
    self.theRecipientPhoneView.cellLabel.text = @"收件人手机号";
    self.theRecipientPhoneView.cellLabel.font = FourteenTypeface;
    self.theRecipientPhoneView.cellLabel.textColor = Black;
    self.theRecipientPhoneView.viceTextFiled.font = FourteenTypeface;
    self.theRecipientPhoneView.viceTextFiled.textColor = Black;
    self.theRecipientPhoneView.viceTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.theRecipientPhoneView.viceTextFiled.placeholder = @"请输入收件人手机号";
    self.theRecipientPhoneView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.theRecipientPhoneView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.theRecipientPhoneView.viceTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.theRecipientPhoneView.isArrow = YES;
    self.theRecipientPhoneView.isCellImage = YES;
    self.theRecipientPhoneView.isCellBtn = YES;
    [self.policyAddressBackView addArrangedSubview:self.theRecipientPhoneView];
    /** 收件地址 */
    self.theRecipientAddressView = [[UsedCellView alloc] init];
    self.theRecipientAddressView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.theRecipientAddressView.dividingLineChoice = DividingLineFullScreenLayout;
    self.theRecipientAddressView.cellLabel.text = @"收件地址";
    self.theRecipientAddressView.cellLabel.font = FourteenTypeface;
    self.theRecipientAddressView.cellLabel.textColor = Black;
    self.theRecipientAddressView.viceTextFiled.font = FourteenTypeface;
    self.theRecipientAddressView.viceTextFiled.textColor = GrayH3;
    self.theRecipientAddressView.viceTextFiled.placeholder = @"选择省市县";
    self.theRecipientAddressView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.theRecipientAddressView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.theRecipientAddressView.isArrow = YES;
    self.theRecipientAddressView.isCellImage = YES;
    [self.policyAddressBackView addArrangedSubview:self.theRecipientAddressView];
    /** 详细地址 */
    self.theAddressDetailView = [[UsedCellView alloc] init];
    self.theAddressDetailView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.theAddressDetailView.dividingLineChoice = DividingLineFullScreenLayout;
    self.theAddressDetailView.cellLabel.text = @"详细地址";
    self.theAddressDetailView.cellLabel.font = FourteenTypeface;
    self.theAddressDetailView.cellLabel.textColor = Black;
    self.theAddressDetailView.viceTextFiled.font = FourteenTypeface;
    self.theAddressDetailView.viceTextFiled.textColor = Black;
    self.theAddressDetailView.viceTextFiled.placeholder = @"请输入街道、楼牌号";
    self.theAddressDetailView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.theAddressDetailView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.theAddressDetailView.isArrow = YES;
    self.theAddressDetailView.isCellImage = YES;
    self.theAddressDetailView.isCellBtn = YES;
    [self.policyAddressBackView addArrangedSubview:self.theAddressDetailView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.policyAddressScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.policyAddressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.policyAddressScrollView.mas_top);
        make.left.equalTo(self.policyAddressScrollView.mas_left);
        make.bottom.equalTo(self.policyAddressScrollView.mas_bottom);
        make.right.equalTo(self.policyAddressScrollView.mas_right);
        make.width.equalTo(self.policyAddressScrollView.mas_width);
    }];
    
    /*================== 用户信息  ================*/
    /** whiteUpView */
    [self.whiteUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.policyAddressBackView.mas_top).offset(0);
        make.height.mas_equalTo(@11);
    }];
    /** 受保车辆 */
    [self.theCarNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@26);
    }];
    /** 车牌号 */
    [self.theAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@26);
    }];
    /** whiteDownView */
    [self.whiteDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@11);
    }];
    /** 车主信息 */
    [self.theCarInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@35);
    }];
    /** 车主姓名 */
    [self.theNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 身份证号 */
    [self.theCardIdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 收件信息 */
    [self.theRecipientInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@35);
    }];
    /** 收件人姓名 */
    [self.theRecipientNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 收件人手机号 */
    [self.theRecipientPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 收件地址 */
    [self.theRecipientAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 详细地址 */
    [self.theAddressDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 填充scrollview的view的高度 */
//    [self.policyAddressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.bottom.equalTo(self.theAddressDetailView.mas_bottom);
//    }];
}
#pragma mark - 回收键盘
- (void)policyAddressTapAction {
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - 输入框响应
// 输入框响应
- (void)policyAddressTFInputSignal {
    // 获取身份证号signal
    RACSignal *theCardIdSignal = self.theCardIdView.viceTextFiled.rac_textSignal;
    // 判断身份证输入框最大输入位数
    RACSignal *theCardIdMaxNumber =
    [theCardIdSignal map:^id(NSString *text) {
        return @(text.length > 17);
    }];
    // 限制身份证号输入框可输入位数
    RAC(self.theCardIdView.viceTextFiled, text) =
    [theCardIdMaxNumber map:^id(NSNumber *theCardIdNumberTF){
        return [theCardIdNumberTF boolValue] ? [self.theCardIdView.viceTextFiled.text substringToIndex:18] : self.theCardIdView.viceTextFiled.text;
    }];
    // 获取手机号signal
    RACSignal *phoneSignal = self.theRecipientPhoneView.viceTextFiled.rac_textSignal;
    // 判断手机号输入框最大输入位数
    RACSignal *phoneMaxNumber =
    [phoneSignal map:^id(NSString *text) {
        return @(text.length > 10);
    }];
    // 限制手机号输入框可输入位数
    RAC(self.theRecipientPhoneView.viceTextFiled, text) =
    [phoneMaxNumber map:^id(NSNumber *phoneNumberTF){
        return [phoneNumberTF boolValue] ? [self.theRecipientPhoneView.viceTextFiled.text substringToIndex:11] : self.theRecipientPhoneView.viceTextFiled.text;
    }];
}


@end
