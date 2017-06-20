//
//  OrderInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderInfoView.h"
#import "OrderServiceCell.h"

@interface OrderInfoView ()<UITableViewDelegate, UITableViewDataSource>

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *orderInfoScrollView;
/*================== 头部 ================*/
/** 头部背景图片 */
@property (strong, nonatomic) UIImageView *headerBackImage;
/** 头部分割线 */
@property (strong, nonatomic) UIView *headerLineView;
/*================== 客户信息  ================*/
/** 客户信息标题 */
@property (strong, nonatomic) UsedCellView *customerInfoTitle;
/** 客户信息分割线 */
@property (strong, nonatomic) UIView *userInfoLineView;
/*================== 服务详情  ================*/
/** 服务详情标题 */
@property (strong, nonatomic) UsedCellView *serviceInfoTitle;
/** 服务内容分割线 */
@property (strong, nonatomic) UIView *serviceTableLineView;
/** 服务分割线 */
@property (strong, nonatomic) UIView *serviceLineView;
/*================== 订单信息  ================*/
/** 订单信息标题 */
@property (strong, nonatomic) UsedCellView *orderInfoTitleView;
/** 订单信息 */
@property (strong, nonatomic) UIView *orderInfoView;;
/*================== 没有更多内容了  ================*/
/** 没有更多内容 */
@property (strong, nonatomic) UILabel *noMoreContentLabel;

@end

@implementation OrderInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self orderInfoLayoutView];
    }
    return self;
}

