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
/** 优惠券内容view */
@property (strong, nonatomic) UIView *couponContentView;
/** 优惠金额标记 */
@property (strong, nonatomic) UILabel *couponSumSign;
/** 优惠金额 */
@property (strong, nonatomic) UILabel *couponSumLabel;
/** 使用条件 */
@property (strong, nonatomic) UILabel *useConditionLabel;
/** 优惠券名称 */
@property (strong, nonatomic) UILabel *couponNameLabel;
/** 优惠券使用周期 */
@property (strong, nonatomic) UILabel *couponTimeLabel;
/** 选中标记 */
@property (strong, nonatomic) UIButton *checkMarkBtn;
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
    /** 优惠券内容view */
    self.couponContentView = [[UIView alloc] init];
    self.couponContentView.backgroundColor = WhiteColor;
    [self.backView addSubview:self.couponContentView];
    /** 优惠金额 */
    self.couponSumLabel = [[UILabel alloc] init];
    self.couponSumLabel.textColor = RedColor;
    self.couponSumLabel.font = TwentyFourTypeface;
    [self.backView addSubview:self.couponSumLabel];
    /** 使用条件 */
    self.useConditionLabel = [[UILabel alloc] init];
    self.useConditionLabel.textColor = GrayH1;
    self.useConditionLabel.font = TwelveTypeface;
    [self.backView addSubview:self.useConditionLabel];
    /** 优惠金额标记 */
    self.couponSumSign = [[UILabel alloc] init];
    self.couponSumSign.textColor = RedColor;
    self.couponSumSign.font = FifteenTypeface;
    self.couponSumSign.text = @"¥";
    [self.backView addSubview:self.couponSumSign];
    /** 优惠券名称 */
    self.couponNameLabel = [[UILabel alloc] init];
    self.couponNameLabel.textColor = Black;
    self.couponNameLabel.font = FourteenTypeface;
    [self.backView addSubview:self.couponNameLabel];
    /** 优惠券使用周期 */
    self.couponTimeLabel = [[UILabel alloc] init];
    self.couponTimeLabel.textColor = GrayH2;
    self.couponTimeLabel.font = ElevenTypeface;
    self.couponTimeLabel.numberOfLines = 0;
    [self.backView addSubview:self.couponTimeLabel];
    /** 选中标记 */
    self.checkMarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkMarkBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.checkMarkBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.checkMarkBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.checkMarkBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.backView addSubview:self.checkMarkBtn];
    /** 赠送／以赠送按钮 */
    self.giveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.giveBtn setTitle:@"赠送" forState:UIControlStateNormal];
    self.giveBtn.titleLabel.font = ThirteenTypeface;
    self.giveBtn.titleLabel.textColor = WhiteColor;
    self.giveBtn.backgroundColor = ThemeColor;
    self.giveBtn.layer.masksToBounds = YES;
    self.giveBtn.layer.cornerRadius = 2;
    [self.giveBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.giveBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.backView addSubview:self.giveBtn];
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
    /** 选择使用优惠券 */
    if (couponCellType == ChoiceUseCouponStyle) {
        /** 赠送／以赠送按钮 */
        [self.giveBtn setHidden:YES];
        /** 选中标记 */
        [self.checkMarkBtn setHidden:NO];
    }else if (couponCellType == ChoiceGrantCouponStyle) { /** 选择发放优惠券 */
        /** 选中标记 */
        [self.checkMarkBtn setHidden:YES];
        /** 赠送／以赠送按钮 */
        [self.giveBtn setHidden:NO];
    }
}
/** 优惠券模型 */
- (void)setCouponInfoModel:(CouponInfoModel *)couponInfoModel {
    _couponInfoModel = couponInfoModel;
    /** 优惠金额 */
    self.couponSumLabel.text = [NSString stringWithFormat:@"%.2f", couponInfoModel.money];
    /** 优惠券名称 */
    self.couponNameLabel.text = couponInfoModel.name;
    /** 使用条件 */
    if (couponInfoModel.full_money > 0) {
        self.useConditionLabel.text = [NSString stringWithFormat:@"满%.2f元可用", couponInfoModel.full_money];
    }
    /** 优惠券使用周期 */
    if (couponInfoModel.available_end_time.length == 0) {
        self.couponTimeLabel.text = @"不限期";
    }else {
        self.couponTimeLabel.text = [NSString stringWithFormat:@"限%@至%@使用", couponInfoModel.available_start_time, couponInfoModel.available_end_time];
    }
    /** 选中标记 */
    self.checkMarkBtn.selected = couponInfoModel.checkMark;
    /** 0-不可用 1-可用 默认为1  */
    if (couponInfoModel.is_useful && self.couponCellType == ChoiceUseCouponStyle) {
        /** 优惠金额 */
        self.couponSumLabel.textColor = RedColor;
        /** 优惠金额标记 */
        self.couponSumSign.textColor = RedColor;
    }else if(!couponInfoModel.is_useful && self.couponCellType == ChoiceUseCouponStyle) {
        /** 优惠金额 */
        self.couponSumLabel.textColor = GrayH2;
        /** 优惠金额标记 */
        self.couponSumSign.textColor = GrayH2;
    }
    /** 标记是否可以赠送 0-赠送 1-不赠送 */
    if (couponInfoModel.markGive) {
        [self.giveBtn setTitle:@"已赠送" forState:UIControlStateNormal];
        self.giveBtn.backgroundColor = GrayH1;
        self.giveBtn.enabled = NO;
    }else {
        [self.giveBtn setTitle:@"赠送" forState:UIControlStateNormal];
        self.giveBtn.backgroundColor = ThemeColor;
        self.giveBtn.enabled = YES;
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
    /** 优惠券内容view */
    [self.couponContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.backView.mas_top);
        make.left.equalTo(self.backView.mas_left);
        make.right.equalTo(self.backView.mas_right);
        make.height.mas_equalTo(@(90));
    }];
    /** 优惠金额 */
    [self.couponSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.couponContentView.mas_left).offset(40);
        make.centerY.equalTo(self.couponContentView.mas_centerY);
    }];
    /** 使用条件 */
    [self.useConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.couponContentView.mas_left).offset(35);
        make.top.equalTo(self.couponSumLabel.mas_bottom).offset(3);
    }];
    /** 优惠金额标记 */
    [self.couponSumSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.couponSumLabel.mas_bottom).offset(-3);
        make.right.equalTo(self.couponSumLabel.mas_left).offset(-4);
    }];
    /** 选择使用优惠券 */
    if (self.couponCellType == ChoiceUseCouponStyle) {
        /** 优惠券名称 */
        [self.couponNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.couponContentView.mas_top).offset(26);
            make.left.equalTo(self.couponContentView.mas_left).offset(130);
            make.right.equalTo(self.checkMarkBtn.mas_left).offset(-10);
        }];
        /** 优惠券使用周期 */
        [self.couponTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.couponNameLabel.mas_bottom).offset(15);
            make.left.equalTo(self.couponNameLabel.mas_left);
            make.right.equalTo(self.checkMarkBtn.mas_left).offset(-10);
        }];
    }else if (self.couponCellType == ChoiceGrantCouponStyle) { /** 选择发放优惠券 */
        /** 优惠券名称 */
        [self.couponNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.couponContentView.mas_top).offset(26);
            make.left.equalTo(self.couponContentView.mas_left).offset(130);
            make.right.equalTo(self.giveBtn.mas_left).offset(-10);
        }];
        /** 优惠券使用周期 */
        [self.couponTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.couponNameLabel.mas_bottom).offset(15);
            make.left.equalTo(self.couponNameLabel.mas_left);
            make.right.equalTo(self.giveBtn.mas_left).offset(-10);
        }];
    }
    /** 选中标记 */
    [self.checkMarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.couponContentView.mas_centerY);
        make.right.equalTo(self.couponContentView.mas_right).offset(-10);
    }];
    /** 赠送／以赠送按钮 */
    [self.giveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.couponContentView.mas_centerY);
        make.right.equalTo(self.couponContentView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 24));
    }];
    /** 优惠券信息View */
    [self.couponInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponContentView.mas_bottom);
        make.left.equalTo(self.backView.mas_left);
        make.right.equalTo(self.backView.mas_right);
        make.height.mas_equalTo(@(35));
    }];
}


@end
