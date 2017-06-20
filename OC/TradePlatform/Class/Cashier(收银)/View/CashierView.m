//
//  CashierView.m
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierView.h"
#import "ZYKeyboardUtil.h"
#import "UUInputAccessoryView.h"

@interface CashierView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *cashierScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *cashierView;
/** 添加用户标题 */
@property (strong, nonatomic) CustomCell *addUserTitleView;
/** 添加服务标题 */
@property (strong, nonatomic) CustomCell *addServiceTitleView;
/** 数量view */
@property (strong, nonatomic) UIView *numberView;
@property (strong, nonatomic) UILabel *numberTitleLabel;
@property (strong, nonatomic) UIView *numberLineView;
/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
/** 其他信息标题 */
@property (strong, nonatomic) CustomCell *otherTitleView;

@end

@implementation CashierView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cashierLayoutView];
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

#pragma mark - 优惠券选择前
/** 优惠券选择前 */
- (void)setCouponChoiceBefore:(NSInteger)couponChoiceBefore {
    _couponChoiceBefore = couponChoiceBefore;
    if (couponChoiceBefore > 0) {
        self.couponView.viceTF.text = [NSString stringWithFormat:@"有%ld张优惠券", (long)couponChoiceBefore];
        self.couponView.viceTF.textColor = RedColor;
    }else {
        self.couponView.viceTF.text = @"无优惠券";
        self.couponView.viceTF.textColor = GrayH1;
    }
}
/** 优惠券选择后 */
- (void)setCouponChoiceAfter:(double)couponChoiceAfter {
    _couponChoiceAfter = couponChoiceAfter;
    self.couponView.viceTF.text = [NSString stringWithFormat:@"-¥%.2f", couponChoiceAfter];
    self.couponView.viceTF.textColor = RedColor;
}


