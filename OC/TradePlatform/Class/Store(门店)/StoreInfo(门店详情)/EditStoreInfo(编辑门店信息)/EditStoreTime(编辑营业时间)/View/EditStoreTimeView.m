//
//  EditStoreTimeView.m
//  TradePlatform
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditStoreTimeView.h"

@interface EditStoreTimeView ()
/** 背景view */
@property (nonatomic,strong) UIView *bgView;
/** 中间图片 */
@property (nonatomic,strong) UIImageView *image;

@end

@implementation EditStoreTimeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self changeTimeLayoutView];
    }
    return self;
}

// 开始时间
- (void)startBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        [self.startBtn setTitle:timestamp forState:UIControlStateNormal];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}
// 结束时间
- (void)endBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        [self.endBtn setTitle:timestamp forState:UIControlStateNormal];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}

- (void)changeTimeLayoutView {
    /** 背景view */
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = WhiteColor;
    [self addSubview:self.bgView];
    /** 开始时间 */
    self.startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startBtn.backgroundColor = HEXSTR_RGB(@"f5f5f5");
    self.startBtn.layer.cornerRadius = 2;
    self.startBtn.clipsToBounds = YES;
    self.startBtn.titleLabel.font = FourteenTypeface;
    [self.startBtn setTitleColor:Black forState:UIControlStateNormal];
    [self.startBtn addTarget:self action:@selector(startBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.startBtn];
    /** 结束时间输入框 */
    self.endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endBtn.backgroundColor = HEXSTR_RGB(@"f5f5f5");
    self.endBtn.layer.cornerRadius = 2;
    self.endBtn.clipsToBounds = YES;
    self.endBtn.titleLabel.font = FourteenTypeface;
    [self.endBtn setTitleColor:Black forState:UIControlStateNormal];
    [self.endBtn addTarget:self action:@selector(endBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.endBtn];
    /** 中间图片 */
    self.image = [[UIImageView alloc] init];
    self.image.image = [UIImage imageNamed:@"exchangeTime"];
    [self addSubview:self.image];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 开始时间 */
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.mas_top).offset(24);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo((ScreenW-80)*1.0/2);
    }];
    /** 结束时间 */
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-16);
        make.top.equalTo(self.mas_top).offset(24);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo((ScreenW-80)*1.0/2);
    }];
    /** 中间图片 */
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.startBtn.mas_centerY);
    }];
}



@end
