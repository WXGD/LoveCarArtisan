//
//  ChangeSexView.m
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangeSexView.h"

@interface ChangeSexView ()

/** 男 */
@property (strong, nonatomic) UILabel *maleLabel;
/** 女 */
@property (strong, nonatomic) UILabel *femaleLabel;
/** 男 */
@property (strong, nonatomic) UIButton *maleTitle;
/** 女 */
@property (strong, nonatomic) UIButton *femaleTitle;
/** 默认选中 */
@property (strong, nonatomic) UIButton *defaultSelected;

@end

@implementation ChangeSexView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.changeSexShowStyle = ViewHorizontalLayout;
        [self changeSexLayoutView];
    }
    return self;
}

- (void)titleBtnAction:(UIButton *)button {
    _defaultSelected.selected = !_defaultSelected.selected;
    button.selected = YES;
    _defaultSelected = button;
    self.selectedSex = [NSString stringWithFormat:@"%ld", (long)button.tag];
}

- (void)setDefaultSex:(NSString *)defaultSex {
    _defaultSex = defaultSex;
    PDLog(@"%@", defaultSex);
    if (![defaultSex isEqualToString:@"女"] || !self.defaultSelected) {
        self.maleTitle.selected = YES;
        self.selectedSex = @"0";
        _defaultSelected = self.maleTitle;
    }else if ([defaultSex isEqualToString:@"女"]) {
        self.femaleTitle.selected = YES;
        self.selectedSex = @"1";
        _defaultSelected = self.femaleTitle;
    }
}

- (void)changeSexLayoutView {
    /** 初始化默认按钮 */
    self.defaultSelected = [UIButton buttonWithType:UIButtonTypeCustom];
    /** 男 */
    self.maleLabel = [[UILabel alloc] init];
    self.maleLabel.text = @"男";
    self.maleLabel.font = FourteenTypeface;
    self.maleLabel.textColor = Black;
    [self addSubview:self.maleLabel];
    /** 男 */
    self.maleTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.maleTitle setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.maleTitle setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.maleTitle addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.maleTitle.tag = 0;
    [self addSubview:self.maleTitle];
    /** 女 */
    self.femaleLabel = [[UILabel alloc] init];
    self.femaleLabel.text = @"女";
    self.femaleLabel.font = FourteenTypeface;
    self.femaleLabel.textColor = Black;
    [self addSubview:self.femaleLabel];
    /** 女 */
    self.femaleTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.femaleTitle setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.femaleTitle setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.femaleTitle addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.femaleTitle.tag = 1;
    [self addSubview:self.femaleTitle];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.changeSexShowStyle) {
        /** 控件横向布局 */
        case ViewHorizontalLayout: {
            [self viewHorizontalLayout];
            break;
        }
        /** 控件纵向向布局 */
        case ViewVerticallyLayout: {
            [self viewVerticallyLayout];
            break;
        }
        default:
            break;
    }
}


/** 控件横向布局 */
- (void)viewHorizontalLayout{
    @weakify(self)
    /** 男 */
    [self.maleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    /** 男 */
    [self.maleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.maleLabel.mas_right).offset(15);
        make.centerY.equalTo(self.maleLabel.mas_centerY);
    }];
    /** 女 */
    [self.femaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.maleLabel.mas_centerY);
    }];
    /** 女 */
    [self.femaleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.femaleLabel.mas_right).offset(15);
        make.centerY.equalTo(self.femaleLabel.mas_centerY);
    }];
    /** self高度 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.femaleTitle.mas_bottom);
    }];
}
/** 控件纵向向布局 */
- (void)viewVerticallyLayout {
    @weakify(self)
    /** 男 */
    [self.maleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    /** 男 */
    [self.maleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.maleLabel.mas_right).offset(15);
        make.centerY.equalTo(self.maleLabel.mas_centerY);
    }];
    /** 女 */
    [self.femaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.maleLabel.mas_bottom).offset(15);
    }];
    /** 女 */
    [self.femaleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.femaleLabel.mas_right).offset(15);
        make.centerY.equalTo(self.femaleLabel.mas_centerY);
    }];
    /** self高度 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.femaleTitle.mas_bottom);
    }];
}


@end
