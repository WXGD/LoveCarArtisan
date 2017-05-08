//
//  UserCarView.m
//  TradePlatform
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCarView.h"

@interface UserCarView ()

/** 操作view */
@property (strong, nonatomic) UIView *operationView;

@end

@implementation UserCarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = HEXSTR_RGB(@"efeff4").CGColor;
        self.backgroundColor = VCBackgroundThree;
        [self userCarLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)userCarLayoutView {
    /** 车辆品牌图片 */
    self.carBrandImage = [[UIImageView alloc] init];
    self.carBrandImage.image = [UIImage imageNamed:@"placeholder_search_car"];
    self.carBrandImage.layer.masksToBounds = YES;
    self.carBrandImage.layer.cornerRadius = 26;
    [self addSubview:self.carBrandImage];
    /** 车辆品牌 */
    self.carBrandLabel = [[UILabel alloc] init];
    self.carBrandLabel.text = @"车辆品牌";
    self.carBrandLabel.textColor = Black;
    self.carBrandLabel.font = FifteenTypeface;
    [self addSubview:self.carBrandLabel];
    /** 车辆车牌 */
    self.carPlnLabel = [[UILabel alloc] init];
    self.carPlnLabel.text = @"车辆车牌";
    self.carPlnLabel.textColor = GrayH2;
    self.carPlnLabel.font = FourteenTypeface;
    [self addSubview:self.carPlnLabel];
    /** 操作view */
    self.operationView = [[UIView alloc] init];
    [self addSubview:self.operationView];
    /** 编辑按钮 */
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = ThirteenTypeface;
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.cornerRadius = 2;
    self.editBtn.layer.borderWidth = 0.5;
    self.editBtn.layer.borderColor = HEXSTR_RGB(@"cccccc").CGColor;
    [self.operationView addSubview:self.editBtn];
    /** 二手车估值 */
    self.useCarValuationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.useCarValuationBtn setTitle:@"二手车估值" forState:UIControlStateNormal];
    [self.useCarValuationBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.useCarValuationBtn.titleLabel.font = ThirteenTypeface;
    self.useCarValuationBtn.layer.masksToBounds = YES;
    self.useCarValuationBtn.layer.cornerRadius = 2;
    self.useCarValuationBtn.layer.borderWidth = 0.5;
    self.useCarValuationBtn.layer.borderColor = ThemeColor.CGColor;
    [self.operationView addSubview:self.useCarValuationBtn];
    /** 查保险 */
    self.quiryBenefitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.quiryBenefitBtn setTitle:@"查保险" forState:UIControlStateNormal];
    [self.quiryBenefitBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.quiryBenefitBtn.titleLabel.font = ThirteenTypeface;
    self.quiryBenefitBtn.layer.masksToBounds = YES;
    self.quiryBenefitBtn.layer.cornerRadius = 2;
    self.quiryBenefitBtn.layer.borderWidth = 0.5;
    self.quiryBenefitBtn.layer.borderColor = ThemeColor.CGColor;
    [self.operationView addSubview:self.quiryBenefitBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 车辆品牌图片 */
    [self.carBrandImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(52, 52));
    }];
    /** 车辆品牌 */
    [self.carBrandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.carBrandImage.mas_centerY).offset(-5);
        make.left.equalTo(self.carBrandImage.mas_right).offset(16);
    }];
    /** 车辆车牌 */
    [self.carPlnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBrandImage.mas_centerY).offset(5);
        make.left.equalTo(self.carBrandLabel.mas_left);
    }];
    /** 操作view */
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBrandImage.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@48);
    }];/** 查保险 */
    [self.quiryBenefitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.operationView.mas_centerY);
        make.right.equalTo(self.operationView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(71, 25));
    }];
    /** 二手车估值 */
    [self.useCarValuationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.operationView.mas_centerY);
        make.right.equalTo(self.quiryBenefitBtn.mas_left).offset(-16);
        make.size.mas_equalTo(CGSizeMake(99, 25));
    }];
    /** 编辑按钮 */
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.operationView.mas_centerY);
        make.right.equalTo(self.useCarValuationBtn.mas_left).offset(-16);
        make.size.mas_equalTo(CGSizeMake(59, 25));
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.operationView.mas_bottom);
    }];
}

@end
