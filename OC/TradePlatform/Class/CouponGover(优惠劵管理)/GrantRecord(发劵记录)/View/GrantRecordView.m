//
//  GrantRecordView.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GrantRecordView.h"

@interface GrantRecordView ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

/** 发劵记录标题 */
@property (strong, nonatomic) CustomCell *grantRecordTitle;

@end

@implementation GrantRecordView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self grantRecordLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)grantRecordLayoutView {
    /** 优惠劵信息view */
    self.couponInfoView = [[CouponInfoView alloc] init];
    [self.couponInfoView.button setHidden:YES];
    [self addSubview:self.couponInfoView];
    /** 优惠劵搜索view */
    self.couponSearchView = [[SearchView alloc] init];
    self.couponSearchView.searchTF.delegate = self;
    self.couponSearchView.isSearch = YES;
    self.couponSearchView.isViewBtn = YES;
    self.couponSearchView.searchType = OrdinaryViewLayout;
    self.couponSearchView.searchTF.textColor = Black;
    self.couponSearchView.searchTF.placeholder = @"手机号 车牌号";
    [self.couponSearchView.searchTF setValue:NotClick  forKeyPath:@"_placeholderLabel.textColor"];
    self.couponSearchView.searchTF.tintColor = ThemeColor;
    self.couponSearchView.searchView.backgroundColor = WhiteColor;
    self.couponSearchView.searchMagnifierImage.image = [UIImage imageNamed:@"nav_search_gray"];
    [self addSubview:self.couponSearchView];
    /** 发劵记录标题 */
    self.grantRecordTitle = [[CustomCell alloc] init];
    self.grantRecordTitle.lineStyle = FullScreenLayout;
    self.grantRecordTitle.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.grantRecordTitle.mainLabel.text = @"发劵记录";
    self.grantRecordTitle.mainLabel.textColor = GrayH1;
    [self addSubview:self.grantRecordTitle];
    /** 发劵记录table */
    self.grantRecordTable = [[UITableView alloc] init];
    self.grantRecordTable.delegate = self;
    self.grantRecordTable.dataSource = self;
    self.grantRecordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.grantRecordTable.backgroundColor = CLEARCOLOR;
    self.grantRecordTable.rowHeight = 100.3;
    [self addSubview:self.grantRecordTable];
    UITapGestureRecognizer *grantRecordTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(grantRecordTapAction)];
    [self.grantRecordTable addGestureRecognizer:grantRecordTap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 优惠劵信息view */
    [self.couponInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@90);
    }];
    /** 优惠劵搜索view */
    [self.couponSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couponInfoView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@30);
    }];
    /** 发劵记录标题 */
    [self.grantRecordTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couponSearchView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 发劵记录table */
    [self.grantRecordTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grantRecordTitle.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.grantRecordArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"grantRecordCell";
    GrantRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GrantRecordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.grantRecordModel = [self.grantRecordArray objectAtIndex:indexPath.row];
    /** 作废按钮 */
    cell.invalidBtn.tag = indexPath.row;
    [cell.invalidBtn addTarget:self action:@selector(invalidBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


/** 作废按钮 */
- (void)invalidBtnAction:(UIButton *)button {
    // 获取优惠卷模型
    GrantRecordModel *grantRecordModel = [self.grantRecordArray objectAtIndex:button.tag];
    // 获取商家模型
    MerchantInfoModel *merchantInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    /*/index.php?c=coupon_grant_record&a=del&v=1
     provider_id 	int 	是 	服务商id
     coupon_grant_record_id 	int 	是 	用户优惠券id       */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = merchantInfo.provider_id; // 服务id
    params[@"coupon_grant_record_id"] = [NSString stringWithFormat:@"%ld", grantRecordModel.coupon_grant_record_id]; // 用户优惠券id
    [GrantRecordModel invalidUserCoupon:params success:^{
        // 马上进入刷新状态
        [self.grantRecordTable.mj_header beginRefreshing];
    }];
}


#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self endEditing:YES];
}
// 轻拍手势
- (void)grantRecordTapAction {
    [self endEditing:YES];
}


@end
