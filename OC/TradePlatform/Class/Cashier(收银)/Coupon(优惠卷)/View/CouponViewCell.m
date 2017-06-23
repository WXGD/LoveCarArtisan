//
//  couponInfoViewCell.m
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponViewCell.h"

@interface CouponViewCell ()

/** 背景view */
@property (strong, nonatomic) UIView *backView;
/** 选择优惠劵view */
@property (strong, nonatomic) CouponInfoView *choiceCouponView;
/** 优惠券信息View */
@property (strong, nonatomic) CustomCell *couponInfoView;


@end

@implementation CouponViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        [self typeTableCellLayoutView];
    }
    return self;
}

- (void)typeTableCellLayoutView {
    /** 背景view */
    self.backView = [[UIView alloc] init];
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 2;
    [self.contentView addSubview:self.backView];
    /** 选择优惠劵view */
    self.choiceCouponView = [[CouponInfoView alloc] init];
    [self.choiceCouponView.button setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.choiceCouponView.button setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.backView addSubview:self.choiceCouponView];
    /** 赠送优惠劵view */
    self.giveCouponView = [[CouponInfoView alloc] init];
    [self.giveCouponView.button setImage:nil forState:UIControlStateNormal];
    [self.giveCouponView.button setTitle:@"赠送" forState:UIControlStateNormal];
    self.giveCouponView.button.titleLabel.font = ThirteenTypeface;
    self.giveCouponView.button.titleLabel.textColor = WhiteColor;
    self.giveCouponView.button.backgroundColor = ThemeColor;
    self.giveCouponView.button.layer.masksToBounds = YES;
    self.giveCouponView.button.layer.cornerRadius = 2;
    self.giveCouponView.btnSize = CGSizeMake(50, 24);
    [self.backView addSubview:self.giveCouponView];
    /** 优惠券信息View */
    self.couponInfoView = [[CustomCell alloc] init];
    self.couponInfoView.lineStyle = FullScreenLayout;
    self.couponInfoView.cellStyle = HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.couponInfoView.mainLabel.text = @"详细信息";
    self.couponInfoView.mainLabel.textColor = GrayH2;
    self.couponInfoView.mainLabel.font = TwelveTypeface;
    self.couponInfoView.backgroundColor = VCBackgroundThree;
    [self.couponInfoView.mainBtn addTarget:self action:@selector(couponInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.couponInfoView];
}

// 按钮点击方法
- (void)couponInfoAction:(UIButton *)button {
    [AlertAction determineStay:[self viewController] title:@"详细信息" admitStr:@"确定" message:_couponInfoModel.descri determineBlock:^{
        
    }];
}


/** 赠送／以赠送按钮 */
- (void)setCouponCellType:(CouponCellType)couponCellType {
    _couponCellType = couponCellType;
//    /** 选择使用优惠券 */
//    if (couponCellType == ChoiceUseCouponStyle) {
//        /** 赠送／以赠送按钮 */
//        [self.giveBtn setHidden:YES];
//        /** 选中标记 */
//        [self.checkMarkBtn setHidden:NO];
//    }else if (couponCellType == ChoiceGrantCouponStyle) { /** 选择发放优惠券 */
//        /** 选中标记 */
//        [self.checkMarkBtn setHidden:YES];
//        /** 赠送／以赠送按钮 */
//        [self.giveBtn setHidden:NO];
//    }
}
/** 优惠券模型 */
- (void)setCouponInfoModel:(CouponInfoModel *)couponInfoModel {
    _couponInfoModel = couponInfoModel;
    /** 选择优惠劵view */
    /** 优惠金额 */
    self.choiceCouponView.couponSumLabel.text = [NSString stringWithFormat:@"%.2f", couponInfoModel.money];
    /** 优惠券名称 */
    self.choiceCouponView.couponNameLabel.text = couponInfoModel.name;
    /** 使用条件 */
    if (couponInfoModel.full_money > 0) {
        self.choiceCouponView.useConditionLabel.text = [NSString stringWithFormat:@"满%.2f元可用", couponInfoModel.full_money];
    }
    /** 优惠券使用周期 */
    if (couponInfoModel.available_end_time.length == 0) {
        self.choiceCouponView.couponTimeLabel.text = @"不限期";
    }else {
        self.choiceCouponView.couponTimeLabel.text = [NSString stringWithFormat:@"限%@至%@使用", couponInfoModel.available_start_time, couponInfoModel.available_end_time];
    }
    /** 选中标记 */
    self.choiceCouponView.button.selected = couponInfoModel.checkMark;
    /** 0-不可用 1-可用 默认为1  */
    if (couponInfoModel.is_useful && self.couponCellType == ChoiceUseCouponStyle) {
        /** 优惠金额 */
        self.choiceCouponView.couponSumLabel.textColor = RedColor;
        /** 优惠金额标记 */
        self.choiceCouponView.couponSumSign.textColor = RedColor;
    }else if(!couponInfoModel.is_useful && self.couponCellType == ChoiceUseCouponStyle) {
        /** 优惠金额 */
        self.choiceCouponView.couponSumLabel.textColor = GrayH2;
        /** 优惠金额标记 */
        self.choiceCouponView.couponSumSign.textColor = GrayH2;
    }
    
    
    /** 赠送优惠劵view */
    /** 优惠金额 */
    self.giveCouponView.couponSumLabel.text = [NSString stringWithFormat:@"%.2f", couponInfoModel.money];
    /** 优惠券名称 */
    self.giveCouponView.couponNameLabel.text = couponInfoModel.name;
    /** 使用条件 */
    if (couponInfoModel.full_money > 0) {
        self.giveCouponView.useConditionLabel.text = [NSString stringWithFormat:@"满%.2f元可用", couponInfoModel.full_money];
    }
    /** 优惠券使用周期 */
    if (couponInfoModel.available_end_time.length == 0) {
        self.giveCouponView.couponTimeLabel.text = @"不限期";
    }else {
        self.giveCouponView.couponTimeLabel.text = [NSString stringWithFormat:@"限%@至%@使用", couponInfoModel.available_start_time, couponInfoModel.available_end_time];
    }
    /** 标记是否可以赠送 0-赠送 1-不赠送 */
    if (couponInfoModel.markGive) {
        [self.giveCouponView.button setTitle:@"已赠送" forState:UIControlStateNormal];
        self.giveCouponView.button.backgroundColor = GrayH1;
        self.giveCouponView.button.enabled = NO;
    }else {
        [self.giveCouponView.button setTitle:@"赠送" forState:UIControlStateNormal];
        self.giveCouponView.button.backgroundColor = ThemeColor;
        self.giveCouponView.button.enabled = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    /** 选择使用优惠券 */
    if (self.couponCellType == ChoiceUseCouponStyle) {
        /** 选择优惠劵view */
        [self.choiceCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.backView.mas_top);
            make.left.equalTo(self.backView.mas_left);
            make.right.equalTo(self.backView.mas_right);
            make.height.mas_equalTo(@(90));
        }];
        /** 赠送优惠劵view */
        [self.giveCouponView setHidden:YES];
        /** 优惠券信息View */
        [self.couponInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.choiceCouponView.mas_bottom);
            make.left.equalTo(self.backView.mas_left);
            make.right.equalTo(self.backView.mas_right);
            make.height.mas_equalTo(@(35));
        }];
    }else if (self.couponCellType == ChoiceGrantCouponStyle) { /** 选择发放优惠券 */
        /** 赠送优惠劵view */
        [self.giveCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.backView.mas_top);
            make.left.equalTo(self.backView.mas_left);
            make.right.equalTo(self.backView.mas_right);
            make.height.mas_equalTo(@(90));
        }];
        /** 选择优惠劵view */
        [self.choiceCouponView setHidden:YES];
        /** 优惠券信息View */
        [self.couponInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.giveCouponView.mas_bottom);
            make.left.equalTo(self.backView.mas_left);
            make.right.equalTo(self.backView.mas_right);
            make.height.mas_equalTo(@(35));
        }];
    }
}


@end
