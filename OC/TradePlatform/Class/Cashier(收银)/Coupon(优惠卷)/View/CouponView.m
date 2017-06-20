//
//  CouponView.m
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponView.h"
// view
#import "CouponViewCell.h"

@interface CouponView ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

/** 优惠券选项卡view */
@property (strong, nonatomic) UIView *couponTabView;
/** 选中按钮 */
@property (strong, nonatomic) UIButton *checkBtn;
/** 优惠券标记view */
@property (strong, nonatomic) UIView *couponSignView;
/** 优惠券项目ScrollView */
@property (strong, nonatomic) UIScrollView *couponTabScorllView;
/** 优惠券项目填充背景View */
@property (strong, nonatomic) UIView *couponTabBackView;
/** 确认选择view */
@property (strong, nonatomic) UIView *confirmChoiceView;

@end

@implementation CouponView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self couponLayoutView];
    }
    return self;
}

#pragma mark - 按钮点击方法
// tab按钮选择
- (void)usedCarTabBtnAction:(UIButton *)button {
    // 回收键盘
    [self endEditing:YES];
    self.checkBtn.selected = !self.checkBtn.selected;
    self.checkBtn = button;
    self.checkBtn.selected = !self.checkBtn.selected;
    /** 选中标记 */
    // 告诉self约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.couponTabScorllView.contentOffset = CGPointMake(ScreenW * (self.checkBtn.tag - 6010), 0);
    }];
    if (_delegate && [_delegate respondsToSelector:@selector(couponTabChoiceAction:)]) {
        [_delegate couponTabChoiceAction:button];
    }
}

#pragma mark - scrollview滚动代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![NSStringFromClass([scrollView class]) isEqualToString:@"UITableView"]) {
        UIButton *checkBtn = (UIButton *)[self viewWithTag: scrollView.contentOffset.x / ScreenW + 6010];
        [self usedCarTabBtnAction:checkBtn];
    }
}

#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.usableCouponTable]) {
        return self.usableCouponArray.count;
    }else {
        return self.noUsableCouponArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"couponListCell";
    CouponViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CouponViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.couponCellType = ChoiceUseCouponStyle;
    if ([tableView isEqual:self.usableCouponTable]) {
        cell.couponInfoModel = [self.usableCouponArray objectAtIndex:indexPath.row];
    }else {
        cell.couponInfoModel = [self.noUsableCouponArray objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:self.usableCouponTable]) {
        CouponInfoModel *couponInfoModel = [self.usableCouponArray objectAtIndex:indexPath.row];
        couponInfoModel.checkMark = !couponInfoModel.checkMark;
        [self.usableCouponTable reloadData];
    }else {
    }
}



