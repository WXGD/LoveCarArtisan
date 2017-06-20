//
//  CouponContentView.m
//  TradePlatform
//
//  Created by 弓杰 on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponContentView.h"
// view
#import "CouponContentCell.h"

@interface CouponContentView ()<UITableViewDelegate, UITableViewDataSource>

/** 内容table */
@property (strong, nonatomic) UITableView *contentTable;
/** 按钮背景 */
@property (strong, nonatomic) UIView *contentBackView;
/** 按钮 */
@property (strong, nonatomic) UIButton *addCouponBtn;

@end

@implementation CouponContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self couponContentLayoutView];
    }
    return self;
}

- (void)couponContentLayoutView {
    /** 内容table */
    self.contentTable = [[UITableView alloc] init];
    self.contentTable.delegate = self;
    self.contentTable.dataSource = self;
    self.contentTable.rowHeight = 150;
    self.contentTable.backgroundColor = CLEARCOLOR;
    [self addSubview:self.contentTable];
    /** 按钮背景 */
    self.contentBackView = [[UIView alloc] init];
    self.contentBackView.backgroundColor = WhiteColor;
    [self addSubview:self.contentBackView];
    /** 按钮 */
    self.addCouponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addCouponBtn.backgroundColor = ThemeColor;
    self.addCouponBtn.layer.cornerRadius = 2;
    self.addCouponBtn.clipsToBounds = YES;
    [self.addCouponBtn setTitle:@"确认查询" forState:UIControlStateNormal];
    [self.addCouponBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.addCouponBtn.titleLabel.font = SixteenTypeface;
    self.addCouponBtn.layer.masksToBounds = YES;
    self.addCouponBtn.layer.cornerRadius = 2;
    [self.contentBackView addSubview:self.addCouponBtn];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 内容table */
    [self.contentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.contentBackView.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 按钮背景 */
    [self.contentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 按钮 */
    [self.addCouponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentBackView.mas_top).offset(5);
        make.left.equalTo(self.contentBackView.mas_left).offset(16);
        make.bottom.equalTo(self.contentBackView.mas_bottom).offset(-5);
        make.right.equalTo(self.contentBackView.mas_right).offset(-16);
    }];
}


#pragma mark - tableviewDegate、DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentCell";
    CouponContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CouponContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
