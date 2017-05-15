//
//  ShowDataView.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShowDataView.h"

@interface ShowDataView ()


@end

@implementation ShowDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self showDataLayoutView];
    }
    return self;
}

- (void)showDataLayoutView {
    /** 查看订单 */
    self.showDataView = [[UsedCellView alloc] init];
    self.showDataView.usedCellTypeChoice = DescribeImageTextHorizontalLayout;
    self.showDataView.describeImage.image = [UIImage imageNamed:@"home_page_update"];
    self.showDataView.describeImageSize = CGSizeMake(18, 15);
    self.showDataView.cellLabel.text = @"今日实时数据";
    self.showDataView.cellLabel.font = FifteenTypeface;
    self.showDataView.cellLabel.textColor = GrayH1;
    self.showDataView.viceLabel.text = @"登陆后可查看";
    self.showDataView.describeLabel.text = @"刷新";
    self.showDataView.describeLabel.textColor = ThemeColor;
    self.showDataView.isSplistLine = YES;
    self.showDataView.isArrow = YES;
    self.showDataView.isCellImage = YES;
    [self addSubview:self.showDataView];
    /** 消费人数 */
    self.csmPleNumView = [[TwoWordsLabel alloc] init];
    self.csmPleNumView.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.csmPleNumView.viceLabel.text = @"消费人次";
    self.csmPleNumView.viceLabel.textColor = GrayH2;
    self.csmPleNumView.viceLabel.font = FifteenTypeface;
    self.csmPleNumView.backgroundColor = WhiteColor;
    self.csmPleNumView.mainLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold" size:(36.0)];
    self.csmPleNumView.mainLabel.text = @"0";
    self.csmPleNumView.mainLabel.textColor = Black;
    [self addSubview:self.csmPleNumView];
    /** 营业额 */
    self.turnoverView = [[TwoWordsLabel alloc] init];
    self.turnoverView.twoWordsShowStyle = TextVerticallyLayoutAndSuperCenter;
    self.turnoverView.viceLabel.text = @"营业额(元)";
    self.turnoverView.viceLabel.textColor = GrayH2;
    self.turnoverView.viceLabel.font = FifteenTypeface;
    self.turnoverView.backgroundColor = WhiteColor;
    self.turnoverView.mainLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold" size:(36.0)];
    self.turnoverView.mainLabel.text = @"0";
    self.turnoverView.mainLabel.textColor = Black;
    [self addSubview:self.turnoverView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 查看订单 */
    [self.showDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@50);
    }];
    /** 消费人数 */
    [self.csmPleNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
    }];
    /** 营业额 */
    [self.turnoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.csmPleNumView.mas_right).offset(0.5);
        make.right.equalTo(self.mas_right);
    }];
    /** 消费人数,营业额 */
    [@[self.csmPleNumView, self.turnoverView] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.showDataView.mas_bottom).offset(0.5);
        make.width.equalTo(self.csmPleNumView.mas_width);
        make.height.mas_equalTo(@90);
    }];
    /** 消费人数,营业额 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.csmPleNumView.mas_bottom);
    }];
}


@end
