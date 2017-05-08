//
//  ExpireHeaderView.m
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import "ExpireHeaderView.h"

@interface ExpireHeaderView ()

/** 头部背景view */
@property (strong, nonatomic) UIView *headerView;
/** 尖头 */
@property (strong, nonatomic) UIImageView *arrayImage;

@end

@implementation ExpireHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self expireHeaderLayoutView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self expireHeaderLayoutView];
    }
    return self;
}


- (void)expireHeaderLayoutView {
    /** 头部背景view */
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = WhiteColor;
    [self addSubview:self.headerView];
    /** 选择区域 */
    self.seleAreaLabel = [[UILabel alloc] init];
    self.seleAreaLabel.font = FourteenTypeface;
    self.seleAreaLabel.textColor = Black;
    [self.headerView addSubview:self.seleAreaLabel];
    /** 尖头 */
    self.arrayImage = [[UIImageView alloc] init];
    self.arrayImage.image = [UIImage imageNamed:@"bottom_arrow_gray"];
    [self.headerView addSubview:self.arrayImage];
    /** 选择区域按钮 */
    self.seleAreaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.seleAreaBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 头部背景view */
    self.headerView.frame = CGRectMake(16, 10, ScreenW - 32, 30);
    /** 选择区域 */
    [self.seleAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.headerView.mas_centerY);
        make.left.equalTo(self.headerView.mas_left).offset(16);
    }];
    /** 尖头 */
    [self.arrayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.headerView.mas_right).offset(-16);
        make.centerY.equalTo(self.headerView.mas_centerY);
    }];
    /** 选择区域按钮 */
    [self.seleAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.headerView.mas_right);
        make.left.equalTo(self.headerView.mas_left);
        make.top.equalTo(self.headerView.mas_top);
        make.bottom.equalTo(self.headerView.mas_bottom);
    }];
}

@end
