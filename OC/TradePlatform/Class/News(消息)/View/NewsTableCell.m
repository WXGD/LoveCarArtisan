//
//  NewsTableCell.m
//  TradePlatform
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsTableCell.h"

@interface NewsTableCell ()

/** 消息时间 */
@property (strong, nonatomic) UILabel *messageTimerLabel;
/** 消息具体view */
@property (strong, nonatomic) UIView *messageSpecificView;
/** 消息类型标志 */
@property (strong, nonatomic) UIImageView *messageTypeFlagImage;
/** 消息名称 */
@property (strong, nonatomic) UILabel *messageNameLabel;
/** 消息内容 */
@property (strong, nonatomic) UILabel *messageContentLabel;
/** 消息操作 */
@property (strong, nonatomic) UILabel *messageOperationLabel;

@end

@implementation NewsTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        [self newsTableCellLayoutView];
    }
    return self;
}

- (void)newsTableCellLayoutView {
    /** 消息时间 */
    self.messageTimerLabel = [[UILabel alloc] init];
    self.messageTimerLabel.text = @"2012-03-19 23:00:00";
    self.messageTimerLabel.backgroundColor = RGB(214, 214, 214);
    self.messageTimerLabel.font = TwelveTypeface;
    self.messageTimerLabel.textColor = WhiteColor;
    self.messageTimerLabel.layer.masksToBounds = YES;
    self.messageTimerLabel.layer.cornerRadius = 2;
    self.messageTimerLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.messageTimerLabel];
    /** 消息具体view */
    self.messageSpecificView = [[UIView alloc] init];
    self.messageSpecificView.backgroundColor = WhiteColor;
    self.messageSpecificView.layer.masksToBounds = YES;
    self.messageSpecificView.layer.cornerRadius = 2;
    self.messageSpecificView.layer.borderWidth = 1;
    self.messageSpecificView.layer.borderColor = DividingLine.CGColor;
    [self.contentView addSubview:self.messageSpecificView];
    /** 消息类型标志 */
    self.messageTypeFlagImage = [[UIImageView alloc] init];
    self.messageTypeFlagImage.image = [UIImage imageNamed:@"news_settlement"];
    [self.messageSpecificView addSubview:self.messageTypeFlagImage];
    /** 消息名称 */
    self.messageNameLabel = [[UILabel alloc] init];
    self.messageNameLabel.text = @"消息名称";
    self.messageNameLabel.font = SixteenTypeface;
    self.messageNameLabel.textColor = Black;
    [self.messageSpecificView addSubview:self.messageNameLabel];
    /** 消息内容 */
    self.messageContentLabel = [[UILabel alloc] init];
    self.messageContentLabel.text = @"消息内容";
    self.messageContentLabel.numberOfLines = 0;
    self.messageContentLabel.font = TwelveTypeface;
    self.messageContentLabel.textColor = GrayH1;
    [self.messageSpecificView addSubview:self.messageContentLabel];
    /** 消息操作 */
    self.messageOperationLabel = [[UILabel alloc] init];
    self.messageOperationLabel.text = @"购买正式版";
    self.messageOperationLabel.font = TwelveTypeface;
    self.messageOperationLabel.textColor = HEXSTR_RGB(@"ff7043");
    [self.messageSpecificView addSubview:self.messageOperationLabel];
}


- (void)setNewsModel:(NewsModel *)newsModel {
    _newsModel = newsModel;
    /** 消息时间 */
    self.messageTimerLabel.text = newsModel.create_time;
    /** 消息类型标志 处理状态 0-未读 1-已读 */
    if (newsModel.status == 0) {
        self.messageTypeFlagImage.image = [UIImage imageNamed:@"news_settlement"];
    }else {
        self.messageTypeFlagImage.image = [UIImage imageNamed:@"news_renew"];
    }
    /** 消息名称 */
    self.messageNameLabel.text = newsModel.title;
    /** 消息内容 */
    self.messageContentLabel.text = newsModel.content;
    /** 消息操作 */
    [self.messageOperationLabel setHidden:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 消息时间 */
    [self.messageTimerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@139);
    }];

    /** 消息具体view */
    [self.messageSpecificView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.messageTimerLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    /** 消息类型标志 */
    [self.messageTypeFlagImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.messageSpecificView.mas_top).offset(24);
        make.left.equalTo(self.messageSpecificView.mas_left).offset(16);
    }];
    /** 消息名称 */
    [self.messageNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.messageTypeFlagImage.mas_centerY);
        make.left.equalTo(self.messageTypeFlagImage.mas_right).offset(10);
    }];
    /** 消息内容 */
    [self.messageContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.messageTypeFlagImage.mas_bottom).offset(10);
        make.left.equalTo(self.messageSpecificView.mas_left).offset(16);
        make.right.equalTo(self.messageSpecificView.mas_right).offset(-16);
    }];
    /** 消息操作 */
    [self.messageOperationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.messageContentLabel.mas_bottom).offset(10);
        make.right.equalTo(self.messageSpecificView.mas_right).offset(-16);
    }];
}




@end