// 复制按钮点击
- (void)replicateBtnAction:(UIButton *)button {
    [MBProgressHUD showSuccess:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.orderNum.rightText.text;
}


- (void)orderInfoLayoutView {
    /** 背景scrollview */
    self.orderInfoScrollView = [[UIScrollView alloc] init];
    self.orderInfoScrollView.backgroundColor = VCBackground;
    [self addSubview:self.orderInfoScrollView];
    /** 填充scrollview的view */
    self.orderInfoBackView = [[UIStackView alloc] init];
    self.orderInfoBackView.axis = UILayoutConstraintAxisVertical;
    [self.orderInfoScrollView addSubview:self.orderInfoBackView];
    /**************************** 头部信息 *******************************/
    /** 头部背景图片 */
    self.headerBackImage = [[UIImageView alloc] init];
    self.headerBackImage.image = [UIImage imageNamed:@"header_choice_back"];
    self.headerBackImage.userInteractionEnabled = YES;
    [self.orderInfoBackView addArrangedSubview:self.headerBackImage];
    /** 状态 */
    self.orderType = [[UILabel alloc] init];
    self.orderType.text = @"状态";
    self.orderType.font = TwentyFourTypefaceBold;
    self.orderType.textColor = WhiteColor;
    [self.headerBackImage addSubview:self.orderType];
    /** 订单号 */
    self.orderNum = [[leftRigText alloc] init];
    self.orderNum.leftText.text = @"订单号：";
    self.orderNum.leftText.font = ThirteenTypeface;
    self.orderNum.leftText.textColor = RGBA(255, 255, 255, 0.8);
    self.orderNum.rightText.font = ThirteenTypeface;
    self.orderNum.rightText.textColor = RGBA(255, 255, 255, 0.8);
    [self.headerBackImage addSubview:self.orderNum];
    /** 复制 */
    self.replicateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.replicateBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.replicateBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.replicateBtn.titleLabel.font = ElevenTypeface;
    self.replicateBtn.layer.masksToBounds = YES;
    self.replicateBtn.layer.cornerRadius = 2;
    self.replicateBtn.layer.borderWidth = 0.5;
    self.replicateBtn.layer.borderColor = WhiteColor.CGColor;
    [self.replicateBtn addTarget:self action:@selector(replicateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerBackImage addSubview:self.replicateBtn];
    /** 头部分割线 */
    self.headerLineView = [[UIView alloc] init];
    [self.orderInfoBackView addArrangedSubview:self.headerLineView];
    /**************************** 客户信息标题 *******************************/
    /** 客户信息标题 */
    self.customerInfoTitle = [[UsedCellView alloc] init];
    self.customerInfoTitle.cellLabel.text = @"用户信息";
    self.customerInfoTitle.cellLabel.font = FifteenTypeface;
    self.customerInfoTitle.cellLabel.textColor = ThemeColor;
    self.customerInfoTitle.isArrow = YES;
    self.customerInfoTitle.isCellImage = YES;
    self.customerInfoTitle.dividingLineChoice = DividingLineFullScreenLayout;
    [self.orderInfoBackView addArrangedSubview:self.customerInfoTitle];
    /** 用户信息view */
    self.userInfo = [[UsedCellView alloc] init];
    self.userInfo.usedCellTypeChoice = BigPictureVerticallyLayout;
    self.userInfo.cellLabel.font = FifteenTypeface;
    self.userInfo.viceLabel.textColor = GrayH1;
    self.userInfo.isCellImage = YES;
    self.userInfo.dividingLineChoice = DividingLineFullScreenLayout;
    [self.orderInfoBackView addArrangedSubview:self.userInfo];
    /** 用户删除提示 */
    self.delUserSign = [[UILabel alloc] init];
    self.delUserSign.textColor = RedColor;
    self.delUserSign.font = FifteenTypeface;
    self.delUserSign.text = @"(该用户已被删除)";
    [self.userInfo addSubview:self.delUserSign];
    [self.delUserSign setHidden:YES];
    /** 车牌view */
    self.plnView = [[UIView alloc] init];
    self.plnView.backgroundColor = HEXSTR_RGB(@"f0f9ff");
    self.plnView.layer.masksToBounds = YES;
    self.plnView.layer.cornerRadius = 2;
    self.plnView.layer.borderWidth = 0.5;
    self.plnView.layer.borderColor = DividingLine.CGColor;
    [self.userInfo addSubview:self.plnView];
    /** 车牌号 */
    self.plnLabel = [[UILabel alloc] init];
    self.plnLabel.textColor = HEXSTR_RGB(@"1565c0");
    self.plnLabel.font = TwelveTypeface;
    [self.userInfo addSubview:self.plnLabel];
    /** 客户信息分割线 */
    self.userInfoLineView = [[UIView alloc] init];
    [self.orderInfoBackView addArrangedSubview:self.userInfoLineView];
    /**************************** 服务详情标题 *******************************/
    /** 服务详情标题 */
    self.serviceInfoTitle = [[UsedCellView alloc] init];
    self.serviceInfoTitle.cellLabel.text = @"服务详情";
    self.serviceInfoTitle.cellLabel.font = FifteenTypeface;
    self.serviceInfoTitle.cellLabel.textColor = ThemeColor;
    self.serviceInfoTitle.isArrow = YES;
    self.serviceInfoTitle.isCellImage = YES;
    self.serviceInfoTitle.dividingLineChoice = DividingLineFullScreenLayout;
    [self.orderInfoBackView addArrangedSubview:self.serviceInfoTitle];
    /** 服务内容 */
    self.serviceTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.serviceTable.delegate = self;
    self.serviceTable.dataSource = self;
    self.serviceTable.rowHeight = 86;
    self.serviceTable.bounces = YES;
    self.serviceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderInfoBackView addArrangedSubview:self.serviceTable];
    /** 总价 */
    self.priceView = [[UsedCellView alloc] init];
    self.priceView.cellLabel.text = @"总价";
    self.priceView.cellLabel.font = TwelveTypeface;
    self.priceView.cellLabel.textColor = GrayH1;
    self.priceView.describeLabel.font = TwelveTypeface;
    self.priceView.describeLabel.textColor = GrayH1;
    self.priceView.isArrow = YES;
    self.priceView.isCellImage = YES;
    self.priceView.isSplistLine = YES;
    [self.orderInfoBackView addArrangedSubview:self.priceView];
    /** 服务内容分割线 */
    self.serviceTableLineView = [[UIView alloc] init];
    self.serviceTableLineView.backgroundColor = DividingLine;
    [self.priceView addSubview:self.serviceTableLineView];
    /** 优惠 */
    self.discountView = [[CustomCell alloc] init];
    self.discountView.lineStyle = NotLine;
    self.discountView.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.discountView.mainLabel.text = @"优惠";
    self.discountView.mainLabel.font = TwelveTypeface;
    self.discountView.mainLabel.textColor = BlueColor;
    self.discountView.rightViceLabel.font = TwelveTypeface;
    self.discountView.rightViceLabel.textColor = BlueColor;
    [self.orderInfoBackView addArrangedSubview:self.discountView];
    /** 优惠券 */
    self.couponView = [[CustomCell alloc] init];
    self.couponView.lineStyle = CenterLayout;
    self.couponView.cellStyle = HorizontalLayoutNotMImgAndVImg;
    self.couponView.mainLabel.text = @"优惠券";
    self.couponView.mainLabel.font = TwelveTypeface;
    self.couponView.mainLabel.textColor = BlueColor;
    self.couponView.rightViceLabel.font = TwelveTypeface;
    self.couponView.rightViceLabel.textColor = BlueColor;
    [self.orderInfoBackView addArrangedSubview:self.couponView];
    /** 实收 */
    self.thePaidView = [[UsedCellView alloc] init];
    self.thePaidView.cellLabel.text = @"实付款";
    self.thePaidView.cellLabel.font = FourteenTypeface;
    self.thePaidView.cellLabel.textColor = GrayH1;
    self.thePaidView.describeLabel.font = FourteenTypefaceBold;
    self.thePaidView.describeLabel.textColor = HEXSTR_RGB(@"ef5350");
    self.thePaidView.isArrow = YES;
    self.thePaidView.isCellImage = YES;
    self.thePaidView.isSplistLine = YES;
    [self.orderInfoBackView addArrangedSubview:self.thePaidView];
    /** 服务分割线 */
    self.serviceLineView = [[UIView alloc] init];
    [self.orderInfoBackView addArrangedSubview:self.serviceLineView];
    /*================== 订单信息  ================*/
    /** 订单信息标题 */
    self.orderInfoTitleView = [[UsedCellView alloc] init];
    self.orderInfoTitleView.cellLabel.text = @"订单信息";
    self.orderInfoTitleView.cellLabel.font = FifteenTypeface;
    self.orderInfoTitleView.cellLabel.textColor = ThemeColor;
    self.orderInfoTitleView.isArrow = YES;
    self.orderInfoTitleView.isCellImage = YES;
    self.orderInfoTitleView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.orderInfoBackView addArrangedSubview:self.orderInfoTitleView];
    /** 订单信息 */
    self.orderInfoView = [[UIView alloc] init];
    self.orderInfoView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.orderInfoView];
    /** 支付方式 */
    self.paymentView = [[UsedCellView alloc] init];
    self.paymentView.cellLabel.text = @"支付方式";
    self.paymentView.cellLabel.font = TwelveTypeface;
    self.paymentView.cellLabel.textColor = GrayH1;
    self.paymentView.describeLabel.font = TwelveTypeface;
    self.paymentView.describeLabel.textColor = Black;
    self.paymentView.isArrow = YES;
    self.paymentView.isCellImage = YES;
    self.paymentView.isSplistLine = YES;
    [self.orderInfoView addSubview:self.paymentView];
    /** 交易号 */
    self.tradeNumView = [[UsedCellView alloc] init];
    self.tradeNumView.cellLabel.text = @"交易号";
    self.tradeNumView.cellLabel.font = TwelveTypeface;
    self.tradeNumView.cellLabel.textColor = GrayH1;
    self.tradeNumView.describeLabel.font = TwelveTypeface;
    self.tradeNumView.describeLabel.textColor = Black;
    self.tradeNumView.isArrow = YES;
    self.tradeNumView.isCellImage = YES;
    self.tradeNumView.isSplistLine = YES;
    [self.orderInfoView addSubview:self.tradeNumView];
    /** 服务师傅 */
    self.serveMasterView = [[UsedCellView alloc] init];
    self.serveMasterView.cellLabel.text = @"服务师傅";
    self.serveMasterView.cellLabel.font = TwelveTypeface;
    self.serveMasterView.cellLabel.textColor = GrayH1;
    self.serveMasterView.describeLabel.font = TwelveTypeface;
    self.serveMasterView.describeLabel.textColor = Black;
    self.serveMasterView.isArrow = YES;
    self.serveMasterView.isCellImage = YES;
    self.serveMasterView.isSplistLine = YES;
    [self.orderInfoView addSubview:self.serveMasterView];
    /** 收银员 */
    self.cashierView = [[UsedCellView alloc] init];
    self.cashierView.cellLabel.text = @"收银员";
    self.cashierView.cellLabel.font = TwelveTypeface;
    self.cashierView.cellLabel.textColor = GrayH1;
    self.cashierView.describeLabel.font = TwelveTypeface;
    self.cashierView.describeLabel.textColor = Black;
    self.cashierView.isArrow = YES;
    self.cashierView.isCellImage = YES;
    self.cashierView.isSplistLine = YES;
    [self.orderInfoView addSubview:self.cashierView];
    /** 下单时间 */
    self.placeOrderTimeView = [[UsedCellView alloc] init];
    self.placeOrderTimeView.cellLabel.text = @"下单时间";
    self.placeOrderTimeView.cellLabel.font = TwelveTypeface;
    self.placeOrderTimeView.cellLabel.textColor = GrayH1;
    self.placeOrderTimeView.describeLabel.font = TwelveTypeface;
    self.placeOrderTimeView.describeLabel.textColor = Black;
    self.placeOrderTimeView.isArrow = YES;
    self.placeOrderTimeView.isCellImage = YES;
    self.placeOrderTimeView.isSplistLine = YES;
    [self.orderInfoView addSubview:self.placeOrderTimeView];
    /** 付款时间 */
    self.payTimeView = [[UsedCellView alloc] init];
    self.payTimeView.cellLabel.text = @"付款时间";
    self.payTimeView.cellLabel.font = TwelveTypeface;
    self.payTimeView.cellLabel.textColor = GrayH1;
    self.payTimeView.describeLabel.font = TwelveTypeface;
    self.payTimeView.describeLabel.textColor = Black;
    self.payTimeView.isArrow = YES;
    self.payTimeView.isCellImage = YES;
    self.payTimeView.isSplistLine = YES;
    [self.orderInfoView addSubview:self.payTimeView];
    /** 订单分割线 */
    self.orderLineView = [[UIView alloc] init];
    [self.orderInfoBackView addArrangedSubview:self.orderLineView];
    /*================== 用户评价  ================*/
    /** 用户评价标题 */
    self.ratedTitleView = [[UsedCellView alloc] init];
    self.ratedTitleView.cellLabel.text = @"用户评价";
    self.ratedTitleView.cellLabel.font = FifteenTypeface;
    self.ratedTitleView.cellLabel.textColor = ThemeColor;
    self.ratedTitleView.isArrow = YES;
    self.ratedTitleView.isCellImage = YES;
    self.ratedTitleView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.orderInfoBackView addArrangedSubview:self.ratedTitleView];
    /** 用户评价View */
    self.ratedView = [[UIView alloc] init];
    self.ratedView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.ratedView];
    /** 评分 */
    self.ratedScoreLabel = [[UILabel alloc] init];
    self.ratedScoreLabel.textColor = HEXSTR_RGB(@"ef6c00");
    self.ratedScoreLabel.font = FourteenTypeface;
    [self.ratedView addSubview:self.ratedScoreLabel];
    /** 评星 */
    self.atedStarView = [[CWStarRateView alloc] initWithFrame:CGRectMake(15, 10, 130, 18)];
    self.atedStarView.userInteractionEnabled = NO;
    [self.ratedView addSubview:self.atedStarView];
    /** 内容标题 */
    self.contentTitleLabel = [[UILabel alloc] init];
    self.contentTitleLabel.textColor = Black;
    self.contentTitleLabel.font = FifteenTypeface;
    self.contentTitleLabel.text = @"内容";
    [self.ratedView addSubview:self.contentTitleLabel];
    /** 评价内容 */
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = GrayH2;
    self.contentLabel.font = TwelveTypeface;
    self.contentLabel.numberOfLines = 0;
    [self.ratedView addSubview:self.contentLabel];
    /*================== 没有更多内容了  ================*/
    /** 没有更多内容 */
    self.noMoreContentLabel = [[UILabel alloc] init];
    self.noMoreContentLabel.textColor = NotClick;
    self.noMoreContentLabel.font = TwelveTypeface;
    self.noMoreContentLabel.text = @"没有更多内容";
    self.noMoreContentLabel.textAlignment = NSTextAlignmentCenter;
    [self.orderInfoBackView addArrangedSubview:self.noMoreContentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.orderInfoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.orderInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderInfoScrollView.mas_top);
        make.left.equalTo(self.orderInfoScrollView.mas_left);
        make.bottom.equalTo(self.orderInfoScrollView.mas_bottom);
        make.right.equalTo(self.orderInfoScrollView.mas_right);
        make.width.equalTo(self.orderInfoScrollView.mas_width);
    }];
    /*================== 头部 ================*/
    /** 头部背景图片 */
    [self.headerBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
    }];
    /** 状态 */
    [self.orderType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerBackImage.mas_top).offset(24);
        make.centerX.equalTo(self.headerBackImage.mas_centerX);
    }];
    /** 订单号 */
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderType.mas_bottom).offset(24);
        make.centerX.equalTo(self.headerBackImage.mas_centerX);
        make.right.equalTo(self.orderNum.rightText.mas_right);
        make.bottom.equalTo(self.orderNum.rightText.mas_bottom);
    }];
    /** 复制 */
    [self.replicateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.orderNum.mas_centerY);
        make.left.equalTo(self.orderNum.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 14));
    }];
    /** 头部分割线 */
    [self.headerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    /*================== 客户信息  ================*/
    /** 客户信息标题 */
    [self.customerInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 客户信息view */
    [self.userInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@72);
    }];
    /** 用户删除提示 */
    [self.delUserSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.userInfo.cellLabel.mas_centerY);
        make.left.equalTo(self.userInfo.cellLabel.mas_right);
    }];
    /** 车牌view */
    [self.plnView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.userInfo.arrowImage.mas_left).offset(-16);
        make.centerY.equalTo(self.userInfo.arrowImage.mas_centerY);
        make.left.equalTo(self.plnLabel.mas_left).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    /** 车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnView.mas_centerY);
        make.centerX.equalTo(self.plnView.mas_centerX);
    }];
    /** 客户信息分割线 */
    [self.userInfoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    /*================== 服务详情  ================*/
    /** 服务详情标题 */
    [self.serviceInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 服务内容 */
    [self.serviceTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(86 * self.serviceTableArray.count));
    }];
    /** 总价 */
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@29.5);
    }];
    /** 服务内容分割线 */
    [self.serviceTableLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.priceView.mas_top);
        make.left.equalTo(self.priceView.mas_left);
        make.right.equalTo(self.priceView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    /** 优惠 */
    [self.discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@29.5);
    }];
    /** 优惠券 */
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@29.5);
    }];
    /** 实收 */
    [self.thePaidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 服务分割线 */
    [self.serviceLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    /*================== 订单信息  ================*/
    /** 订单信息标题 */
    [self.orderInfoTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 订单信息 */
    [self.orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.payTimeView.mas_bottom).offset(16);
    }];
    /** 支付方式 */
    [self.paymentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderInfoView.mas_top).offset(16);
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.bottom.equalTo(self.paymentView.cellLabel.mas_bottom);
    }];
    /** 交易号 */
    [self.tradeNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.paymentView.mas_bottom).offset(16);
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.bottom.equalTo(self.tradeNumView.cellLabel.mas_bottom);
    }];
    /** 服务师傅 */
    [self.serveMasterView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.tradeNumView.mas_bottom).offset(16);
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.bottom.equalTo(self.serveMasterView.cellLabel.mas_bottom);
    }];
    /** 收银员 */
    [self.cashierView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serveMasterView.mas_bottom).offset(16);
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.bottom.equalTo(self.cashierView.cellLabel.mas_bottom);
    }];
    /** 下单时间 */
    [self.placeOrderTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cashierView.mas_bottom).offset(16);
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.bottom.equalTo(self.placeOrderTimeView.cellLabel.mas_bottom);
    }];
    /** 付款时间 */
    [self.payTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.placeOrderTimeView.mas_bottom).offset(16);
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.bottom.equalTo(self.payTimeView.cellLabel.mas_bottom);
    }];
    /** 订单分割线 */
    [self.orderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    /*================== 用户评价  ================*/
    /** 用户评价标题 */
    [self.ratedTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 用户评价View */
    [self.ratedView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.contentLabel.mas_bottom).offset(21);
    }];
    /** 评分 */
    [self.ratedScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.ratedView.mas_top).offset(18);
        make.left.equalTo(self.ratedView.mas_left).offset(16);
    }];
    /** 评星 */
    [self.atedStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.ratedScoreLabel.mas_centerY);
        make.right.equalTo(self.ratedView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(130, 18));
    }];
    /** 内容标题 */
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.ratedScoreLabel.mas_bottom).offset(16);
        make.left.equalTo(self.ratedScoreLabel.mas_left);
    }];
    /** 评价内容 */
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentTitleLabel.mas_bottom).offset(12);
        make.left.equalTo(self.ratedScoreLabel.mas_left);
        make.right.equalTo(self.atedStarView.mas_right);
    }];
    /*================== 没有更多内容了  ================*/
    /** 没有更多内容 */
    [self.noMoreContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@48);
    }];
    /** 填充scrollview的view的高度 */
    [self.orderInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.noMoreContentLabel.mas_bottom);
    }];
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.serviceTableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"orderDetailsCell";
    OrderServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[OrderServiceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.orderDetailsModel = [self.serviceTableArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

