//
//  AdminChoseCell.m
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AdminChoseCell.h"

@interface AdminChoseCell ()

/** 背景view */
@property (strong, nonatomic) UIView *backView;

@end

@implementation AdminChoseCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        [self fiterConditionCellLayoutView];
    }
    return self;
}


- (void)setIsAdminSelected:(BOOL)isAdminSelected {
    _isAdminSelected = isAdminSelected;
    if (isAdminSelected) {
        self.backView.layer.borderColor = ThemeColor.CGColor;
        self.backView.layer.borderWidth = 1;
        /** 标题 */
        self.adminChoseTitleLabel.textColor = ThemeColor;
        /** 删除管理按钮 */
        [self.delAdminBtn setHidden:NO];
    }else {
        self.backView.layer.borderColor = WhiteColor.CGColor;
        /** 标题 */
        self.adminChoseTitleLabel.textColor = Black;
        /** 删除管理按钮 */
        [self.delAdminBtn setHidden:YES];
    }
}

- (void)fiterConditionCellLayoutView {
    /** 背景view */
    self.backView = [[UIView alloc] init];
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 2;
    self.backView.backgroundColor = WhiteColor;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = WhiteColor.CGColor;
    [self addSubview:self.backView];
    /** 标题 */
    self.adminChoseTitleLabel = [[UILabel alloc] init];
    self.adminChoseTitleLabel.textColor = Black;
    self.adminChoseTitleLabel.font = ThirteenTypeface;
    [self.backView addSubview:self.adminChoseTitleLabel];
    /** 删除管理按钮 */
    self.delAdminBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.delAdminBtn setImage:[UIImage imageNamed:@"del_admin"] forState:UIControlStateNormal];
    [self addSubview:self.delAdminBtn];
    [self.delAdminBtn setHidden:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(self.mas_left).offset(7);
        make.right.equalTo(self.mas_right).offset(-7);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
    /** 标题 */
    [self.adminChoseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.backView.mas_centerX);
        make.centerY.equalTo(self.backView.mas_centerY);
    }];
    /** 删除管理按钮 */
    [self.delAdminBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.backView.mas_right);
        make.centerY.equalTo(self.backView.mas_top);
    }];
}

@end


