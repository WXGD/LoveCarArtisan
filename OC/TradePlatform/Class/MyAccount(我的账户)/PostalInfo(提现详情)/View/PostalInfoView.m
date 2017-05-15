//
//  PostalInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PostalInfoView.h"

@interface PostalInfoView ()

/** 分割线1 */
@property (strong, nonatomic) UIView *oneLineView;
/** 分割线2 */
@property (strong, nonatomic) UIView *twoLineView;
/** 提现时间段标题 */
@property (strong, nonatomic) UsedCellView *applyTimeRangeTitelView;
/** 提现时间段 */
@property (strong, nonatomic) UIView *applyTimeRangeView;
/** 分割线3 */
@property (strong, nonatomic) UIView *threeLineView;
/** 回执单标题 */
@property (strong, nonatomic) UsedCellView *receiptTitelView;
/** 回执单 */
@property (strong, nonatomic) UIView *receiptView;

@end

@implementation PostalInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self postalInfoLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)postalInfoLayoutView {
    /** 背景scrollview */
    self.postalInfoScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.postalInfoScrollView];
    /** 填充scrollview的view */
    self.postalInfoBackView = [[UIStackView alloc] init];
    self.postalInfoBackView.axis = UILayoutConstraintAxisVertical;
    [self.postalInfoScrollView addSubview:self.postalInfoBackView];
    /** 分割线1 */
    self.oneLineView = [[UIView alloc] init];
    [self.postalInfoBackView addArrangedSubview:self.oneLineView];
    /** 申请时间 */
    self.applyTimeView = [[UsedCellView alloc] init];
    self.applyTimeView.cellLabel.text = @"申请时间";
    self.applyTimeView.cellLabel.font = FourteenTypeface;
    self.applyTimeView.cellLabel.textColor = GrayH1;
    self.applyTimeView.describeLabel.font = FourteenTypeface;
    self.applyTimeView.describeLabel.textColor = Black;
    self.applyTimeView.describeLabel.text = @"申请时间";
    self.applyTimeView.dividingLineChoice = DividingLineFullScreenLayout;
    self.applyTimeView.isArrow = YES;
    self.applyTimeView.isCellImage = YES;
    [self.postalInfoBackView addArrangedSubview:self.applyTimeView];
    /** 提现金额 */
    self.postalMoneyView = [[UsedCellView alloc] init];
    self.postalMoneyView.cellLabel.text = @"提现金额";
    self.postalMoneyView.cellLabel.font = FourteenTypeface;
    self.postalMoneyView.cellLabel.textColor = GrayH1;
    self.postalMoneyView.describeLabel.font = FourteenTypeface;
    self.postalMoneyView.describeLabel.textColor = Black;
    self.postalMoneyView.describeLabel.text = @"提现金额";
    self.postalMoneyView.dividingLineChoice = DividingLineFullScreenLayout;
    self.postalMoneyView.isArrow = YES;
    self.postalMoneyView.isCellImage = YES;
    [self.postalInfoBackView addArrangedSubview:self.postalMoneyView];
    /** 提现状态 */
    self.postalStateView = [[UsedCellView alloc] init];
    self.postalStateView.cellLabel.text = @"提现状态";
    self.postalStateView.cellLabel.font = FourteenTypeface;
    self.postalStateView.cellLabel.textColor = GrayH1;
    self.postalStateView.describeLabel.font = FourteenTypeface;
    self.postalStateView.describeLabel.textColor = Black;
    self.postalStateView.describeLabel.text = @"提现状态";
    self.postalStateView.dividingLineChoice = DividingLineFullScreenLayout;
    self.postalStateView.isArrow = YES;
    self.postalStateView.isCellImage = YES;
    [self.postalInfoBackView addArrangedSubview:self.postalStateView];
    /** 处理时间 */
    self.handleTimeView = [[UsedCellView alloc] init];
    self.handleTimeView.cellLabel.text = @"处理时间";
    self.handleTimeView.cellLabel.font = FourteenTypeface;
    self.handleTimeView.cellLabel.textColor = GrayH1;
    self.handleTimeView.describeLabel.font = FourteenTypeface;
    self.handleTimeView.describeLabel.textColor = Black;
    self.handleTimeView.describeLabel.text = @"处理时间";
    self.handleTimeView.dividingLineChoice = DividingLineFullScreenLayout;
    self.handleTimeView.isArrow = YES;
    self.handleTimeView.isCellImage = YES;
    [self.postalInfoBackView addArrangedSubview:self.handleTimeView];
    /** 处理人 */
    self.handleManView = [[UsedCellView alloc] init];
    self.handleManView.cellLabel.text = @"处理人";
    self.handleManView.cellLabel.font = FourteenTypeface;
    self.handleManView.cellLabel.textColor = GrayH1;
    self.handleManView.describeLabel.font = FourteenTypeface;
    self.handleManView.describeLabel.textColor = Black;
    self.handleManView.describeLabel.text = @"处理人";
    self.handleManView.dividingLineChoice = DividingLineFullScreenLayout;
    self.handleManView.isArrow = YES;
    self.handleManView.isCellImage = YES;
    [self.postalInfoBackView addArrangedSubview:self.handleManView];
    /** 分割线2 */
    self.twoLineView = [[UIView alloc] init];
    [self.postalInfoBackView addArrangedSubview:self.twoLineView];
    /** 提现时间段标题 */
    self.applyTimeRangeTitelView = [[UsedCellView alloc] init];
    self.applyTimeRangeTitelView.cellLabel.text = @"提现时间段";
    self.applyTimeRangeTitelView.cellLabel.font = FifteenTypeface;
    self.applyTimeRangeTitelView.cellLabel.textColor = ThemeColor;
    self.applyTimeRangeTitelView.dividingLineChoice = DividingLineFullScreenLayout;
    self.applyTimeRangeTitelView.isArrow = YES;
    self.applyTimeRangeTitelView.isCellImage = YES;
    [self.postalInfoBackView addArrangedSubview:self.applyTimeRangeTitelView];
    /** 提现时间段 */
    self.applyTimeRangeView = [[UIView alloc] init];
    self.applyTimeRangeView.backgroundColor = WhiteColor;
    [self.postalInfoBackView addArrangedSubview:self.applyTimeRangeView];

    self.applyStartLabel = [[UILabel alloc] init];
    self.applyStartLabel.text = @"申请开始时间";
    self.applyStartLabel.textColor = Black;
    self.applyStartLabel.font = FourteenTypeface;
    self.applyStartLabel.textAlignment = NSTextAlignmentCenter;
    [self.applyTimeRangeView addSubview:self.applyStartLabel];

    self.toLabel = [[UILabel alloc] init];
    self.toLabel.text = @"至";
    self.toLabel.textColor = Black;
    self.toLabel.font = FourteenTypeface;
    [self.applyTimeRangeView addSubview:self.toLabel];

    self.applyEndLabel = [[UILabel alloc] init];
    self.applyEndLabel.text = @"申请结束时间";
    self.applyEndLabel.textColor = Black;
    self.applyEndLabel.font = FourteenTypeface;
    self.applyEndLabel.textAlignment = NSTextAlignmentCenter;
    [self.applyTimeRangeView addSubview:self.applyEndLabel];
    /** 回执单部分背景view */
    self.receiptBackView = [[UIView alloc] init];
    [self.postalInfoBackView addArrangedSubview:self.receiptBackView];
    /** 分割线3 */
    self.threeLineView = [[UIView alloc] init];
    [self.receiptBackView addSubview:self.threeLineView];
    /** 回执单标题 */
    self.receiptTitelView = [[UsedCellView alloc] init];
    self.receiptTitelView.cellLabel.text = @"回执单";
    self.receiptTitelView.cellLabel.font = FifteenTypeface;
    self.receiptTitelView.cellLabel.textColor = ThemeColor;
    self.receiptTitelView.dividingLineChoice = DividingLineFullScreenLayout;
    self.receiptTitelView.isArrow = YES;
    self.receiptTitelView.isCellImage = YES;
    [self.receiptBackView addSubview:self.receiptTitelView];
    /** 回执单 */
    self.receiptView = [[UIView alloc] init];
    self.receiptView.backgroundColor = WhiteColor;
    [self.receiptBackView addSubview:self.receiptView];
    
    self.receiptImg = [[UIImageView alloc] init];
    [self.receiptView addSubview:self.receiptImg];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.postalInfoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.postalInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.postalInfoScrollView.mas_top);
        make.left.equalTo(self.postalInfoScrollView.mas_left);
        make.bottom.equalTo(self.postalInfoScrollView.mas_bottom);
        make.right.equalTo(self.postalInfoScrollView.mas_right);
        make.width.equalTo(self.postalInfoScrollView.mas_width);
        make.bottom.equalTo(self.receiptBackView.mas_bottom);
    }];
    
    
    /** 分割线1 */
    [self.oneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    /** 申请时间 */
    [self.applyTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 提现金额 */
    [self.postalMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 提现状态 */
    [self.postalStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    // 判断订单状态 1-已结算 2 -未结算
    if (self.withdraw_status == 1) { // 已结算
        /** 处理时间 */
        [self.handleTimeView setHidden:NO];
        [self.handleTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
        }];
        /** 处理人 */
        [self.handleManView setHidden:NO];
        [self.handleManView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
        }];
    }else if (self.withdraw_status == 2) {
        /** 处理时间 */
        [self.handleTimeView setHidden:YES];
        [self.handleTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@0);
        }];
        /** 处理人 */
        [self.handleManView setHidden:YES];
        [self.handleManView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@0);
        }];
    }
    /** 分割线2 */
    [self.twoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    /** 提现时间段标题 */
    [self.applyTimeRangeTitelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 提现时间段 */
    [self.applyTimeRangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];

    [self.applyStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.applyTimeRangeView.mas_centerY);
        make.left.equalTo(self.applyTimeRangeView.mas_left).offset(16);
        make.right.equalTo(self.toLabel.mas_left).offset(-7);
    }];

    [self.toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.applyTimeRangeView.mas_centerY);
        make.centerX.equalTo(self.applyTimeRangeView.mas_centerX);
        make.width.mas_equalTo(@14.5);
    }];

    [self.applyEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.applyTimeRangeView.mas_centerY);
        make.left.equalTo(self.toLabel.mas_right).offset(7);
        make.right.equalTo(self.applyTimeRangeView.mas_right).offset(-16);
    }];
    
    // 判断订单状态 1-已结算 2 -未结算
    if (self.withdraw_status == 1) { // 已结算
        /** 回执单部分背景view */
        [self.receiptBackView setHidden:NO];
        [self.receiptBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.receiptView.mas_bottom);
        }];
    }else if (self.withdraw_status == 2) {
        /** 回执单部分背景view */
        [self.receiptBackView setHidden:YES];
        [self.receiptBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@0);
        }];
    }
    /** 分割线3 */
    [self.threeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.receiptBackView.mas_top);
        make.left.equalTo(self.receiptBackView.mas_left);
        make.right.equalTo(self.receiptBackView.mas_right);
        make.height.mas_equalTo(@10);
    }];
    /** 回执单标题 */
    [self.receiptTitelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.threeLineView.mas_bottom);
        make.left.equalTo(self.receiptBackView.mas_left);
        make.right.equalTo(self.receiptBackView.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 回执单 */
    [self.receiptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.receiptTitelView.mas_bottom);
        make.left.equalTo(self.receiptBackView.mas_left);
        make.right.equalTo(self.receiptBackView.mas_right);
        make.bottom.equalTo(self.receiptImg.mas_bottom).offset(20);
    }];
    [self.receiptImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.receiptView.mas_top).offset(16);
        make.left.equalTo(self.receiptView.mas_left).offset(42);
        make.right.equalTo(self.receiptView.mas_right).offset(-42);
        make.height.mas_equalTo(@153);
    }];
}

@end
