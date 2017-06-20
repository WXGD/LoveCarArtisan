//
//  CouponContentCell.m
//  TradePlatform
//
//  Created by 弓杰 on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponContentCell.h"

@interface CouponContentCell ()

/** 优惠劵信息 */
@property (strong, nonatomic) CustomCell *couponInfoView;
/** 操作按钮背景 */
@property (strong, nonatomic) UIView *operationBackView;
/** 发劵记录 */
@property (strong, nonatomic) UIButton *fajujilu;
/** 禁用 */
@property (strong, nonatomic) UIButton *jinyong;
/** 发劵 */
@property (strong, nonatomic) UIButton *fajuan;

@end

@implementation CouponContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** 优惠劵信息 */
        self.couponInfoView = [[CustomCell alloc] init];
        self.couponInfoView.lineStyle = NotLine;
        self.couponInfoView.cellStyle = HorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn;
        self.couponInfoView.mainImg.image = [UIImage imageNamed:@"account_current_user"];
        [self.couponInfoView.arrowImg setImage:[UIImage imageNamed:@"right_arrow_white"] forState:UIControlStateNormal];
        self.couponInfoView.backgroundColor = ThemeColor;
        self.couponInfoView.mainLabel.text = @"当前用户";
        self.couponInfoView.mainLabel.textColor = WhiteColor;
        self.couponInfoView.mainLabel.font = EighteenTypefaceBold;
        self.couponInfoView.rightViceLabel.text = @"修改密码";
        self.couponInfoView.rightViceLabel.font = ThirteenTypeface;
        self.couponInfoView.rightViceLabel.textColor = WhiteColor;
        [self.contentView addSubview:self.couponInfoView];
        /** 操作按钮背景 */
        self.operationBackView = [[UIView alloc] init];
        self.operationBackView.backgroundColor = WhiteColor;
        [self.contentView addSubview:self.operationBackView];
        /** 发劵记录 */
        self.fajujilu = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.fajujilu setTitle:@"编辑" forState:UIControlStateNormal];
        [self.fajujilu setTitleColor:GrayH1 forState:UIControlStateNormal];
        self.fajujilu.titleLabel.font = TwelveTypeface;
        self.fajujilu.layer.masksToBounds = YES;
        self.fajujilu.layer.cornerRadius = 2;
        self.fajujilu.layer.borderWidth = 0.5;
        self.fajujilu.layer.borderColor = NotClick.CGColor;
        [self.operationBackView addSubview:self.fajujilu];
        /** 禁用 */
        self.jinyong = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.jinyong setTitle:@"编辑" forState:UIControlStateNormal];
        [self.jinyong setTitleColor:GrayH1 forState:UIControlStateNormal];
        self.jinyong.titleLabel.font = TwelveTypeface;
        self.jinyong.layer.masksToBounds = YES;
        self.jinyong.layer.cornerRadius = 2;
        self.jinyong.layer.borderWidth = 0.5;
        self.jinyong.layer.borderColor = NotClick.CGColor;
        [self.operationBackView addSubview:self.jinyong];
        /** 发劵 */
        self.fajuan = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.fajuan setTitle:@"充值" forState:UIControlStateNormal];
        [self.fajuan setTitleColor:ThemeColor forState:UIControlStateNormal];
        self.fajuan.titleLabel.font = TwelveTypeface;
        self.fajuan.layer.masksToBounds = YES;
        self.fajuan.layer.cornerRadius = 2;
        self.fajuan.layer.borderWidth = 0.5;
        self.fajuan.layer.borderColor = ThemeColor.CGColor;
        [self.operationBackView addSubview:self.fajuan];
    }
    return self;
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
    
    /** 发劵记录 */
    [self.fajujilu mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.operationBackView.mas_centerY);
        make.right.equalTo(self.operationBackView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(62, 22));
    }];
    /** 禁用 */
    [self.jinyong mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.operationBackView.mas_centerY);
        make.right.equalTo(self.fajujilu.mas_left).offset(-24);
        make.size.mas_equalTo(CGSizeMake(62, 22));
    }];
    /** 发劵 */
    [self.fajuan mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.operationBackView.mas_centerY);
        make.right.equalTo(self.jinyong.mas_left).offset(-24);
        make.size.mas_equalTo(CGSizeMake(62, 22));
    }];
}

@end
