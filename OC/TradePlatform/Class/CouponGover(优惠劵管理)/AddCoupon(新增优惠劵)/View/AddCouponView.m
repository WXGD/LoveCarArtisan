//
//  AddCouponView.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCouponView.h"
#import "ZYKeyboardUtil.h"

static CGFloat descHeight = 30;

@interface AddCouponView ()<GJTextViewDelegate>

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *addCouponScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *addCouponView;
/** 优惠卷描述 */
@property (strong, nonatomic) UIView *coupondescView;
/** 优惠卷描述标题 */
@property (strong, nonatomic) UILabel *descTitleLabel;
/** 优惠卷是否只能领一张 */
@property (strong, nonatomic) CustomCell *isOnlyView;
/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation AddCouponView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addCouponLayoutView];
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
/** 优惠卷开放时间 */
- (void)couponOpenTimeBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置时间范围
    datePicker.minimumDate= [NSDate date];//今天
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        self.couponOpenTimeView.rightViceLabel.text = timestamp;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}
/** 优惠卷结束时间 */
- (void)couponEndTimeBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置时间范围
    datePicker.minimumDate = [NSDate date];//今天
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        self.couponEndTimeView.rightViceLabel.text = timestamp;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}


#pragma mark - view布局
- (void)addCouponLayoutView {
    /** 背景scrollview */
    self.addCouponScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.addCouponScrollView];
    UITapGestureRecognizer *addCouponTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCouponTapAction)];
    [self.addCouponScrollView addGestureRecognizer:addCouponTap];
    /** 填充scrollview的view */
    self.addCouponView = [[UIView alloc] init];
    [self.addCouponScrollView addSubview:self.addCouponView];
    /** 优惠卷名称 */
    self.couponNameView = [[CustomCell alloc] init];
    self.couponNameView.lineStyle = FullScreenLayout;
    self.couponNameView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.couponNameView.mainLabel.text = @"名称:";
    self.couponNameView.mainLabel.textColor = Black;
    self.couponNameView.mainLabel.font = FifteenTypeface;
    self.couponNameView.viceTF.placeholder = @"请输入名称";
    self.couponNameView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.couponNameView.viceTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.couponNameView.viceTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.couponNameView.viceTF.font = FourteenTypeface;
    self.couponNameView.viceTF.textColor = GrayH1;
    [self.addCouponView addSubview:self.couponNameView];
    self.couponNameView.vTFLeftBorder = 115;
    [self.couponNameView.mainBtn setHidden:YES];
    /** 优惠卷面值 */
    self.couponPoundView = [[CustomCell alloc] init];
    self.couponPoundView.lineStyle = FullScreenLayout;
    self.couponPoundView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.couponPoundView.mainLabel.text = @"面值:";
    self.couponPoundView.mainLabel.textColor = Black;
    self.couponPoundView.mainLabel.font = FifteenTypeface;
    self.couponPoundView.viceTF.placeholder = @"请输入面值";
    self.couponPoundView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.couponPoundView.viceTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.couponPoundView.viceTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.couponPoundView.viceTF.font = FourteenTypeface;
    self.couponPoundView.viceTF.textColor = GrayH1;
    self.couponPoundView.viceTF.keyboardType = UIKeyboardTypeDecimalPad;
    self.couponPoundView.rightViceLabel.text = @"元";
    self.couponPoundView.rightViceLabel.textColor = GrayH1;
    self.couponPoundView.rightViceLabel.font = FourteenTypeface;
    [self.addCouponView addSubview:self.couponPoundView];
    self.couponPoundView.vTFLeftBorder = 115;
    [self.couponPoundView.mainBtn setHidden:YES];
    /** 优惠卷使用条件 */
    self.couponUseCondView = [[CustomCell alloc] init];
    self.couponUseCondView.lineStyle = NotLine;
    self.couponUseCondView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.couponUseCondView.mainLabel.text = @"满多少可用:";
    self.couponUseCondView.mainLabel.textColor = Black;
    self.couponUseCondView.mainLabel.font = FifteenTypeface;
    self.couponUseCondView.viceTF.placeholder = @"请输入满多少可用金额";
    self.couponUseCondView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.couponUseCondView.viceTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.couponUseCondView.viceTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.couponUseCondView.viceTF.font = FourteenTypeface;
    self.couponUseCondView.viceTF.textColor = GrayH1;
    self.couponUseCondView.viceTF.keyboardType = UIKeyboardTypeDecimalPad;
    self.couponUseCondView.rightViceLabel.text = @"元";
    self.couponUseCondView.rightViceLabel.textColor = GrayH1;
    self.couponUseCondView.rightViceLabel.font = FourteenTypeface;
    [self.addCouponView addSubview:self.couponUseCondView];
    self.couponUseCondView.vTFLeftBorder = 115;
    [self.couponUseCondView.mainBtn setHidden:YES];
    /** 优惠卷是否只能领一张 */
    self.isOnlyView = [[CustomCell alloc] init];
    self.isOnlyView.lineStyle = NotLine;
    self.isOnlyView.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.isOnlyView.mainLabel.text = @"每人限领一张";
    self.isOnlyView.mainLabel.textColor = Black;
    self.isOnlyView.mainLabel.font = FifteenTypeface;
    [self.addCouponView addSubview:self.isOnlyView];
    [self.isOnlyView.mainBtn setHidden:YES];
    /** 优惠卷是否只能领一张开关 */
    self.isOnlySwitch = [[UISwitch alloc] init];
    [self.isOnlyView addSubview:self.isOnlySwitch];
    /** 优惠卷开放时间 */
    self.couponOpenTimeView = [[CustomCell alloc] init];
    self.couponOpenTimeView.lineStyle = FullScreenLayout;
    self.couponOpenTimeView.cellStyle = HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.couponOpenTimeView.mainLabel.text = @"开始发放时间";
    self.couponOpenTimeView.mainLabel.textColor = Black;
    self.couponOpenTimeView.mainLabel.font = FifteenTypeface;
    self.couponOpenTimeView.rightViceLabel.text = @"请选择时间";
    self.couponOpenTimeView.rightViceLabel.textColor = GrayH1;
    self.couponOpenTimeView.rightViceLabel.font = FourteenTypeface;
    [self.couponOpenTimeView.mainBtn addTarget:self action:@selector(couponOpenTimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.addCouponView addSubview:self.couponOpenTimeView];
    /** 优惠卷结束时间 */
    self.couponEndTimeView = [[CustomCell alloc] init];
    self.couponEndTimeView.lineStyle = FullScreenLayout;
    self.couponEndTimeView.cellStyle = HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.couponEndTimeView.mainLabel.text = @"结束发放时间";
    self.couponEndTimeView.mainLabel.textColor = Black;
    self.couponEndTimeView.mainLabel.font = FifteenTypeface;
    self.couponEndTimeView.rightViceLabel.text = @"请选择时间";
    self.couponEndTimeView.rightViceLabel.textColor = GrayH1;
    self.couponEndTimeView.rightViceLabel.font = FourteenTypeface;
    [self.couponEndTimeView.mainBtn addTarget:self action:@selector(couponEndTimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.addCouponView addSubview:self.couponEndTimeView];
    /** 优惠卷发放数量 */
    self.couponTotalView = [[CustomCell alloc] init];
    self.couponTotalView.lineStyle = FullScreenLayout;
    self.couponTotalView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.couponTotalView.mainLabel.text = @"发放总数量:";
    self.couponTotalView.mainLabel.textColor = Black;
    self.couponTotalView.mainLabel.font = FifteenTypeface;
    self.couponTotalView.viceTF.placeholder = @"请输入数量";
    self.couponTotalView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.couponTotalView.viceTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.couponTotalView.viceTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.couponTotalView.viceTF.font = FourteenTypeface;
    self.couponTotalView.viceTF.textColor = GrayH1;
    self.couponTotalView.viceTF.keyboardType = UIKeyboardTypeNumberPad;
    self.couponTotalView.rightViceLabel.text = @"张";
    self.couponTotalView.rightViceLabel.textColor = GrayH1;
    self.couponTotalView.rightViceLabel.font = FourteenTypeface;
    [self.addCouponView addSubview:self.couponTotalView];
    self.couponTotalView.vTFLeftBorder = 115;
    [self.couponTotalView.mainBtn setHidden:YES];
    /** 优惠卷有效天数 */
    self.couponExpiryDateView = [[CustomCell alloc] init];
    self.couponExpiryDateView.lineStyle = NotLine;
    self.couponExpiryDateView.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.couponExpiryDateView.mainLabel.text = @"有效天数:";
    self.couponExpiryDateView.mainLabel.textColor = Black;
    self.couponExpiryDateView.mainLabel.font = FifteenTypeface;
    self.couponExpiryDateView.viceTF.placeholder = @"请输入天数";
    self.couponExpiryDateView.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.couponExpiryDateView.viceTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.couponExpiryDateView.viceTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.couponExpiryDateView.viceTF.font = FourteenTypeface;
    self.couponExpiryDateView.viceTF.textColor = GrayH1;
    self.couponExpiryDateView.viceTF.keyboardType = UIKeyboardTypeNumberPad;
    self.couponExpiryDateView.rightViceLabel.text = @"天";
    self.couponExpiryDateView.rightViceLabel.textColor = GrayH1;
    self.couponExpiryDateView.rightViceLabel.font = FourteenTypeface;
    [self.addCouponView addSubview:self.couponExpiryDateView];
    self.couponExpiryDateView.vTFLeftBorder = 115;
    [self.couponExpiryDateView.mainBtn setHidden:YES];
    /** 优惠卷适用服务 */
    self.couponApplyView = [[CustomCell alloc] init];
    self.couponApplyView.lineStyle = FullScreenLayout;
    self.couponApplyView.cellStyle = HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.couponApplyView.mainLabel.text = @"可用服务";
    self.couponApplyView.mainLabel.textColor = Black;
    self.couponApplyView.mainLabel.font = FifteenTypeface;
    [self.addCouponView addSubview:self.couponApplyView];
    /** 优惠卷适用服务Label */
    self.couponApplyLabel = [[UILabel alloc] init];
    self.couponApplyLabel.text = @"全部服务";
    self.couponApplyLabel.textColor = GrayH1;
    self.couponApplyLabel.font = FourteenTypeface;
    self.couponApplyLabel.textAlignment = NSTextAlignmentRight;
    self.couponApplyLabel.numberOfLines = 0;
    [self.couponApplyView addSubview:self.couponApplyLabel];
    /** 优惠卷描述 */
    self.coupondescView = [[UIView alloc] init];
    self.coupondescView.backgroundColor = WhiteColor;
    [self.addCouponView addSubview:self.coupondescView];
    /** 优惠卷描述标题 */
    self.descTitleLabel = [[UILabel alloc] init];
    self.descTitleLabel.text = @"描述:";
    self.descTitleLabel.textColor = Black;
    self.descTitleLabel.font = FifteenTypeface;
    [self.coupondescView addSubview:self.descTitleLabel];
    /** 优惠卷描述内容 */
    self.descContentTV = [[GJTextView alloc] init];
    self.descContentTV.GJDelegate = self;
    self.descContentTV.tvColor = GrayH1;
    self.descContentTV.placeholderColor = GrayH4;
    self.descContentTV.placeholder = @"请输入描述";
    self.descContentTV.font = FourteenTypeface;
    [self.coupondescView addSubview:self.descContentTV];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.addCouponScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.addCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addCouponScrollView.mas_top);
        make.left.equalTo(self.addCouponScrollView.mas_left);
        make.bottom.equalTo(self.addCouponScrollView.mas_bottom);
        make.right.equalTo(self.addCouponScrollView.mas_right);
        make.width.equalTo(self.addCouponScrollView.mas_width);
        make.bottom.equalTo(self.coupondescView.mas_bottom);
    }];
    /** 优惠卷名称 */
    [self.couponNameView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addCouponView.mas_top);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠卷面值 */
    [self.couponPoundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponNameView.mas_bottom);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠卷使用条件 */
    [self.couponUseCondView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponPoundView.mas_bottom);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠卷是否只能领一张 */
    [self.isOnlyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponUseCondView.mas_bottom).offset(10);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠卷是否只能领一张开关 */
    [self.isOnlySwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.isOnlyView.mas_centerY);
        make.right.equalTo(self.isOnlyView.mas_right).offset(-16);
    }];
    /** 优惠卷开放时间 */
    [self.couponOpenTimeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.isOnlyView.mas_bottom).offset(10);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠卷结束时间 */
    [self.couponEndTimeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponOpenTimeView.mas_bottom);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠卷发放数量 */
    [self.couponTotalView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponEndTimeView.mas_bottom);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠卷有效天数 */
    [self.couponExpiryDateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponTotalView.mas_bottom);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 优惠卷适用服务 */
    [self.couponApplyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponExpiryDateView.mas_bottom).offset(10);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.bottom.equalTo(self.couponApplyLabel.mas_bottom).offset(16.4);
    }];
    /** 优惠卷适用服务Label */
    [self.couponApplyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponApplyView.mas_top).offset(16.6);
        make.left.equalTo(self.couponApplyView.mainLabel.mas_right).offset(16);
        make.right.equalTo(self.couponApplyView.arrowImg.mas_left).offset(-16);
    }];
    /** 优惠卷描述 */
    [self.coupondescView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponApplyView.mas_bottom).offset(10);
        make.left.equalTo(self.addCouponView.mas_left);
        make.right.equalTo(self.addCouponView.mas_right);
        make.bottom.equalTo(self.descContentTV.mas_bottom).offset(16);
    }];
    /** 优惠卷描述标题 */
    [self.descTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.coupondescView.mas_top).offset(16);
        make.left.equalTo(self.coupondescView.mas_left).offset(16);
    }];
    /** 优惠卷描述内容 */
    [self.descContentTV mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.coupondescView.mas_top).offset(10);
        make.left.equalTo(self.coupondescView.mas_left).offset(115);
        make.right.equalTo(self.coupondescView.mas_right).offset(-10);
        make.height.mas_equalTo(descHeight);
    }];
}


#pragma mark - textView代理方法
// 当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {
    descHeight = [CustomString heightForString:textView.text textFont:FourteenTypeface textWidth:ScreenW - 131] + 5;
    if (descHeight > 30) {
        [self layoutSubviews];
    }
}

#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
- (void)addCouponTapAction {
    [self endEditing:YES];
}


@end
