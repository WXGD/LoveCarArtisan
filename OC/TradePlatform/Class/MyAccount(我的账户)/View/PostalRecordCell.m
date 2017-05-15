//
//  PostalRecordCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PostalRecordCell.h"

@interface PostalRecordCell ()

/** 提现记录背景view */
@property (strong, nonatomic) UsedCellView *recordBackView;
/** 提现金额标题 */
@property (strong, nonatomic) UILabel *postalMoneyTitle;
/** 提现金额Label */
@property (strong, nonatomic) UILabel *postalMoneyLabel;
/** 申请时间标题 */
@property (strong, nonatomic) UILabel *applyTimeTitle;
/** 申请时间Label */
@property (strong, nonatomic) UILabel *applyTimeLabel;

@end

@implementation PostalRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** 提现记录背景view */
        self.recordBackView = [[UsedCellView alloc] init];
        self.recordBackView.describeLabel.text = @"状态";
        self.recordBackView.describeLabel.font = TwelveTypeface;
        self.recordBackView.describeLabel.textColor = ThemeColor;
        self.recordBackView.isCellImage = YES;
        self.recordBackView.isCellBtn = YES;
        self.recordBackView.dividingLineChoice = DividingLineFullScreenLayout;
        [self.contentView addSubview:self.recordBackView];
        /** 提现金额标题 */
        self.postalMoneyTitle = [[UILabel alloc] init];
        self.postalMoneyTitle.text = @"提现金额";
        self.postalMoneyTitle.textColor = GrayH1;
        self.postalMoneyTitle.font = FourteenTypeface;
        [self.recordBackView addSubview:self.postalMoneyTitle];
        /** 提现金额Label */
        self.postalMoneyLabel = [[UILabel alloc] init];
        self.postalMoneyLabel.text = @"1000";
        self.postalMoneyLabel.textColor = Black;
        self.postalMoneyLabel.font = FourteenTypeface;
        [self.recordBackView addSubview:self.postalMoneyLabel];
        /** 申请时间标题 */
        self.applyTimeTitle = [[UILabel alloc] init];
        self.applyTimeTitle.text = @"申请时间";
        self.applyTimeTitle.textColor = GrayH1;
        self.applyTimeTitle.font = FourteenTypeface;
        [self.recordBackView addSubview:self.applyTimeTitle];
        /** 申请时间Label */
        self.applyTimeLabel = [[UILabel alloc] init];
        self.applyTimeLabel.text = @"2001=11=22 15:46:56";
        self.applyTimeLabel.textColor = Black;
        self.applyTimeLabel.font = FourteenTypeface;
        [self.recordBackView addSubview:self.applyTimeLabel];
    }
    return self;
}
-(void)setWithdrawRecordModel:(WithdrawRecordModel *)withdrawRecordModel{
    _withdrawRecordModel = withdrawRecordModel;
    self.postalMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",withdrawRecordModel.withdraw_money];
    self.applyTimeLabel.text = withdrawRecordModel.create_time;
    if (withdrawRecordModel.withdraw_status == 1) {
        self.recordBackView.describeLabel.text = @"已结算";
        self.recordBackView.describeLabel.textColor = ThemeColor;
    }else if (withdrawRecordModel.withdraw_status == 2) {
        self.recordBackView.describeLabel.text = @"未结算";
        self.recordBackView.describeLabel.textColor = HEXSTR_RGB(@"498dff");
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 提现记录背景view */
    [self.recordBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    /** 提现金额标题 */
    [self.postalMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.recordBackView.mas_left).offset(16);
        make.top.equalTo(self.recordBackView.mas_top).offset(18);
    }];
    /** 提现金额Label */
    [self.postalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.postalMoneyTitle.mas_left);
        make.top.equalTo(self.postalMoneyTitle.mas_bottom).offset(15);
    }];
    /** 申请时间标题 */
    [self.applyTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.applyTimeLabel.mas_left);
        make.centerY.equalTo(self.postalMoneyTitle.mas_centerY);
    }];
    /** 申请时间Label */
    [self.applyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.recordBackView.mas_centerX);
        make.centerY.equalTo(self.postalMoneyLabel.mas_centerY);
    }];
}

@end
