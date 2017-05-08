//
//  RecordTableCell.m
//  TradePlatform
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RecordTableCell.h"
#import "TwoWordsLabel.h"

@interface RecordTableCell ()

/** view */
@property (strong, nonatomic) UIView *cellView;
/** 申请时间 */
@property (strong, nonatomic) TwoWordsLabel *applicationTimeLabel;
/** 处理时间 */
@property (strong, nonatomic) TwoWordsLabel *processingTimeLabel;
/** 提现金额 */
@property (strong, nonatomic) UILabel *theMoneyLabel;
/** 提现状态 */
@property (strong, nonatomic) UILabel *theStateLabel;


@end

@implementation RecordTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** view */
        self.cellView = [[UIView alloc] init];
        self.cellView.backgroundColor = WhiteColor;
        [self addSubview:self.cellView];
        /** 申请时间 */
        self.applicationTimeLabel = [[TwoWordsLabel alloc] init];
        self.applicationTimeLabel.twoWordsShowStyle = TextHorizontalLayoutAndSuperCenter;
        self.applicationTimeLabel.mainLabel.text = @"申请时间：";
        self.applicationTimeLabel.mainLabel.font = TwelveTypeface;
        self.applicationTimeLabel.viceLabel.font = TwelveTypeface;
        self.applicationTimeLabel.mainLabel.textColor = GrayH1;
        self.applicationTimeLabel.viceLabel.textColor = GrayH2;
        [self.cellView addSubview:self.applicationTimeLabel];
        /** 处理时间 */
        self.processingTimeLabel = [[TwoWordsLabel alloc] init];
        self.processingTimeLabel.twoWordsShowStyle = TextHorizontalLayoutAndSuperCenter;
        self.processingTimeLabel.mainLabel.text = @"处理时间：";
        self.processingTimeLabel.mainLabel.font = TwelveTypeface;
        self.processingTimeLabel.viceLabel.font = TwelveTypeface;
        self.processingTimeLabel.mainLabel.textColor = GrayH1;
        self.processingTimeLabel.viceLabel.textColor = GrayH2;
        [self.cellView addSubview:self.processingTimeLabel];
        /** 提现金额 */
        self.theMoneyLabel = [[UILabel alloc] init];
        self.theMoneyLabel.textColor = GrayH1;
        self.theMoneyLabel.font = TwelveTypeface;
        [self.cellView addSubview:self.theMoneyLabel];
        /** 提现状态 */
        self.theStateLabel = [[UILabel alloc] init];
        self.theStateLabel.textColor = GrayH1;
        self.theStateLabel.font = TwelveTypeface;
        [self.cellView addSubview:self.theStateLabel];
    }
    return self;
}

- (void)setWithdrawRecordModel:(WithdrawRecordModel *)withdrawRecordModel {
    _withdrawRecordModel = withdrawRecordModel;
    /** 申请时间 */
    self.applicationTimeLabel.viceLabel.text = withdrawRecordModel.create_time;
    /** 处理时间 */
    self.processingTimeLabel.viceLabel.text = withdrawRecordModel.withdraw_time;
    /** 提现金额 */
    self.theMoneyLabel.text = [NSString stringWithFormat:@"%.2f元", withdrawRecordModel.withdraw_money];
    /** 提现状态  1-已结算 2 -未结算 */
    if (withdrawRecordModel.withdraw_status == 1) {
        self.theStateLabel.text = @"已处理";
        self.theStateLabel.textColor = ThemeColor;
    }else if (withdrawRecordModel.withdraw_status == 2) {
        self.theStateLabel.text = @"处理中";
        self.theStateLabel.textColor = HEXSTR_RGB(@"#007dc9");
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** view */
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
    }];
    /** 申请时间 */
    [self.applicationTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cellView.mas_top).offset(15);
        make.left.equalTo(self.cellView.mas_left).offset(15);
        make.right.equalTo(self.applicationTimeLabel.viceLabel.mas_right);
        make.bottom.equalTo(self.applicationTimeLabel.viceLabel.mas_bottom);
    }];
    /** 处理时间 */
    [self.processingTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.cellView.mas_bottom).offset(-15);
        make.left.equalTo(self.cellView.mas_left).offset(15);
        make.right.equalTo(self.processingTimeLabel.viceLabel.mas_right);
        make.bottom.equalTo(self.processingTimeLabel.viceLabel.mas_bottom);
    }];
    /** 提现金额 */
    [self.theMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cellView.mas_top).offset(15);
        make.right.equalTo(self.cellView.mas_right).offset(-15);
    }];
    /** 提现状态 */
    [self.theStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.cellView.mas_bottom).offset(-15);
        make.right.equalTo(self.cellView.mas_right).offset(-15);
    }];
}

@end
