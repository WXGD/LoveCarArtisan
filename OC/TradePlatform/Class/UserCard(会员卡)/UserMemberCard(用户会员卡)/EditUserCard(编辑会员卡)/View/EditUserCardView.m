//
//  EditUserCardView.m
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditUserCardView.h"

@interface EditUserCardView ()

/** 头部背景view */
@property (strong, nonatomic) UIView *headerView;

@end

@implementation EditUserCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self editUserCardLayoutView];
    }
    return self;
}



- (void)editUserCardLayoutView {
//    /** 头部背景view */
//    self.headerView = [[UIView alloc] init];
//    self.headerView.backgroundColor = ThemeColor;
//    [self addSubview:self.headerView];
//    /** 卡号 */
//    self.editCardNum = [[UsedCellView alloc] init];
//    self.editCardNum.backgroundColor = CLEARCOLOR;
//    self.editCardNum.cellLabel.text = @"卡号";
//    self.editCardNum.cellLabel.font = FourteenTypeface;
//    self.editCardNum.cellLabel.textColor = RGBA(255, 255, 255, 0.8);
//    self.editCardNum.describeLabel.textColor = WhiteColor;
//    self.editCardNum.describeLabel.font = FourteenTypeface;
//    self.editCardNum.isArrow = YES;
//    self.editCardNum.isCellImage = YES;
//    self.editCardNum.isSplistLine = YES;
//    [self.headerView addSubview:self.editCardNum];
//    /** 余次 */
//    self.editNoreThan = [[UsedCellView alloc] init];
//    self.editNoreThan.backgroundColor = CLEARCOLOR;
//    self.editNoreThan.cellLabel.font = FourteenTypeface;
//    self.editNoreThan.cellLabel.textColor = RGBA(255, 255, 255, 0.8);
//    self.editNoreThan.describeLabel.textColor = WhiteColor;
//    self.editNoreThan.describeLabel.font = FourteenTypeface;
//    self.editNoreThan.isArrow = YES;
//    self.editNoreThan.isCellImage = YES;
//    self.editNoreThan.isSplistLine = YES;
//    [self.headerView addSubview:self.editNoreThan];
    /** 有效期 */
    self.editExpiryDate = [[UsedCellView alloc] init];
    self.editExpiryDate.cellLabel.text = @"有效期";
    self.editExpiryDate.cellLabel.font = FifteenTypeface;
    self.editExpiryDate.cellLabel.textColor = GrayH1;
    self.editExpiryDate.describeLabel.text = @"请选择日期";
    self.editExpiryDate.describeLabel.font = ThirteenTypeface;
    self.editExpiryDate.describeLabel.textColor = Black;
    self.editExpiryDate.isSplistLine = YES;
    self.editExpiryDate.isCellImage = YES;
    [self addSubview:self.editExpiryDate];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
//    /** 头部背景view */
//    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.editNoreThan.cellLabel.mas_bottom).offset(20);
//    }];
//    /** 卡号 */
//    [self.editCardNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.headerView.mas_top).offset(20);
//        make.bottom.equalTo(self.editCardNum.cellLabel.mas_bottom);
//    }];
//    /** 余次 */
//    [self.editNoreThan mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.editCardNum.mas_bottom).offset(16);
//        make.bottom.equalTo(self.editNoreThan.cellLabel.mas_bottom);
//    }];
    /** 有效期 */
    [self.editExpiryDate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@50);
    }];
}


@end