#pragma mark - 按钮点击方法
// 销售价按钮点击
- (void)pretiumBtnAction:(UIButton *)button {
    [UUInputAccessoryView showKeyboardType:UIKeyboardTypeNumbersAndPunctuation content:self.pretiumView.viceTF.text Block:^(NSString *contentStr) {
        if (contentStr.length == 0) return ;
        double pretium = [contentStr doubleValue];
        // 判断销售价是否小于0
        if (pretium <= 0) {
            [MBProgressHUD showError:@"销售价不能小于0"];
            return;
        }
        self.pretiumView.viceTF.text = [NSString stringWithFormat:@"%.2f", pretium];
        if (_delegate && [_delegate respondsToSelector:@selector(editPretiumDelegate)]) {
            [_delegate editPretiumDelegate];
        }
    }];
}
// 下次保养时间点击
- (void)nextTimeBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate= [NSDate date];
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        self.nextTimeView.viceTF.text = timestamp;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}
// 回收键盘
- (void)cashierTapAction {
    [self endEditing:YES];
}
#pragma mark - view布局
- (void)cashierLayoutView {
    /** 底部view */
    self.cashierBomView = [[CashierBomView alloc] init];
    /** 确认收款 */
    self.cashierBomView.confirCashierBtn.tag = ConfirCashierBtnAction;
    /** 提交订单 */
    self.cashierBomView.temporCashierBtn.tag = TemporCashierBtnAction;
    [self addSubview:self.cashierBomView];
    /** 背景scrollview */
    self.cashierScrollView = [[UIScrollView alloc] init];
    self.cashierScrollView.backgroundColor = VCBackground;
    [self addSubview:self.cashierScrollView];
    /** 填充scrollview的view */
    self.cashierView = [[UIView alloc] init];
    self.cashierView.backgroundColor = VCBackground;
    [self.cashierScrollView addSubview:self.cashierView];
    UITapGestureRecognizer *cashierTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cashierTapAction)];
    [self.cashierView addGestureRecognizer:cashierTap];
    /** 添加用户标题 */
    self.addUserTitleView = [[CustomCell alloc] init];
    self.addUserTitleView.lineStyle = FullScreenLayout;
    self.addUserTitleView.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.addUserTitleView.mainLabel.text = @"选择用户";
    self.addUserTitleView.mainLabel.textColor = ThemeColor;
    self.addUserTitleView.mainLabel.font = FifteenTypeface;
    [self.cashierView addSubview:self.addUserTitleView];
    /** 手机号view */
    self.phoneView = [[CustomCell alloc] init];
    self.phoneView.lineStyle = FullScreenLayout;
    self.phoneView.cellStyle = ViceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn;
    self.phoneView.mainLabel.text = @"手机号";
    self.phoneView.mainLabel.textColor = GrayH1;
    self.phoneView.mainLabel.font = FourteenTypeface;
    self.phoneView.viceTF.placeholder = @"请输入手机号";
    self.phoneView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneView.viceTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneView.viceTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.phoneView.viceTF.font = FourteenTypeface;
    self.phoneView.viceTF.textColor = Black;
    [self.phoneView.arrowImg setImage:[UIImage imageNamed:@"cashier_user"] forState:UIControlStateNormal];
    self.phoneView.viceBtn.tag = PhoneBtnAction;
    [self.cashierView addSubview:self.phoneView];
    self.phoneView.vTFLeftBorder = 115;
    [self.phoneView.mainBtn setHidden:YES];
    /** 车牌号view */
    self.plnCellView = [[PlnCellView alloc] init];
    self.plnCellView.choiceCarBtn.tag = PlnBtnAction;
    self.plnCellView.caftaBtn.tag = CaftaBtnAction;
    [self.cashierView addSubview:self.plnCellView];
    /** 用户名 */
    self.userNameView = [[CustomCell alloc] init];
    self.userNameView.lineStyle = NotLine;
    self.userNameView.cellStyle = ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.userNameView.mainLabel.text = @"用户名";
    self.userNameView.mainLabel.textColor = GrayH1;
    self.userNameView.mainLabel.font = FourteenTypeface;
    self.userNameView.viceTF.borderStyle = UITextBorderStyleNone;
    self.userNameView.viceTF.textAlignment = NSTextAlignmentLeft;
    self.userNameView.viceTF.font = FourteenTypeface;
    self.userNameView.viceTF.textColor = Black;
    self.userNameView.mainBtn.tag = UserNameBtnAction;
    [self.cashierView addSubview:self.userNameView];
    self.userNameView.vTFLeftBorder = 115;
    /** 添加服务标题 */
    self.addServiceTitleView = [[CustomCell alloc] init];
    self.addServiceTitleView.lineStyle = FullScreenLayout;
    self.addServiceTitleView.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.addServiceTitleView.mainLabel.text = @"选择服务";
    self.addServiceTitleView.mainLabel.font = FifteenTypeface;
    self.addServiceTitleView.mainLabel.textColor = ThemeColor;
    [self.cashierView addSubview:self.addServiceTitleView];
    /** 类别view */
    self.classView = [[CustomCell alloc] init];
    self.classView.lineStyle = FullScreenLayout;
    self.classView.cellStyle = ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.classView.mainLabel.text = @"类别";
    self.classView.mainLabel.textColor = GrayH1;
    self.classView.mainLabel.font = FourteenTypeface;
    self.classView.viceTF.borderStyle = UITextBorderStyleNone;
    self.classView.viceTF.textAlignment = NSTextAlignmentLeft;
    self.classView.viceTF.font = FourteenTypeface;
    self.classView.viceTF.textColor = Black;
    self.classView.mainBtn.tag = ClassBtnAction;
    [self.cashierView addSubview:self.classView];
    self.classView.vTFLeftBorder = 115;
    /** 服务view */
    self.serviceView = [[CustomCell alloc] init];
    self.serviceView.lineStyle = FullScreenLayout;
    self.serviceView.cellStyle = ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.serviceView.mainLabel.text = @"服务";
    self.serviceView.mainLabel.textColor = GrayH1;
    self.serviceView.mainLabel.font = FourteenTypeface;
    self.serviceView.viceTF.borderStyle = UITextBorderStyleNone;
    self.serviceView.viceTF.textAlignment = NSTextAlignmentLeft;
    self.serviceView.viceTF.font = FourteenTypeface;
    self.serviceView.viceTF.textColor = Black;
    self.serviceView.mainBtn.tag = ServiceBtnAction;
    [self.cashierView addSubview:self.serviceView];
    self.serviceView.vTFLeftBorder = 115;
    /** 数量view */
    self.numberView = [[UIView alloc] init];
    self.numberView.backgroundColor = WhiteColor;
    [self.cashierView addSubview:self.numberView];
    self.numberTitleLabel = [[UILabel alloc] init];
    self.numberTitleLabel.text = @"数量";
    self.numberTitleLabel.textColor = GrayH1;
    self.numberTitleLabel.font = FourteenTypeface;
    [self.numberView addSubview:self.numberTitleLabel];
    self.numberLineView = [[UIView alloc] init];
    self.numberLineView.backgroundColor = DividingLine;
    [self.numberView addSubview:self.numberLineView];
    /** 数量操作 */
    self.numberOperationBtn = [[AddSubNumView alloc] init];
    [self.numberView addSubview:self.numberOperationBtn];
    /** 销售价view */
    self.pretiumView = [[CustomCell alloc] init];
    self.pretiumView.lineStyle = FullScreenLayout;
    self.pretiumView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.pretiumView.mainLabel.text = @"售价";
    self.pretiumView.mainLabel.textColor = GrayH1;
    self.pretiumView.mainLabel.font = FourteenTypeface;
    self.pretiumView.viceTF.borderStyle = UITextBorderStyleNone;
    self.pretiumView.viceTF.textAlignment = NSTextAlignmentLeft;
    self.pretiumView.viceTF.font = FourteenTypeface;
    self.pretiumView.viceTF.textColor = RedColor;
    self.pretiumView.rightViceLabel.text = @"元";
    self.pretiumView.rightViceLabel.font = FourteenTypeface;
    self.pretiumView.rightViceLabel.textColor = Black;
    [self.pretiumView.mainBtn addTarget:self action:@selector(pretiumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cashierView addSubview:self.pretiumView];
    self.pretiumView.vTFLeftBorder = 115;
    /** 其他信息标题 */
    self.otherTitleView = [[CustomCell alloc] init];
    self.otherTitleView.lineStyle = FullScreenLayout;
    self.otherTitleView.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.otherTitleView.mainLabel.text = @"其他信息";
    self.otherTitleView.mainLabel.font = FifteenTypeface;
    self.otherTitleView.mainLabel.textColor = ThemeColor;
    [self.cashierView addSubview:self.otherTitleView];
    /** 服务师傅view */
    self.serviceMasterView = [[CustomCell alloc] init];
    self.serviceMasterView.lineStyle = FullScreenLayout;
    self.serviceMasterView.cellStyle = ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.serviceMasterView.mainLabel.text = @"服务师傅";
    self.serviceMasterView.mainLabel.textColor = GrayH1;
    self.serviceMasterView.mainLabel.font = FourteenTypeface;
    self.serviceMasterView.viceTF.borderStyle = UITextBorderStyleNone;
    self.serviceMasterView.viceTF.textAlignment = NSTextAlignmentLeft;
    self.serviceMasterView.viceTF.font = FourteenTypeface;
    self.serviceMasterView.viceTF.textColor = Black;
    self.serviceMasterView.mainBtn.tag = ServiceMasterBtnAction;
    [self.cashierView addSubview:self.serviceMasterView];
    self.serviceMasterView.vTFLeftBorder = 115;
    /** 优惠券 */
    self.couponView = [[CustomCell alloc] init];
    self.couponView.lineStyle = FullScreenLayout;
    self.couponView.cellStyle = ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.couponView.mainLabel.text = @"优惠券";
    self.couponView.mainLabel.textColor = GrayH1;
    self.couponView.mainLabel.font = FourteenTypeface;
    self.couponView.viceTF.borderStyle = UITextBorderStyleNone;
    self.couponView.viceTF.textAlignment = NSTextAlignmentLeft;
    self.couponView.viceTF.font = FourteenTypeface;
    self.couponView.viceTF.text = @"无优惠券可用";
    self.couponView.viceTF.textColor = GrayH1;
    self.couponView.mainBtn.tag = CouponBtnAction;
    [self.cashierView addSubview:self.couponView];
    self.couponView.vTFLeftBorder = 115;
    /** 行驶里程 */
    self.mileageView = [[CustomCell alloc] init];
    self.mileageView.lineStyle = FullScreenLayout;
    self.mileageView.cellStyle = ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.mileageView.mainLabel.text = @"行驶里程";
    self.mileageView.mainLabel.font = FourteenTypeface;
    self.mileageView.mainLabel.textColor = GrayH1;
    [self.mileageView.viceTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.mileageView.viceTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.mileageView.viceTF.placeholder = @"请输入行驶里程";
    self.mileageView.viceTF.borderStyle = UITextBorderStyleNone;
    self.mileageView.viceTF.textAlignment = NSTextAlignmentLeft;
    self.mileageView.viceTF.keyboardType = UIKeyboardTypeNumberPad;
    self.mileageView.viceTF.textColor = Black;
    self.mileageView.viceTF.font = FourteenTypeface;
    [self.cashierView addSubview:self.mileageView];
    [self.mileageView setHidden:YES];
    self.mileageView.vTFLeftBorder = 115;
    [self.mileageView.mainBtn setHidden:YES];
    /** 下次保养时间 */
    self.nextTimeView = [[CustomCell alloc] init];
    self.nextTimeView.lineStyle = FullScreenLayout;
    self.nextTimeView.cellStyle = ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.nextTimeView.mainLabel.text = @"下次保养时间";
    self.nextTimeView.mainLabel.font = FourteenTypeface;
    self.nextTimeView.mainLabel.textColor = GrayH1;
    [self.nextTimeView.viceTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.nextTimeView.viceTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.nextTimeView.viceTF.placeholder = @"请选择下次保养时间";
    self.nextTimeView.viceTF.borderStyle = UITextBorderStyleNone;
    self.nextTimeView.viceTF.textAlignment = NSTextAlignmentLeft;
    self.nextTimeView.viceTF.font = FourteenTypeface;
    self.nextTimeView.viceTF.textColor = Black;
    [self.nextTimeView.mainBtn addTarget:self action:@selector(nextTimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cashierView addSubview:self.nextTimeView];
    [self.nextTimeView setHidden:YES];
    self.nextTimeView.vTFLeftBorder = 115;
    // 获取当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    self.nextTimeView.viceTF.text = dateTime;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 底部view */
    [self.cashierBomView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 背景scrollview */
    [self.cashierScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.cashierBomView.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.cashierView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cashierScrollView.mas_top);
        make.left.equalTo(self.cashierScrollView.mas_left);
        make.bottom.equalTo(self.cashierScrollView.mas_bottom);
        make.right.equalTo(self.cashierScrollView.mas_right);
        make.width.equalTo(self.cashierScrollView.mas_width);
        make.bottom.equalTo(self.nextTimeView.mas_bottom);
    }];
    /** 添加用户标题 */
    [self.addUserTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cashierView.mas_top);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 手机号view */
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addUserTitleView.mas_bottom);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 车牌号view */
    [self.plnCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.phoneView.mas_bottom);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 用户名 */
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnCellView.mas_bottom);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 添加服务标题 */
    [self.addServiceTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userNameView.mas_bottom).offset(10);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 类别view */
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.addServiceTitleView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 服务view */
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.classView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 数量view */
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.serviceView.mas_bottom).offset(0.5);
        make.height.mas_equalTo(@50);
    }];
    [self.numberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.numberView.mas_left).offset(16);
        make.centerY.equalTo(self.numberView.mas_centerY);
    }];
    [self.numberLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.numberView.mas_left);
        make.right.equalTo(self.numberView.mas_right);
        make.bottom.equalTo(self.numberView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
    /** 数量操作 */
    [self.numberOperationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.numberView.mas_left).offset(106);
        make.centerY.equalTo(self.numberView.mas_centerY);
    }];
    /** 销售价view */
    [self.pretiumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.numberOperationBtn.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 其他信息标题 */
    [self.otherTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.pretiumView.mas_bottom).offset(10);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 服务师傅view */
    [self.serviceMasterView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.otherTitleView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠券 */
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.serviceMasterView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 行驶里程 */
    [self.mileageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.couponView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 下次保养时间 */
    [self.nextTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.mileageView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
}



@end
