//
//  CouponContentView.m
//  TradePlatform
//
//  Created by 弓杰 on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponContentView.h"

@interface CouponContentView ()<UITableViewDelegate, UITableViewDataSource>

/** 按钮背景 */
@property (strong, nonatomic) UIView *buttonBackView;

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
    self.contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.contentTable];
    /** 按钮背景 */
    self.buttonBackView = [[UIView alloc] init];
    self.buttonBackView.backgroundColor = WhiteColor;
    [self addSubview:self.buttonBackView];
    /** 新增优惠劵 */
    self.addCouponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addCouponBtn.backgroundColor = ThemeColor;
    self.addCouponBtn.layer.cornerRadius = 2;
    self.addCouponBtn.clipsToBounds = YES;
    [self.addCouponBtn setTitle:@"新增优惠劵" forState:UIControlStateNormal];
    [self.addCouponBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.addCouponBtn.titleLabel.font = SixteenTypeface;
    self.addCouponBtn.layer.masksToBounds = YES;
    self.addCouponBtn.layer.cornerRadius = 2;
    [self.buttonBackView addSubview:self.addCouponBtn];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 内容table */
    [self.contentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.buttonBackView.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 按钮背景 */
    [self.buttonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 按钮 */
    [self.addCouponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.buttonBackView.mas_top).offset(5);
        make.left.equalTo(self.buttonBackView.mas_left).offset(16);
        make.bottom.equalTo(self.buttonBackView.mas_bottom).offset(-5);
        make.right.equalTo(self.buttonBackView.mas_right).offset(-16);
    }];
}


#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.couponArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"contentCell";
    CouponContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CouponContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    /** 优惠劵模型 */
    cell.couponGoverModel = [self.couponArray objectAtIndex:indexPath.row];
    /** 优惠劵状态 */
    cell.couponState = self.couponState;
    /** 发劵记录 */
    cell.grantRecordBtn.tag = indexPath.row;
    [cell.grantRecordBtn addTarget:self action:@selector(grantRecordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 禁用 */
    cell.disableBtn.tag = indexPath.row;
    [cell.disableBtn addTarget:self action:@selector(disableBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 发劵 */
    cell.grantBtn.tag = indexPath.row;
    [cell.grantBtn addTarget:self action:@selector(grantBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 启用 */
    cell.enableBtn.tag = indexPath.row;
    [cell.enableBtn addTarget:self action:@selector(enableBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
/** 编辑优惠劵 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(editCoupon:)]) {
        [_delegate editCoupon:indexPath];
    }
}
/** 发劵记录 */
- (void)grantRecordBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(grantRecordAction:)]) {
        [_delegate grantRecordAction:button];
    }
}
/** 禁用 */
- (void)disableBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(disableAction:)]) {
        [_delegate disableAction:button];
    }
}
/** 发劵 */
- (void)grantBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(grantAction:)]) {
        [_delegate grantAction:button];
    }
}
/** 启用 */
- (void)enableBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(enableAction:)]) {
        [_delegate enableAction:button];
    }
}

@end
