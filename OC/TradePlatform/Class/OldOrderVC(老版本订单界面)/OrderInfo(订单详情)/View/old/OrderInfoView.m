//
//  OrderInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderInfoView.h"

@interface OrderInfoView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *orderInfoScrollView;
/** 头部背景图片 */
@property (strong, nonatomic) UIImageView *headerBackImage;

/** 客户信息标题 */
@property (strong, nonatomic) UsedCellView *customerInfoTitle;
/** 客户信息分割线 */
@property (strong, nonatomic) UIView *userInfoLineView;
/** 服务详情标题 */
@property (strong, nonatomic) UsedCellView *serviceInfoTitle;



/** 订单信息标题 */
@property (strong, nonatomic) UILabel *orderInfoTitle;


/** 订单信息view */
@property (strong, nonatomic) UIView *orderInfoView;

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

- (void)orderInfoLayoutView {
    /** 背景scrollview */
    self.orderInfoScrollView = [[UIScrollView alloc] init];
    self.orderInfoScrollView.backgroundColor = VCBackground;
    [self addSubview:self.orderInfoScrollView];
    /** 填充scrollview的view */
    self.orderInfoBackView = [[UIStackView alloc] init];
    self.orderInfoBackView.axis = UILayoutConstraintAxisVertical;
    [self.orderInfoScrollView addSubview:self.orderInfoBackView];
    
    /** 头部背景图片 */
    self.headerBackImage = [[UIImageView alloc] init];
    self.headerBackImage.image = [UIImage imageNamed:@"header_choice_back"];
    self.headerBackImage.userInteractionEnabled = YES;
    [self.orderInfoBackView addArrangedSubview:self.headerBackImage];
    /** 状态 */
    self.orderType = [[UILabel alloc] init];
    self.orderType.text = @"状态：";
    self.orderType.font = TwentyFourTypefaceBold;
    self.orderType.textColor = WhiteColor;
    [self.headerBackImage addSubview:self.orderType];
    /** 订单号 */
    self.orderNum = [[leftRigText alloc] init];
    self.orderNum.leftText.text = @"订单号";
    self.orderNum.leftText.font = FifteenTypeface;
    self.orderNum.leftText.textColor = RGBA(255, 255, 255, 0.8);
    self.orderNum.rightText.font = FifteenTypeface;
    self.orderNum.rightText.textColor = RGBA(255, 255, 255, 0.8);
    [self.headerBackImage addSubview:self.orderNum];
    /** 复制 */
    self.copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.copyBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.copyBtn.titleLabel.font = ElevenTypeface;
    self.copyBtn.layer.masksToBounds = YES;
    self.copyBtn.layer.cornerRadius = 2;
    self.copyBtn.layer.borderWidth = 0.5;
    self.copyBtn.layer.borderColor = WhiteColor.CGColor;
    [self.headerBackImage addSubview:self.copyBtn];
    /**************************** 客户信息标题 *******************************/
    /** 客户信息标题 */
    self.customerInfoTitle = [[UsedCellView alloc] init];
    self.customerInfoTitle.cellLabel.text = @"用户信息";
    self.customerInfoTitle.cellLabel.font = FifteenTypeface;
    self.customerInfoTitle.cellLabel.textColor = ThemeColor;
    [self.orderInfoBackView addArrangedSubview:self.customerInfoTitle];
    /** 用户信息view */
    self.userInfo = [[UsedCellView alloc] init];
    self.userInfo.usedCellTypeChoice = BigPictureVerticallyLayout;
    self.userInfo.cellLabel.font = FifteenTypeface;
    self.userInfo.viceLabel.textColor = GrayH1;
    self.userInfo.isCellBtn = YES;
    self.userInfo.isCellImage = YES;
    self.userInfo.dividingLineChoice = DividingLineFullScreenLayout;
    [self.orderInfoBackView addArrangedSubview:self.userInfo];
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
    self.plnLabel.textColor = Black;
    self.plnLabel.font = TwelveTypeface;
    [self.userInfo addSubview:self.plnLabel];
    /** 客户信息分割线 */
    self.userInfoLineView = [[UIView alloc] init];
    [self.orderInfoBackView addArrangedSubview:self.userInfoLineView];
    /**************************** 服务详情标题 *******************************/
    /** 服务详情标题 */
    self.customerInfoTitle = [[UsedCellView alloc] init];
    self.customerInfoTitle.cellLabel.text = @"服务详情";
    self.customerInfoTitle.cellLabel.font = FifteenTypeface;
    self.customerInfoTitle.cellLabel.textColor = ThemeColor;
    [self.orderInfoBackView addArrangedSubview:self.customerInfoTitle];
    
    /** 客户信息view */
    self.customerInfoView = [[UIView alloc] init];
    self.customerInfoView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.customerInfoView];
    /** 用户姓名 */
    self.userName = [[leftRigText alloc] init];
    self.userName.leftText.text = @"姓名：";
    self.userName.leftText.font = FifteenTypeface;
    self.userName.backgroundColor = WhiteColor;
    [self.customerInfoView addSubview:self.userName];
    /** 用户车牌 */
    self.userPln = [[leftRigText alloc] init];
    self.userPln.leftText.text = @"车牌：";
    self.userPln.leftText.font = FifteenTypeface;
    self.userPln.backgroundColor = WhiteColor;
    [self.customerInfoView addSubview:self.userPln];
    /** 用户手机号 */
    self.userPhone = [[leftRigText alloc] init];
    self.userPhone.leftText.text = @"手机号：";
    self.userPhone.leftText.font = FifteenTypeface;
    self.userPhone.backgroundColor = WhiteColor;
    [self.customerInfoView addSubview:self.userPhone];
    
    /********************************* 订单信息 *******************************/
    /** 订单信息标题 */
    self.orderInfoTitle = [[UILabel alloc] init];
    self.orderInfoTitle.text = @"    订单信息";
    self.orderInfoTitle.font = FifteenTypeface;
    self.orderInfoTitle.textColor = GrayH1;
    [self.orderInfoBackView addArrangedSubview:self.orderInfoTitle];
    /** 订单信息view */
    self.orderInfoView = [[UIView alloc] init];
    self.orderInfoView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.orderInfoView];
    
    /** 服务 */
    self.orderService = [[UsedCellView alloc] init];
    self.orderService.cellLabel.text = @"服务：";
    self.orderService.cellLabel.font = FifteenTypeface;
    self.orderService.cellLabel.textColor = GrayH2;
    self.orderService.viceLabel.text = @" ";
    self.orderService.viceLabel.font = FifteenTypeface;
    self.orderService.viceLabel.textColor = Black;
    self.orderService.isSplistLine = YES;
    self.orderService.isCellImage = YES;
    self.orderService.isArrow = YES;
    self.orderService.isCellBtn = YES;
    [self.orderInfoView addSubview:self.orderService];
    /** 单价 */
    self.unitPrice = [[UsedCellView alloc] init];
    self.unitPrice.cellLabel.text = @"单价：";
    self.unitPrice.cellLabel.font = FifteenTypeface;
    self.unitPrice.cellLabel.textColor = GrayH2;
    self.unitPrice.viceLabel.text = @" ";
    self.unitPrice.viceLabel.font = FifteenTypeface;
    self.unitPrice.viceLabel.textColor = Black;
    self.unitPrice.isSplistLine = YES;
    self.unitPrice.isCellImage = YES;
    self.unitPrice.isArrow = YES;
    self.unitPrice.isCellBtn = YES;
    [self.orderInfoView addSubview:self.unitPrice];
    /** 数量 */
    self.number = [[UsedCellView alloc] init];
    self.number.cellLabel.text = @"数量：";
    self.number.cellLabel.font = FifteenTypeface;
    self.number.cellLabel.textColor = GrayH2;
    self.number.viceLabel.text = @" ";
    self.number.viceLabel.font = FifteenTypeface;
    self.number.viceLabel.textColor = Black;
    self.number.isSplistLine = YES;
    self.number.isCellImage = YES;
    self.number.isArrow = YES;
    self.number.isCellBtn = YES;
    [self.orderInfoView addSubview:self.number];
    /** 状态 */
    self.orderType = [[UsedCellView alloc] init];
    self.orderType.cellLabel.text = @"状态：";
    self.orderType.cellLabel.font = FifteenTypeface;
    self.orderType.cellLabel.textColor = GrayH2;
    self.orderType.viceLabel.text = @" ";
    self.orderType.viceLabel.font = FifteenTypeface;
    self.orderType.viceLabel.textColor = Black;
    self.orderType.isSplistLine = YES;
    self.orderType.isCellImage = YES;
    self.orderType.isArrow = YES;
    self.orderType.isCellBtn = YES;
    [self.orderInfoView addSubview:self.orderType];
    /** 备注 */
    self.remarks = [[UsedCellView alloc] init];
    self.remarks.cellLabel.text = @"备注：";
    self.remarks.cellLabel.font = FifteenTypeface;
    self.remarks.cellLabel.textColor = GrayH2;
    self.remarks.viceLabel.text = @" ";
    self.remarks.viceLabel.font = FifteenTypeface;
    self.remarks.viceLabel.textColor = Black;
    self.remarks.isCellImage = YES;
    self.remarks.isArrow = YES;
    self.remarks.isCellBtn = YES;
    self.remarks.isSplistLine = YES;
    [self.orderInfoView addSubview:self.remarks];
    /** 总价 */
    self.total = [[UsedCellView alloc] init];
    self.total.cellLabel.text = @"总价：";
    self.total.cellLabel.font = FifteenTypeface;
    self.total.cellLabel.textColor = GrayH2;
    self.total.viceLabel.text = @" ";
    self.total.viceLabel.font = FifteenTypeface;
    self.total.viceLabel.textColor = Black;
    self.total.isSplistLine = YES;
    self.total.isCellImage = YES;
    self.total.isArrow = YES;
    self.total.isCellBtn = YES;
    [self.orderInfoView addSubview:self.total];
    /** 优惠 */
    self.discount = [[UsedCellView alloc] init];
    self.discount.cellLabel.text = @"优惠：";
    self.discount.cellLabel.font = FifteenTypeface;
    self.discount.cellLabel.textColor = GrayH2;
    self.discount.viceLabel.text = @" ";
    self.discount.viceLabel.font = FifteenTypeface;
    self.discount.viceLabel.textColor = Black;
    self.discount.isSplistLine = YES;
    self.discount.isCellImage = YES;
    self.discount.isArrow = YES;
    self.discount.isCellBtn = YES;
    [self.orderInfoView addSubview:self.discount];
    
    /********************************* 支付信息 *******************************/
    /** 支付信息标题 */
    self.payInfoTitle = [[UILabel alloc] init];
    self.payInfoTitle.text = @"    支付信息";
    self.payInfoTitle.font = FifteenTypeface;
    self.payInfoTitle.textColor = GrayH1;
    [self.orderInfoBackView addArrangedSubview:self.payInfoTitle];
    /** 支付信息view */
    self.payInfoView = [[UIView alloc] init];
    self.payInfoView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.payInfoView];
    /** 支付金额 */
    self.payLoan = [[UsedCellView alloc] init];
    self.payLoan.cellLabel.text = @"实际支付金额：";
    self.payLoan.cellLabel.font = FifteenTypeface;
    self.payLoan.cellLabel.textColor = GrayH2;
    self.payLoan.viceLabel.text = @" ";
    self.payLoan.viceLabel.font = FifteenTypeface;
    self.payLoan.viceLabel.textColor = Black;
    self.payLoan.isSplistLine = YES;
    self.payLoan.isCellImage = YES;
    self.payLoan.isArrow = YES;
    self.payLoan.isCellBtn = YES;
    [self.payInfoView addSubview:self.payLoan];
    /** 支付方式 */
    self.payMode = [[UsedCellView alloc] init];
    self.payMode.cellLabel.text = @"支付方式：";
    self.payMode.cellLabel.font = FifteenTypeface;
    self.payMode.cellLabel.textColor = GrayH2;
    self.payMode.viceLabel.text = @" ";
    self.payMode.viceLabel.font = FifteenTypeface;
    self.payMode.viceLabel.textColor = Black;
    self.payMode.isSplistLine = YES;
    self.payMode.isCellImage = YES;
    self.payMode.isArrow = YES;
    self.payMode.isCellBtn = YES;
    [self.payInfoView addSubview:self.payMode];
    /** 卡／交易号 */
    self.payCard = [[UsedCellView alloc] init];
    self.payCard.cellLabel.text = @"卡／交易号：";
    self.payCard.cellLabel.font = FifteenTypeface;
    self.payCard.cellLabel.textColor = GrayH2;
    self.payCard.viceLabel.text = @" ";
    self.payCard.viceLabel.font = FifteenTypeface;
    self.payCard.viceLabel.textColor = Black;
    self.payCard.isSplistLine = YES;
    self.payCard.isCellImage = YES;
    self.payCard.isArrow = YES;
    self.payCard.isCellBtn = YES;
    [self.payInfoView addSubview:self.payCard];
    
    /********************************* 评价 *******************************/
    /** 评价标题 */
    self.evaluateTitle = [[UILabel alloc] init];
    self.evaluateTitle.text = @"    评价";
    self.evaluateTitle.font = FifteenTypeface;
    self.evaluateTitle.textColor = GrayH1;
    [self.orderInfoBackView addArrangedSubview:self.evaluateTitle];
    /** 评价view */
    self.evaluateView = [[UIView alloc] init];
    self.evaluateView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.evaluateView];
    /** 评分 */
    self.commentScore = [[leftRigText alloc] init];
    self.commentScore.leftText.text = @"评分：";
    self.commentScore.backgroundColor = WhiteColor;
    [self.evaluateView addSubview:self.commentScore];
    /** 评星 */
    self.commentStar = [[CWStarRateView alloc] initWithFrame:CGRectMake(15, 10, 100, 15)];
    self.commentStar.userInteractionEnabled = NO;
    [self.evaluateView addSubview:self.commentStar];
    /** 评价内容 */
    self.commentContent = [[leftRigText alloc] init];
    self.commentContent.leftRigTextTypeChoice = VerticallyLayoutAndLeftAlignAndRightWrap;
    self.commentContent.leftText.text = @"内容：";
    self.commentContent.rightText.text = @" ";
    self.commentContent.backgroundColor = WhiteColor;
    [self.evaluateView addSubview:self.commentContent];
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
    
    /** 客户信息标题 */
    [self.customerInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 用户姓名 */
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.customerInfoView.mas_left).offset(15);
        make.top.equalTo(self.customerInfoView.mas_top).offset(15);
        make.bottom.equalTo(self.userName.leftText.mas_bottom);
        make.right.equalTo(self.userName.rightText.mas_right);
    }];
    /** 用户车牌 */
    [self.userPln mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.customerInfoView.mas_left).offset(15);
        make.top.equalTo(self.userName.mas_bottom).offset(15);
        make.bottom.equalTo(self.userPln.leftText.mas_bottom);
        make.right.equalTo(self.userPln.rightText.mas_right);
    }];
    /** 用户手机号 */
    [self.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.customerInfoView.mas_left).offset(15);
        make.top.equalTo(self.userPln.mas_bottom).offset(15);
        make.bottom.equalTo(self.userPhone.leftText.mas_bottom);
        make.right.equalTo(self.userPhone.rightText.mas_right);
    }];
    /** 客户信息view */
    [self.customerInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.userPhone.mas_bottom).offset(15);
    }];
    /** 订单信息标题 */
    [self.orderInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 订单号 */
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.top.equalTo(self.orderInfoView.mas_top).offset(5);
        make.height.mas_equalTo(@30);
    }];
    /** 服务 */
    [self.orderService mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.top.equalTo(self.orderNum.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 单价 */
    [self.unitPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.top.equalTo(self.orderService.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 数量 */
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.top.equalTo(self.unitPrice.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 状态 */
    [self.orderType mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.top.equalTo(self.number.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 总价 */
    [self.total mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.top.equalTo(self.orderType.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 优惠 */
    [self.discount mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.top.equalTo(self.total.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 备注 */
    [self.remarks mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderInfoView.mas_left);
        make.right.equalTo(self.orderInfoView.mas_right);
        make.top.equalTo(self.discount.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 订单信息view */
    [self.orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.remarks.mas_bottom).offset(5);
    }];
    /** 支付信息标题 */
    [self.payInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 支付金额 */
    [self.payLoan mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.payInfoView.mas_left);
        make.right.equalTo(self.payInfoView.mas_right);
        make.top.equalTo(self.payInfoView.mas_top).offset(5);
        make.height.mas_equalTo(@30);
    }];
    /** 支付方式 */
    [self.payMode mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.payInfoView.mas_left);
        make.right.equalTo(self.payInfoView.mas_right);
        make.top.equalTo(self.payLoan.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 卡／交易号 */
    [self.payCard mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.payInfoView.mas_left);
        make.right.equalTo(self.payInfoView.mas_right);
        make.top.equalTo(self.payMode.mas_bottom);
        make.height.mas_equalTo(@30);
    }];
    /** 支付信息view */
    [self.payInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.payCard.mas_bottom).offset(5);
    }];
    /** 评价标题 */
    [self.evaluateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    /** 评分 */
    [self.commentScore mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.evaluateView.mas_left).offset(15);
        make.top.equalTo(self.evaluateView.mas_top).offset(15);
        make.bottom.equalTo(self.commentScore.leftText.mas_bottom);
        make.right.equalTo(self.commentScore.rightText.mas_right);
    }];
    /** 评星 */
    [self.commentStar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.evaluateView.mas_right).offset(-15);
        make.centerY.equalTo(self.commentScore.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 15));
    }];
    /** 评价内容 */
    [self.commentContent mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.evaluateView.mas_left).offset(15);
        make.right.equalTo(self.evaluateView.mas_right).offset(-15);
        make.top.equalTo(self.commentScore.mas_bottom).offset(15);
    }];
    /** 评价左边内容 */
    [self.commentContent.leftText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@44);
    }];
    /** 评价view */
    [self.evaluateView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.commentContent.mas_bottom).offset(15);
    }];
    /** 填充scrollview的view的高度 */
    [self.orderInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.evaluateView.mas_bottom);
    }];
}

@end
