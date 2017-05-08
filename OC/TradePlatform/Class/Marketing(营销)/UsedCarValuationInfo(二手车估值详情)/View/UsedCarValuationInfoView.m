//
//  UsedCarValuationInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarValuationInfoView.h"

@interface UsedCarValuationInfoView ()

/** 车牌型号 */
@property (strong, nonatomic) UIView *carBrandView;
@property (strong, nonatomic) UILabel *carBrandTitle;
@property (strong, nonatomic) UIView *carBrandLine;

@end

@implementation UsedCarValuationInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self usedCarValuationInfoLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)usedCarValuationInfoLayoutView {
    /** 车商收购价 */
    self.buyPriceView = [[UsedCellView alloc] init];
    self.buyPriceView.cellLabel.text = @"车商收购价";
    self.buyPriceView.cellLabel.font = FourteenTypeface;
    self.buyPriceView.cellLabel.textColor = GrayH1;
    self.buyPriceView.describeLabel.textAlignment = NSTextAlignmentLeft;
    self.buyPriceView.describeLabel.textColor = ThemeColor;
    self.buyPriceView.describeLabel.font = FourteenTypeface;
    self.buyPriceView.isCellImage = YES;
    self.buyPriceView.isArrow = YES;
    self.buyPriceView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.buyPriceView];
    /** 个人交易价 */
    self.dealPriceView = [[UsedCellView alloc] init];
    self.dealPriceView.cellLabel.text = @"个人交易价";
    self.dealPriceView.cellLabel.font = FourteenTypeface;
    self.dealPriceView.cellLabel.textColor = GrayH1;
    self.dealPriceView.describeLabel.textColor = BlueColor;
    self.dealPriceView.describeLabel.font = FourteenTypeface;
    self.dealPriceView.isCellImage = YES;
    self.dealPriceView.isSplistLine = YES;
    self.dealPriceView.isArrow = YES;
    [self addSubview:self.dealPriceView];
    /** 车辆型号 */
    self.carBrandView = [[UIView alloc] init];
    self.carBrandView.backgroundColor = WhiteColor;
    [self addSubview:self.carBrandView];
    
    self.carBrandTitle = [[UILabel alloc] init];
    self.carBrandTitle.text = @"车辆型号";
    self.carBrandTitle.font = FourteenTypeface;
    self.carBrandTitle.textColor = GrayH1;
    [self.carBrandView addSubview:self.carBrandTitle];
    
    self.carBrandDetails = [[UILabel alloc] init];
    self.carBrandDetails.textAlignment = NSTextAlignmentRight;
    self.carBrandDetails.textColor = Black;
    self.carBrandDetails.font = FourteenTypeface;
    self.carBrandDetails.numberOfLines = 2;
    [self.carBrandView addSubview:self.carBrandDetails];
    
    self.carBrandLine = [[UIView alloc] init];
    self.carBrandLine.backgroundColor = DividingLine;
    [self.carBrandView addSubview:self.carBrandLine];
    /** 所在城市 */
    self.cityView = [[UsedCellView alloc] init];
    self.cityView.cellLabel.text = @"所在城市";
    self.cityView.cellLabel.font = FourteenTypeface;
    self.cityView.cellLabel.textColor = GrayH1;
    self.cityView.describeLabel.textColor = Black;
    self.cityView.describeLabel.font = FourteenTypeface;
    self.cityView.isCellImage = YES;
    self.cityView.isArrow = YES;
    self.cityView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.cityView];
    /** 首次上牌 */
    self.firstFailingView = [[UsedCellView alloc] init];
    self.firstFailingView.cellLabel.text = @"首次上牌";
    self.firstFailingView.cellLabel.font = FourteenTypeface;
    self.firstFailingView.cellLabel.textColor = GrayH1;
    self.firstFailingView.describeLabel.textColor = Black;
    self.firstFailingView.describeLabel.font = FourteenTypeface;
    self.firstFailingView.isCellImage = YES;
    self.firstFailingView.isArrow = YES;
    self.firstFailingView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.firstFailingView];
    /** 行驶里程 */
    self.mileageView = [[UsedCellView alloc] init];
    self.mileageView.cellLabel.text = @"行驶里程";
    self.mileageView.cellLabel.font = FourteenTypeface;
    self.mileageView.cellLabel.textColor = GrayH1;
    self.mileageView.describeLabel.textColor = Black;
    self.mileageView.describeLabel.font = FourteenTypeface;
    self.mileageView.isCellImage = YES;
    self.mileageView.isArrow = YES;
    self.mileageView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.mileageView];
    /** 车况 */
    self.conditionView = [[UsedCellView alloc] init];
    self.conditionView.cellLabel.text = @"车况";
    self.conditionView.cellLabel.font = FourteenTypeface;
    self.conditionView.cellLabel.textColor = GrayH1;
    self.conditionView.describeLabel.textColor = Black;
    self.conditionView.describeLabel.font = FourteenTypeface;
    self.conditionView.isCellImage = YES;
    self.conditionView.isArrow = YES;
    self.conditionView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.conditionView];
    /** 车辆用途 */
    self.carUseView = [[UsedCellView alloc] init];
    self.carUseView.cellLabel.text = @"车辆用途";
    self.carUseView.cellLabel.font = FourteenTypeface;
    self.carUseView.cellLabel.textColor = GrayH1;
    self.carUseView.describeLabel.textColor = Black;
    self.carUseView.describeLabel.font = FourteenTypeface;
    self.carUseView.isCellImage = YES;
    self.carUseView.isArrow = YES;
    self.carUseView.dividingLineChoice = DividingLineFullScreenLayout;
    [self addSubview:self.carUseView];
    /** 车辆购入价 */
    self.carBuyPriceView = [[UsedCellView alloc] init];
    self.carBuyPriceView.cellLabel.text = @"车辆购入价";
    self.carBuyPriceView.cellLabel.font = FifteenTypeface;
    self.carBuyPriceView.cellLabel.textColor = GrayH1;
    self.carBuyPriceView.describeLabel.textColor = Black;
    self.carBuyPriceView.describeLabel.font = FourteenTypeface;
    self.carBuyPriceView.isCellImage = YES;
    self.carBuyPriceView.isSplistLine = YES;
    self.carBuyPriceView.isArrow = YES;
    [self addSubview:self.carBuyPriceView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 车商收购价 */
    [self.buyPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 个人交易价 */
    [self.dealPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.buyPriceView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 车辆型号 */
    [self.carBrandView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dealPriceView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    [self.carBrandTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.carBrandView.mas_centerY);
        make.left.equalTo(self.carBrandView.mas_left).offset(16);
        make.width.mas_equalTo(@62);
    }];
    [self.carBrandDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.carBrandView.mas_centerY);
        make.right.equalTo(self.carBrandView.mas_right).offset(-16);
        make.left.equalTo(self.carBrandTitle.mas_right).offset(16);
    }];
    [self.carBrandLine mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.carBrandView.mas_left);
        make.right.equalTo(self.carBrandView.mas_right);
        make.bottom.equalTo(self.carBrandView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
    /** 所在城市 */
    [self.cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBrandView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 首次上牌 */
    [self.firstFailingView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cityView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 行驶里程 */
    [self.mileageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.firstFailingView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 车况 */
    [self.conditionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mileageView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 车辆用途 */
    [self.carUseView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.conditionView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 车辆购入价 */
    [self.carBuyPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carUseView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];
}

@end
