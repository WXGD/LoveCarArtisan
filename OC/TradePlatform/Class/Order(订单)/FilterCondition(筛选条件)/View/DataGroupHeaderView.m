//
//  DataGroupHeaderView.m
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DataGroupHeaderView.h"

@interface DataGroupHeaderView ()

/** 订单日期 */
@property (strong, nonatomic) UILabel *orderDataLabel;
/** 尖头 */
@property (strong, nonatomic) UIImageView *arrowImage;

@end

@implementation DataGroupHeaderView




- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self dataGroupHeaderLayoutView];
    }
    return self;
}


#pragma mark - 按钮点击方法
/** 开始日期 */
- (void)startDataBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    if ([self.endDataBtn.titleLabel.text isEqualToString:@"选择结束时间"]) {
        datePicker.maximumDate = [NSDate date];
    }else {
        datePicker.maximumDate = [dateFormatter dateFromString:self.endDataBtn.titleLabel.text];
    }
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        [button setTitle:timestamp forState:UIControlStateNormal];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}
/** 结束日期 */
- (void)endDataBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    datePicker.minimumDate= [dateFormatter dateFromString:self.startDataBtn.titleLabel.text];
    datePicker.maximumDate = [NSDate date];
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSString *timestamp = [dateFormatter stringFromDate:datePicker.date];
        [button setTitle:timestamp forState:UIControlStateNormal];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}

#pragma mark - view布局
- (void)dataGroupHeaderLayoutView {
    /** 订单日期 */
    self.orderDataLabel = [[UILabel alloc] init];
    self.orderDataLabel.text = @"订单日期";
    self.orderDataLabel.textColor = GrayH2;
    self.orderDataLabel.font = TwelveTypeface;
    [self addSubview:self.orderDataLabel];
    /** 开始日期 */
    self.startDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startDataBtn.backgroundColor = WhiteColor;
    [self.startDataBtn setTitle:@"选择开始时间" forState:UIControlStateNormal];
    [self.startDataBtn setTitleColor:Black forState:UIControlStateNormal];
    self.startDataBtn.titleLabel.font = ThirteenTypeface;
    self.startDataBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.startDataBtn.layer.masksToBounds = YES;
    self.startDataBtn.layer.cornerRadius = 2;
    [self.startDataBtn addTarget:self action:@selector(startDataBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.startDataBtn];
    /** 尖头 */
    self.arrowImage = [[UIImageView alloc] init];
    self.arrowImage.image = [UIImage imageNamed:@"order_screen_data"];
    [self addSubview:self.arrowImage];
    /** 结束日期 */
    self.endDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endDataBtn.backgroundColor = WhiteColor;
    [self.endDataBtn setTitle:@"选择结束时间" forState:UIControlStateNormal];
    [self.endDataBtn setTitleColor:Black forState:UIControlStateNormal];
    self.endDataBtn.titleLabel.font = ThirteenTypeface;
    self.endDataBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.endDataBtn.layer.masksToBounds = YES;
    self.endDataBtn.layer.cornerRadius = 2;
    [self.endDataBtn addTarget:self action:@selector(endDataBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.endDataBtn];
    /** 支付方式 */
    self.payWayLabel = [[UILabel alloc] init];
    self.payWayLabel.textColor = GrayH2;
    self.payWayLabel.font = TwelveTypeface;
    [self addSubview:self.payWayLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 订单日期 */
    [self.orderDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(16);
        make.left.equalTo(self.mas_left);
    }];
    /** 开始日期 */
    [self.startDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderDataLabel.mas_bottom).offset(12);
        make.left.equalTo(self.orderDataLabel.mas_left);
        make.width.equalTo(self.startDataBtn.mas_width);
        make.height.mas_equalTo(@32);
    }];
    /** 尖头 */
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.startDataBtn.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** 结束日期 */
    [self.endDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.startDataBtn.mas_centerY);
        make.left.equalTo(self.startDataBtn.mas_right).offset(28);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.startDataBtn.mas_width);
        make.height.mas_equalTo(@32);
    }];
    /** 支付方式 */
    [self.payWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.endDataBtn.mas_bottom).offset(28);
        make.left.equalTo(self.mas_left);
    }];
}

@end