#pragma mark - view布局
- (void)couponLayoutView {
    /** 确认选择view */
    self.confirmChoiceView = [[UIView alloc] init];
    self.confirmChoiceView.backgroundColor = WhiteColor;
    [self addSubview:self.confirmChoiceView];
    /** 确认选择按钮 */
    self.confirmChoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmChoiceBtn.backgroundColor = ThemeColor;
    self.confirmChoiceBtn.layer.cornerRadius = 2;
    self.confirmChoiceBtn.clipsToBounds = YES;
    [self.confirmChoiceBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmChoiceBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.confirmChoiceBtn.titleLabel.font = SixteenTypeface;
    self.confirmChoiceBtn.layer.masksToBounds = YES;
    self.confirmChoiceBtn.layer.cornerRadius = 2;
    [self.confirmChoiceView addSubview:self.confirmChoiceBtn];
    /** 优惠券选项卡view */
    self.couponTabView = [[UIView alloc] init];
    self.couponTabView.backgroundColor = WhiteColor;
    [self addSubview:self.couponTabView];
    /** 可用优惠券 */
    self.usableCouponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.usableCouponBtn setTitle:@"可用优惠券" forState:UIControlStateNormal];
    self.usableCouponBtn.titleLabel.font = FourteenTypeface;
    [self.usableCouponBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.usableCouponBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [self.usableCouponBtn addTarget:self action:@selector(usedCarTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.usableCouponBtn.tag = 6010;
    [self.couponTabView addSubview:self.usableCouponBtn];
    self.checkBtn = self.usableCouponBtn;
    self.usableCouponBtn.selected = YES;
    /** 不可用优惠券 */
    self.noUsableCouponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.noUsableCouponBtn setTitle:@"不可用优惠券" forState:UIControlStateNormal];
    self.noUsableCouponBtn.titleLabel.font = FourteenTypeface;
    [self.noUsableCouponBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.noUsableCouponBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [self.noUsableCouponBtn addTarget:self action:@selector(usedCarTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.noUsableCouponBtn.tag = 6011;
    [self.couponTabView addSubview:self.noUsableCouponBtn];
    /** 优惠券标记view */
    self.couponSignView = [[UIView alloc] init];
    self.couponSignView.backgroundColor = ThemeColor;
    [self.couponTabView addSubview:self.couponSignView];
    /** 优惠券项目ScrollView */
    self.couponTabScorllView = [[UIScrollView alloc] init];
    self.couponTabScorllView.pagingEnabled = YES;
    self.couponTabScorllView.showsHorizontalScrollIndicator = NO;
    self.couponTabScorllView.delegate = self;
    [self addSubview:self.couponTabScorllView];
    /** 优惠券项目填充背景View */
    self.couponTabBackView = [[UIView alloc] init];
    [self.couponTabScorllView addSubview:self.couponTabBackView];
    /** 可用优惠券Table */
    self.usableCouponTable = [[UITableView alloc] init];
    self.usableCouponTable.delegate = self;
    self.usableCouponTable.dataSource = self;
    self.usableCouponTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.usableCouponTable.backgroundColor = CLEARCOLOR;
    self.usableCouponTable.rowHeight = 135;
    [self.couponTabBackView addSubview:self.usableCouponTable];
    /** 不可用优惠券Table */
    self.noUsableCouponTable = [[UITableView alloc] init];
    self.noUsableCouponTable.delegate = self;
    self.noUsableCouponTable.dataSource = self;
    self.noUsableCouponTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.noUsableCouponTable.backgroundColor = CLEARCOLOR;
    self.noUsableCouponTable.rowHeight = 135;
    [self.couponTabBackView addSubview:self.noUsableCouponTable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 确认选择view */
    [self.confirmChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 确认选择按钮 */
    [self.confirmChoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.confirmChoiceView.mas_top).offset(5);
        make.left.equalTo(self.confirmChoiceView.mas_left).offset(16);
        make.bottom.equalTo(self.confirmChoiceView.mas_bottom).offset(-5);
        make.right.equalTo(self.confirmChoiceView.mas_right).offset(-16);
    }];
    /** 优惠券选项卡view */
    [self.couponTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@44);
    }];
    /** 可用优惠券 */
    [self.usableCouponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponTabView.mas_top);
        make.bottom.equalTo(self.couponTabView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_centerX);
    }];
    /** 不可用优惠券 */
    [self.noUsableCouponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponTabView.mas_top);
        make.bottom.equalTo(self.couponTabView.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_centerX);
    }];
    /** 优惠券标记view */
    [self.couponSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.couponTabView.mas_bottom);
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake((ScreenW / 2 - 32), 2));
    }];
    /** 优惠券项目ScrollView */
    [self.couponTabScorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponTabView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.confirmChoiceView.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 优惠券项目填充背景View */
    [self.couponTabBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponTabScorllView.mas_top);
        make.left.equalTo(self.couponTabScorllView.mas_left);
        make.bottom.equalTo(self.couponTabScorllView.mas_bottom);
        make.right.equalTo(self.couponTabScorllView.mas_right);
        make.height.equalTo(self.couponTabScorllView.mas_height);
        make.width.mas_equalTo(@(ScreenW * 2));
    }];
    /** 可用优惠券Table */
    [self.usableCouponTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponTabBackView.mas_top);
        make.left.equalTo(self.couponTabBackView.mas_left);
        make.bottom.equalTo(self.couponTabBackView.mas_bottom);
        make.right.equalTo(self.couponTabBackView.mas_centerX);
    }];
    /** 不可用优惠券Table */
    [self.noUsableCouponTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.couponTabBackView.mas_top);
        make.left.equalTo(self.couponTabBackView.mas_centerX);
        make.bottom.equalTo(self.couponTabBackView.mas_bottom);
        make.right.equalTo(self.couponTabBackView.mas_right);
    }];
}

- (void)updateConstraints {
    @weakify(self)
    /** 优惠券标记view */
    [self.couponSignView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake((ScreenW / 2 - 32), 2));
        make.bottom.equalTo(self.couponTabView.mas_bottom);
    }];
    [super updateConstraints];
}


@end
