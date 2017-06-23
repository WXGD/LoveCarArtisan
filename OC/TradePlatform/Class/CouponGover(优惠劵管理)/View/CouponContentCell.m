//
//  CouponContentCell.m
//  TradePlatform
//
//  Created by 弓杰 on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponContentCell.h"
// view
#import "CouponInfoView.h"

@interface CouponContentCell ()

/** 优惠劵信息 */
@property (strong, nonatomic) CouponInfoView *couponInfoView;
/** 操作按钮背景 */
@property (strong, nonatomic) UIView *operationBackView;

@end

@implementation CouponContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** 优惠劵信息 */
        self.couponInfoView = [[CouponInfoView alloc] init];
        [self.contentView addSubview:self.couponInfoView];
        /** 操作按钮背景 */
        self.operationBackView = [[UIView alloc] init];
        self.operationBackView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.operationBackView];
        /** 发劵记录 */
        self.grantRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.grantRecordBtn setTitle:@"发劵记录" forState:UIControlStateNormal];
        [self.grantRecordBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
        self.grantRecordBtn.titleLabel.font = TwelveTypeface;
        self.grantRecordBtn.layer.masksToBounds = YES;
        self.grantRecordBtn.layer.cornerRadius = 2;
        self.grantRecordBtn.layer.borderWidth = 0.5;
        self.grantRecordBtn.layer.borderColor = NotClick.CGColor;
        [self.operationBackView addSubview:self.grantRecordBtn];
        /** 禁用 */
        self.disableBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.disableBtn setTitle:@"禁用" forState:UIControlStateNormal];
        [self.disableBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
        self.disableBtn.titleLabel.font = TwelveTypeface;
        self.disableBtn.layer.masksToBounds = YES;
        self.disableBtn.layer.cornerRadius = 2;
        self.disableBtn.layer.borderWidth = 0.5;
        self.disableBtn.layer.borderColor = NotClick.CGColor;
        [self.operationBackView addSubview:self.disableBtn];
        /** 发劵 */
        self.grantBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.grantBtn setTitle:@"发劵" forState:UIControlStateNormal];
        [self.grantBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        self.grantBtn.titleLabel.font = TwelveTypeface;
        self.grantBtn.layer.masksToBounds = YES;
        self.grantBtn.layer.cornerRadius = 2;
        self.grantBtn.layer.borderWidth = 0.5;
        self.grantBtn.layer.borderColor = ThemeColor.CGColor;
        [self.operationBackView addSubview:self.grantBtn];
        /** 启用 */
        self.enableBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.enableBtn setTitle:@"启用" forState:UIControlStateNormal];
        [self.enableBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        self.enableBtn.titleLabel.font = TwelveTypeface;
        self.enableBtn.layer.masksToBounds = YES;
        self.enableBtn.layer.cornerRadius = 2;
        self.enableBtn.layer.borderWidth = 0.5;
        self.enableBtn.layer.borderColor = ThemeColor.CGColor;
        [self.operationBackView addSubview:self.enableBtn];
    }
    return self;
}

- (void)setCouponGoverModel:(CouponGoverModel *)couponGoverModel {
    _couponGoverModel = couponGoverModel;
    /** 优惠金额 */
    self.couponInfoView.couponSumLabel.text = [NSString stringWithFormat:@"%.2f", couponGoverModel.money];
    /** 使用条件 */
    if (couponGoverModel.full_money == 0) {
        self.couponInfoView.useConditionLabel.text = [NSString stringWithFormat:@"满%.2f可用", couponGoverModel.full_money];
    }
    /** 优惠券名称 */
    self.couponInfoView.couponNameLabel.text = couponGoverModel.name;
    /** 优惠券使用周期 */
    if (couponGoverModel.grant_end_time.length == 0) {
        self.couponInfoView.couponTimeLabel.text = @"不限期";
    }else {
        self.couponInfoView.couponTimeLabel.text = [NSString stringWithFormat:@"限%@至%@使用", couponGoverModel.grant_start_time, couponGoverModel.grant_end_time];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 优惠劵信息 */
    [self.couponInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@90);
    }];
    /** 操作按钮背景 */
    [self.operationBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponInfoView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    
    
    /** cell状态 */
    switch (self.couponState) {
            /** 启用 */
        case EnableState: {
            /** 发劵 */
            [self.grantBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.operationBackView.mas_centerY);
                make.right.equalTo(self.operationBackView.mas_right).offset(-16);
                make.size.mas_equalTo(CGSizeMake(62, 25));
            }];
            /** 禁用 */
            [self.disableBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.operationBackView.mas_centerY);
                make.right.equalTo(self.grantBtn.mas_left).offset(-24);
                make.size.mas_equalTo(CGSizeMake(62, 25));
            }];
            /** 发劵记录 */
            [self.grantRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.operationBackView.mas_centerY);
                make.right.equalTo(self.disableBtn.mas_left).offset(-24);
                make.size.mas_equalTo(CGSizeMake(84, 25));
            }];
            /** 启用 */
            [self.enableBtn setHidden:YES];
            break;
        }
            /** 禁用 */
        case DisableState: {
            /** 发劵 */
            [self.grantBtn setHidden:YES];
            /** 启用 */
            [self.enableBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.operationBackView.mas_centerY);
                make.right.equalTo(self.operationBackView.mas_right).offset(-16);
                make.size.mas_equalTo(CGSizeMake(62, 25));
            }];
            /** 禁用 */
            [self.disableBtn setHidden:YES];
            /** 发劵记录 */
            [self.grantRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.operationBackView.mas_centerY);
                make.right.equalTo(self.enableBtn.mas_left).offset(-24);
                make.size.mas_equalTo(CGSizeMake(84, 25));
            }];
            break;
        }
            /** 过期 */
        case ExpireState: {
            /** 发劵 */
            [self.grantBtn setHidden:YES];
            /** 启用 */
            [self.enableBtn setHidden:YES];
            /** 禁用 */
            [self.disableBtn setHidden:YES];
            /** 发劵记录 */
            [self.grantRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.operationBackView.mas_centerY);
                make.right.equalTo(self.operationBackView.mas_right).offset(-16);
                make.size.mas_equalTo(CGSizeMake(84, 25));
            }];
            break;
        }
        default:
            break;
    }
}

@end
