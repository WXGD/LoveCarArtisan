//
//  RangeView.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import "RangeView.h"

@interface RangeView ()

/** 背景view */
@property (strong, nonatomic) UIView *backView;
/** 到 */
@property (strong, nonatomic) UILabel *daoLabel;

@end

@implementation RangeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self rangeLayoutView];
    }
    return self;
}

- (void)rangeLayoutView {
    /** 背景view */
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = WhiteColor;
    [self addSubview:self.backView];
    /** 开始时间 */
    self.startTF = [[UITextField alloc] init];
    self.startTF.textColor = Black;
    self.startTF.font = FourteenTypeface;
    self.startTF.textAlignment = NSTextAlignmentCenter;
    self.startTF.layer.masksToBounds = YES;
    self.startTF.layer.borderColor = GrayH4.CGColor;
    self.startTF.layer.borderWidth = 0.5;
    [self.backView addSubview:self.startTF];
    /** 到 */
    self.daoLabel = [[UILabel alloc] init];
    self.daoLabel.font = TwelveTypeface;
    self.daoLabel.textColor = Black;
    self.daoLabel.text = @"到";
    [self.backView addSubview:self.daoLabel];
    /** 结束时间 */
    self.endTF = [[UITextField alloc] init];
    self.endTF.textColor = Black;
    self.endTF.font = FourteenTypeface;
    self.endTF.textAlignment = NSTextAlignmentCenter;
    self.endTF.layer.masksToBounds = YES;
    self.endTF.layer.borderColor = GrayH4.CGColor;
    self.endTF.layer.borderWidth = 0.5;
    [self.backView addSubview:self.endTF];
    /** 操作按钮 */
    self.handleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.handleBtn setTitle:@"新增" forState:UIControlStateNormal];
    [self.handleBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [self.handleBtn setImage:[UIImage imageNamed:@"marketing_add"] forState:UIControlStateNormal];
    self.handleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [self.backView addSubview:self.handleBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 开始时间 */
    [self.startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.equalTo(self.backView.mas_left).offset(19);
        make.width.mas_equalTo(@112);
        make.height.mas_equalTo(@30);
    }];
    /** 到 */
    [self.daoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.equalTo(self.startTF.mas_right).offset(13);
    }];
    /** 结束时间 */
    [self.endTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.equalTo(self.daoLabel.mas_right).offset(13);
        make.width.mas_equalTo(@112);
        make.height.mas_equalTo(@30);
    }];
    /** 操作按钮 */
    [self.handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView.mas_top);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.right.equalTo(self.backView.mas_right).offset(-16);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.backView.mas_bottom);
    }];
}
@end
