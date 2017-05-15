//
//  AccountBankAddView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AccountBankAddView.h"
#import "ZYKeyboardUtil.h"

@interface AccountBankAddView ()

/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
/** 持卡人红点 */
@property (strong, nonatomic) UIImageView *bankAddNameMarking;
/** 银行红点 */
@property (strong, nonatomic) UIImageView *bankNameMarking;
/** 卡号红点 */
@property (strong, nonatomic) UIImageView *bankCardMarking;
@end

@implementation AccountBankAddView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self postalActionLayoutView];
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
- (void)postalActionLayoutView{
    self.backgroundColor = CLEARCOLOR;
    /** 银行背景view */
    self.bankAddNoteView = [[UsedCellView alloc] init];
    self.bankAddNoteView.backgroundColor = VCBackground;
    self.bankAddNoteView.cellLabel.text = @"请添加您的储蓄卡，不支持信用卡";
    self.bankAddNoteView.cellLabel.textColor = HEXSTR_RGB(@"498dff");
    self.bankAddNoteView.isCellImage = YES;
    self.bankAddNoteView.isCellBtn = YES;
    self.bankAddNoteView.isArrow = YES;
    self.bankAddNoteView.isSplistLine = YES;
    self.bankAddNoteView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.bankAddNoteView];
    /** 持卡人view */
    self.bankAddNameView = [[UsedCellView alloc] init];
    [self.bankAddNameView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    [self.bankAddNameView.arrowImage addTarget:self action:@selector(alertNote) forControlEvents:UIControlEventTouchUpInside];
    self.bankAddNameView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.bankAddNameView.cellLabel.text = @"持卡人";
    self.bankAddNameView.cellLabel.textColor = Black;
    self.bankAddNameView.isCellImage = YES;
    self.bankAddNameView.isCellBtn = YES;
    self.bankAddNameView.viceTextFiled.placeholder = @"请输入持卡人姓名";
    self.bankAddNameView.viceTextFiled.textColor = Black;
    self.bankAddNameView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.bankAddNameView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.bankAddNameView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.bankAddNameView];
    /** 持卡人标记 */
    self.bankAddNameMarking = [[UIImageView alloc] init];
    self.bankAddNameMarking.image = [UIImage imageNamed:@"required_marking"];
    [self.bankAddNameView addSubview:self.bankAddNameMarking];
    /** 银行view */
    self.bankAddBankNameView = [[UsedCellView alloc] init];
    self.bankAddBankNameView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.bankAddBankNameView.cellLabel.text = @"银行";
    self.bankAddBankNameView.cellLabel.textColor = Black;
    self.bankAddBankNameView.viceTextFiled.textColor = Black;
    self.bankAddBankNameView.isCellImage = YES;
    self.bankAddBankNameView.isCellBtn = YES;
    self.bankAddBankNameView.isArrow = YES;
    self.bankAddBankNameView.viceTextFiled.placeholder = @"请输入银行名称";
    self.bankAddBankNameView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.bankAddBankNameView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.bankAddBankNameView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.bankAddBankNameView];
    /** 银行标记 */
    self.bankNameMarking = [[UIImageView alloc] init];
    self.bankNameMarking.image = [UIImage imageNamed:@"required_marking"];
    [self.bankAddBankNameView addSubview:self.bankNameMarking];
    /** 卡号view */
    self.bankAddCardView = [[UsedCellView alloc] init];
    self.bankAddCardView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.bankAddCardView.cellLabel.text = @"卡号";
    self.bankAddCardView.cellLabel.textColor = Black;
    self.bankAddCardView.viceTextFiled.textColor = Black;
    self.bankAddCardView.isCellImage = YES;
    self.bankAddCardView.isCellBtn = YES;
    self.bankAddCardView.isArrow = YES;
    self.bankAddCardView.viceTextFiled.placeholder = @"请输入银行卡卡号";
    self.bankAddCardView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.bankAddCardView.viceTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.bankAddCardView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.bankAddCardView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.bankAddCardView];
    /** 银行标记 */
    self.bankCardMarking = [[UIImageView alloc] init];
    self.bankCardMarking.image = [UIImage imageNamed:@"required_marking"];
    [self.bankAddCardView addSubview:self.bankCardMarking];
    /** 分行view */
    self.bankAddbranchView = [[UsedCellView alloc] init];
    self.bankAddbranchView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.bankAddbranchView.cellLabel.text = @"分行";
    self.bankAddbranchView.cellLabel.textColor = Black;
    self.bankAddbranchView.viceTextFiled.textColor = Black;
    self.bankAddbranchView.isCellImage = YES;
    self.bankAddbranchView.isCellBtn = YES;
    self.bankAddbranchView.isArrow = YES;
    self.bankAddbranchView.viceTextFiled.placeholder = @"请输入分行名称";
    self.bankAddbranchView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.bankAddbranchView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.bankAddbranchView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.bankAddbranchView];

}
- (void)alertNote{
    [AlertAction determineStay:[self viewController] title:@"提现金额说明" admitStr:@"知道了" message:@"为保证账户资金安全，请绑定认证用户本人的银行卡" determineBlock:^{
        
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 银行背景view */
    [self.bankAddNoteView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.mas_offset(32);
    }];
    /** 持卡人 */
    [self.bankAddNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.bankAddNoteView.mas_bottom);
        make.height.mas_equalTo(48);
    }];
    /** 持卡人标记 */
    [self.bankAddNameMarking mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.bankAddNameView.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.bankAddNameView.cellLabel.mas_centerY);
    }];
    /** 银行名字 */
    [self.bankAddBankNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.bankAddNameView.mas_bottom);
        make.height.mas_equalTo(48);
    }];
    /** 银行名字标记 */
    [self.bankNameMarking mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.bankAddBankNameView.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.bankAddBankNameView.cellLabel.mas_centerY);
    }];
    /** 银行卡号 */
    [self.bankAddCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.bankAddBankNameView.mas_bottom);
        make.height.mas_equalTo(48);
    }];
    /** 银行卡号标记 */
    [self.bankCardMarking mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.bankAddCardView.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.bankAddCardView.cellLabel.mas_centerY);
    }];
    /** 银行分行 */
    [self.bankAddbranchView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.bankAddCardView.mas_bottom);
        make.height.mas_equalTo(48);
    }];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
