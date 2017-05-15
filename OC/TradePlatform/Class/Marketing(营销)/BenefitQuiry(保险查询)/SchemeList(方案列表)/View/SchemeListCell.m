//
//  SchemeListCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SchemeListCell.h"

@interface SchemeListCell ()

/** 方案内容view */
@property (strong, nonatomic) UIView *schemeCententView;

@end

@implementation SchemeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** 方案标题view */
        self.schemeTitleView = [[UsedCellView alloc] init];
        self.schemeTitleView.cellLabel.text = @"方案";
        self.schemeTitleView.cellLabel.font = FifteenTypeface;
        self.schemeTitleView.cellLabel.textColor = ThemeColor;
        self.schemeTitleView.isCellImage = YES;
        self.schemeTitleView.isCellBtn = YES;
        self.schemeTitleView.dividingLineChoice = DividingLineCenterLayout;
        [self.contentView addSubview:self.schemeTitleView];
        /** 方案内容view */
        self.schemeCententView = [[UIView alloc] init];
        self.schemeCententView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.schemeCententView];
        /** 方案内容Label */
        self.schemeCententLabel = [[UILabel alloc] init];
        self.schemeCententLabel.textColor = GrayH1;
        self.schemeCententLabel.font = TwelveTypeface;
        self.schemeCententLabel.numberOfLines = 0;
        [self.schemeCententView addSubview:self.schemeCententLabel];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 方案标题view */
    [self.schemeTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@44);
    }];
    /** 方案内容view */
    [self.schemeCententView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.schemeTitleView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.schemeCententLabel.mas_bottom).offset(20);
    }];
    /** 方案内容Label */
    [self.schemeCententLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.schemeCententView.mas_left).offset(16);
        make.top.equalTo(self.schemeCententView.mas_top).offset(20);
        make.right.equalTo(self.schemeCententView.mas_right).offset(-16);
    }];
}



@end
