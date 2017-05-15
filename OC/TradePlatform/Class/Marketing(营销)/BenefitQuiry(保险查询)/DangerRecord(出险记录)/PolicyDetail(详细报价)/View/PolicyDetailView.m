//
//  PolicyDetailView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PolicyDetailView.h"

@interface PolicyDetailView ()<UITableViewDelegate, UITableViewDataSource>
/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *orderInfoScrollView;
/*================== 用户信息 ================*/
/** 分割线 */
@property (strong, nonatomic) UIView *userInfoLineView;
@property (strong, nonatomic) UIView *userInfoUpView;
@property (strong, nonatomic) UIView *userInfoDownView;

/*================== 强制险 ================*/
/** 分割线 */
@property (strong, nonatomic) UIView *compulsoryLineView;
@property (strong, nonatomic) UIView *compulsoryUpView;
@property (strong, nonatomic) UIView *compulsoryDownView;
/*================== 商业险 ================*/
/** 分割线 */
@property (strong, nonatomic) UIView *businessLineView;
@property (strong, nonatomic) UIView *businessDownView;
/*================== 金额 ================*/
/** 分割线 */
@property (strong, nonatomic) UIView *moneyLineView;
@property (strong, nonatomic) UIView *moneyUpView;
@property (strong, nonatomic) UIView *moneyDownView;
/*================== 到期时间 ================*/
/** 分割线 */
@property (strong, nonatomic) UIView *timeLineView;
@property (strong, nonatomic) UIView *timeUpView;
@property (strong, nonatomic) UIView *timeDownView;
/*================== 收件人信息 ================*/
/** 分割线 */
@property (strong, nonatomic) UIView *recipientLineView;
/*================== 实付详情 ================*/
/** 分割线 */
@property (strong, nonatomic) UIView *paidLineView;
/*================== 出保单 ================*/
/** 分割线 */
@property (strong, nonatomic) UIView *paidBtnLineView;
@end
@implementation PolicyDetailView

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
    self.orderInfoScrollView.backgroundColor = VCBackground;;
    [self addSubview:self.orderInfoScrollView];
    /** 填充scrollview的view */
    self.orderInfoBackView = [[UIStackView alloc] init];
    self.orderInfoBackView.axis = UILayoutConstraintAxisVertical;
    [self.orderInfoScrollView addSubview:self.orderInfoBackView];

    /**************************** 用户信息标题 *******************************/
    /** 银行信息标题 */
    self.theInsuranceBankView = [[UsedCellView alloc] init];
    self.theInsuranceBankView.describeLabel.text = @"银行信息";
    self.theInsuranceBankView.describeLabel.font = FourteenTypeface;
    self.theInsuranceBankView.describeLabel.textColor = Black;
    self.theInsuranceBankView.isCellImageSize = YES;
    self.theInsuranceBankView.isArrow = YES;
    self.theInsuranceBankView.cellImageSize = CGSizeMake(80, 40);
    self.theInsuranceBankView.cellImage.image = [UIImage imageNamed:@"custom_open_card"];
    self.theInsuranceBankView.dividingLineChoice = DividingLineCenterLayout;
    [self.orderInfoBackView addArrangedSubview:self.theInsuranceBankView];
    /** 车牌上方留白 */
    self.userInfoUpView = [[UIView alloc] init];
    self.userInfoUpView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.userInfoUpView];
    /** 车牌姓名 */
    self.theCarNumView = [[UsedCellView alloc] init];
    self.theCarNumView.cellLabel.font = TwelveTypeface;
    self.theCarNumView.cellLabel.textColor = GrayH1;
    self.theCarNumView.describeLabel.font = TwelveTypeface;
    self.theCarNumView.describeLabel.textColor = GrayH1;
    self.theCarNumView.isArrow = YES;
    self.theCarNumView.isSplistLine = YES;
    self.theCarNumView.isCellImage = YES;
    [self.orderInfoBackView addArrangedSubview:self.theCarNumView];
    /** 车型号 */
    self.theCarTypeView = [[UsedCellView alloc] init];
    self.theCarTypeView.cellLabel.font = TwelveTypeface;
    self.theCarTypeView.cellLabel.textColor = GrayH1;
    self.theCarTypeView.isArrow = YES;
    self.theCarTypeView.isSplistLine = YES;
    self.theCarTypeView.isCellImage = YES;
    [self.orderInfoBackView addArrangedSubview:self.theCarTypeView];
    /** 车型号下放留白 */
    self.userInfoDownView = [[UIView alloc] init];
    self.userInfoDownView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.userInfoDownView];
    /** 客户信息分割线 */
    self.userInfoLineView = [[UIView alloc] init];
    self.userInfoLineView.backgroundColor = CLEARCOLOR;
    [self.orderInfoBackView addArrangedSubview:self.userInfoLineView];
    /**************************** 强制险 *******************************/
    /** 强制险 */
    self.theCompulsoryView = [[UsedCellView alloc] init];
    self.theCompulsoryView.cellLabel.text = @"强制险";
    self.theCompulsoryView.cellLabel.font = FourteenTypeface;
    self.theCompulsoryView.cellLabel.textColor = ThemeColor;
    self.theCompulsoryView.describeLabel.font = ThirteenTypeface;
    self.theCompulsoryView.describeLabel.textColor = HEXSTR_RGB(@"ef5350");
    self.theCompulsoryView.isArrow = YES;
    self.theCompulsoryView.isCellImage = YES;
    self.theCompulsoryView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.orderInfoBackView addArrangedSubview:self.theCompulsoryView];
    /** 险种上方留白 */
    self.compulsoryUpView = [[UIView alloc] init];
    self.compulsoryUpView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.compulsoryUpView];
    /** 强制险header */
    self.theCompulsoryheaderView = [[CompulsoryHeaderView alloc] init];
    self.theCompulsoryheaderView.leftLab.text = @"险种";
    self.theCompulsoryheaderView.leftLab.textColor = GrayH1;
    self.theCompulsoryheaderView.centerLab.text = @"保额";
    self.theCompulsoryheaderView.centerLab.textColor = GrayH1;
    self.theCompulsoryheaderView.rightLab.text = @"保费";
    self.theCompulsoryheaderView.rightLab.textColor = GrayH1;
    [self.orderInfoBackView addArrangedSubview:self.theCompulsoryheaderView];
    /** 强制险内容 */
    self.compulsoryInsuranceTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.compulsoryInsuranceTable.scrollEnabled = NO;
    self.compulsoryInsuranceTable.delegate = self;
    self.compulsoryInsuranceTable.dataSource = self;
    self.compulsoryInsuranceTable.rowHeight = 30;
    self.compulsoryInsuranceTable.bounces = YES;
    self.compulsoryInsuranceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderInfoBackView addArrangedSubview:self.compulsoryInsuranceTable];
    /** 强制险tab下方留白 */
    self.compulsoryDownView = [[UIView alloc] init];
    self.compulsoryDownView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.compulsoryDownView];
    /** 强制险分割线 */
    self.compulsoryLineView = [[UIView alloc] init];
    self.compulsoryLineView.backgroundColor = CLEARCOLOR;
    [self.orderInfoBackView addArrangedSubview:self.compulsoryLineView];
    
    /**************************** 商业险 *******************************/
    /** 商业险 */
    self.theBusinessView = [[UsedCellView alloc] init];
    self.theBusinessView.cellLabel.text = @"商业险";
    self.theBusinessView.cellLabel.font = FourteenTypeface;
    self.theBusinessView.cellLabel.textColor = ThemeColor;
    self.theBusinessView.describeLabel.font = ThirteenTypeface;
    self.theBusinessView.describeLabel.textColor = HEXSTR_RGB(@"ef5350");
    self.theBusinessView.isArrow = YES;
    self.theBusinessView.isCellImage = YES;
    self.theBusinessView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.orderInfoBackView addArrangedSubview:self.theBusinessView];
    /** 商业险header */
    self.theBusinessheaderView = [[BusinessHeaderView alloc] init];
    self.theBusinessheaderView.leftOneLab.text = @"险种";
    self.theBusinessheaderView.leftOneLab.textColor = GrayH1;
    self.theBusinessheaderView.leftTwoLab.text = @"保额";
    self.theBusinessheaderView.leftTwoLab.textColor = GrayH1;
    self.theBusinessheaderView.leftThreeLab.text = @"不计免赔";
    self.theBusinessheaderView.leftThreeLab.textColor = GrayH1;
    self.theBusinessheaderView.leftFourLab.text = @"保费";
    self.theBusinessheaderView.leftFourLab.textColor = GrayH1;
    [self.orderInfoBackView addArrangedSubview:self.theBusinessheaderView];
    
    /** 商业险内容 */
    self.businessInsuranceTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.businessInsuranceTable.delegate = self;
    self.businessInsuranceTable.dataSource = self;
    self.businessInsuranceTable.scrollEnabled = NO;
    self.businessInsuranceTable.rowHeight = 30;
    self.businessInsuranceTable.bounces = YES;
    self.businessInsuranceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderInfoBackView addArrangedSubview:self.businessInsuranceTable];
    /** 商业险险tab下方留白 */
    self.businessDownView = [[UIView alloc] init];
    self.businessDownView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.businessDownView];
    /** 商业险分割线 */
    self.businessLineView = [[UIView alloc] init];
    self.businessLineView.backgroundColor = CLEARCOLOR;
    [self.orderInfoBackView addArrangedSubview:self.businessLineView];
    /** 保费上方留白 */
    self.moneyUpView = [[UIView alloc] init];
    self.moneyUpView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.moneyUpView];
    /** 保费 */
    self.theInsuranceAmountView = [[UsedCellView alloc] init];
    self.theInsuranceAmountView.cellLabel.text = @"保费合计";
    self.theInsuranceAmountView.cellLabel.font = FourteenTypeface;
    self.theInsuranceAmountView.cellLabel.textColor = Black;
    self.theInsuranceAmountView.describeLabel.font = FourteenTypeface;
    self.theInsuranceAmountView.describeLabel.textColor = HEXSTR_RGB(@"ef5350");
    self.theInsuranceAmountView.isArrow = YES;
    self.theInsuranceAmountView.isSplistLine = YES;
    self.theInsuranceAmountView.isCellImage = YES;
    [self.orderInfoBackView addArrangedSubview:self.theInsuranceAmountView];
    /** 折扣 */
    self.theDiscountView = [[UsedCellView alloc] init];
    self.theDiscountView.cellLabel.text = @"折扣";
    self.theDiscountView.cellLabel.font = FourteenTypeface;
    self.theDiscountView.cellLabel.textColor = Black;
    self.theDiscountView.describeLabel.font = TwelveTypeface;
    self.theDiscountView.describeLabel.textColor = HEXSTR_RGB(@"ef5350");
    self.theDiscountView.isArrow = YES;
    self.theDiscountView.isCellImage = YES;
    self.theDiscountView.isSplistLine = YES;
    [self.orderInfoBackView addArrangedSubview:self.theDiscountView];
    /** 保费下方留白 */
    self.moneyDownView = [[UIView alloc] init];
    self.moneyDownView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.moneyDownView];
    /** 金额分割线 */
    self.moneyLineView = [[UIView alloc] init];
    self.moneyLineView.backgroundColor = CLEARCOLOR;
    [self.orderInfoBackView addArrangedSubview:self.moneyLineView];
    /*================== 到期时间  ================*/
    /** 到期时间上方留白 */
    self.timeUpView = [[UIView alloc] init];
    self.timeUpView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.timeUpView];
    /** 商业险内容 */
    self.TimeTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.TimeTable.scrollEnabled = NO;
    self.TimeTable.delegate = self;
    self.TimeTable.dataSource = self;
    self.TimeTable.rowHeight = 30;
    self.TimeTable.bounces = YES;
    self.TimeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderInfoBackView addArrangedSubview:self.TimeTable];
    /** 到期时间下方留白 */
    self.timeDownView = [[UIView alloc] init];
    self.timeDownView.backgroundColor = WhiteColor;
    [self.orderInfoBackView addArrangedSubview:self.timeDownView];
    /** 到期时间分割线 */
    self.timeLineView = [[UIView alloc] init];
    self.timeLineView.backgroundColor = CLEARCOLOR;
    [self.orderInfoBackView addArrangedSubview:self.timeLineView];
    /*================== 收件人  ================*/
    /** 收件人 */
    self.theRecipientView = [[UsedCellView alloc] init];
    self.theRecipientView.cellLabel.text = @"收件人";
    self.theRecipientView.cellLabel.font = FourteenTypeface;
    self.theRecipientView.cellLabel.textColor = Black;
    self.theRecipientView.describeLabel.font = FourteenTypeface;
    self.theRecipientView.describeLabel.textColor = GrayH1;
    self.theRecipientView.isArrow = YES;
    self.theRecipientView.isSplistLine = YES;
    self.theRecipientView.isCellImage = YES;
    [self.orderInfoBackView addArrangedSubview:self.theRecipientView];
    /** 收件人手机号 */
    self.theRecipientPhoneView = [[UsedCellView alloc] init];
    self.theRecipientPhoneView.cellLabel.text = @"收件人手机号";
    self.theRecipientPhoneView.cellLabel.font = FourteenTypeface;
    self.theRecipientPhoneView.cellLabel.textColor = Black;
    self.theRecipientPhoneView.describeLabel.font = FourteenTypeface;
    self.theRecipientPhoneView.describeLabel.textColor = GrayH1;
    self.theRecipientPhoneView.isArrow = YES;
    self.theRecipientPhoneView.isSplistLine = YES;
    self.theRecipientPhoneView.isCellImage = YES;
    [self.orderInfoBackView addArrangedSubview:self.theRecipientPhoneView];
    /** 收件人地址 */
    self.theRecipientAddressView = [[UsedCellView alloc] init];
    self.theRecipientAddressView.cellLabel.text = @"收件人地址";
    self.theRecipientAddressView.cellLabel.font = FourteenTypeface;
    self.theRecipientAddressView.cellLabel.textColor = Black;
    self.theRecipientAddressView.describeLabel.font = FourteenTypeface;
    self.theRecipientAddressView.describeLabel.textColor = GrayH1;
    self.theRecipientAddressView.isArrow = YES;
    self.theRecipientAddressView.isSplistLine = YES;
    self.theRecipientAddressView.isCellImage = YES;
    [self.orderInfoBackView addArrangedSubview:self.theRecipientAddressView];
    /** 收件人分割线 */
    self.recipientLineView = [[UIView alloc] init];
    self.recipientLineView.backgroundColor = CLEARCOLOR;
    [self.orderInfoBackView addArrangedSubview:self.recipientLineView];
    /*================== 实付详情  ================*/
    /** 实付详情 */
    self.thePaidView = [[UsedCellView alloc] init];
    self.thePaidView.cellLabel.text = @"实付";
    self.thePaidView.cellLabel.font = FourteenTypeface;
    self.thePaidView.cellLabel.textColor = Black;
    self.thePaidView.describeLabel.font = FourteenTypeface;
    self.thePaidView.describeLabel.textColor = HEXSTR_RGB(@"ef5350");
    self.thePaidView.isArrow = YES;
    self.thePaidView.isSplistLine = YES;
    self.thePaidView.isCellImage = YES;
    [self.orderInfoBackView addArrangedSubview:self.thePaidView];
    /** 实付详情分割线 */
    self.paidLineView = [[UIView alloc] init];
    self.paidLineView.backgroundColor = CLEARCOLOR;
    [self.orderInfoBackView addArrangedSubview:self.paidLineView];

    
//    /** 出保单分割线 */
//    self.paidBtnLineView = [[UIView alloc] init];
//    self.paidBtnLineView.backgroundColor = CLEARCOLOR;
//    [self.orderInfoBackView addArrangedSubview:self.paidBtnLineView];
    
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

    /*================== 用户信息  ================*/
    /** 银行 */
    [self.theInsuranceBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@72);
    }];
    /** 车牌上方 */
    [self.userInfoUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@11);
    }];
    /** 车牌号 */
    [self.theCarNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@22);
    }];
    /** 车型号 */
    [self.theCarTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@22);
    }];
    /** 车牌下方 */
    [self.userInfoDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@11);
    }];
    /** 用户信息分割线 */
    [self.userInfoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.theCarTypeView.mas_bottom).offset(11);
        make.height.mas_equalTo(@10);
    }];
    /** 强制险title */
    [self.theCompulsoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 险种上方留白view */
    [self.compulsoryUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@4);
    }];
    
    /** 强制险header */
    [self.theCompulsoryheaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@36);
    }];
    /** 强制险tab */
    [self.compulsoryInsuranceTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);// mas_equalTo(@(4*48));
    }];
    /** 险种下方留白view */
    [self.compulsoryDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@12);
    }];
    /** 强制险分割线 */
    [self.compulsoryLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
    
    /** 商业险title */
    [self.theBusinessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 商业险header */
    [self.theBusinessheaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.theBusinessView.mas_bottom).offset(4);
        make.height.mas_equalTo(@36);
    }];
    /** 商业险tab */
    [self.businessInsuranceTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);// mas_equalTo(@(4*48));
    }];
    /** 险种下方留白view */
    [self.businessDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@12);
    }];
    /** 商业险分割线 */
    [self.businessLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessInsuranceTable.mas_bottom).offset(0);
        make.height.mas_equalTo(@10);
//        make.width.mas_equalTo(ScreenW);
    }];
    /** 保费上方留白 */
    [self.moneyUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@12);
    }];
    /** 保费合计 */
    [self.theInsuranceAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.businessLineView.mas_bottom).offset(12);
        make.height.mas_equalTo(@30);
    }];
    /** 折扣 */
    [self.theDiscountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
    }];
    /** 折扣下方留白 */
    [self.moneyDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@12);
    }];
    /** 金额分割线 */
    [self.moneyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.theDiscountView.mas_bottom).offset(12);
        make.height.mas_equalTo(@10);
    }];
    /** 到期时间上方留白 */
    [self.timeUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@12);
    }];
    /** 商业险到期tab */
    [self.TimeTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0);// mas_equalTo(@(4*48));
    }];
    /** 到期时间下方留白 */
    [self.timeDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@12);
    }];
    /** 到期时间分割线 */
    [self.timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.TimeTable.mas_bottom).offset(12);
        make.height.mas_equalTo(@10);
    }];
    /** 收件人 */
    [self.theRecipientView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.timeLineView.mas_bottom).offset(12);
        make.height.mas_equalTo(@30);
    }];
    /** 收件人手机号 */
    [self.theRecipientPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
    }];
    /** 收件人地址 */
    [self.theRecipientAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
    }];
    /** 收件人分割线 */
    [self.recipientLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.theRecipientAddressView.mas_bottom).offset(12);
        make.height.mas_equalTo(@10);
    }];
    /** 实付详情 */
    [self.thePaidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 实付详情分割线 */
    [self.paidLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];

    /*================== 没有更多内容了  ================*/
    /** 填充scrollview的view的高度 */
    [self.orderInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.orderInfoScrollView.mas_bottom);
    }];
}
#pragma mark - 询价详情or出险详情
-(void)setWhereFrom:(NSInteger)whereFrom{
    _whereFrom = whereFrom;
    if (whereFrom == 2) {
        [self.thePaidBtnView removeFromSuperview];
        [self.orderInfoBackView removeArrangedSubview:self.thePaidBtnView];
        [self.paidBtnLineView removeFromSuperview];
        [self.orderInfoBackView removeArrangedSubview:self.paidBtnLineView];

    }else if (whereFrom == 1) {
        [self.theRecipientView removeFromSuperview];
        [self.orderInfoBackView removeArrangedSubview:self.theRecipientView];
        [self.theRecipientPhoneView removeFromSuperview];
        [self.orderInfoBackView removeArrangedSubview:self.theRecipientPhoneView];
        [self.theRecipientAddressView removeFromSuperview];
        [self.orderInfoBackView removeArrangedSubview:self.theRecipientAddressView];
        [self.recipientLineView removeFromSuperview];
        [self.orderInfoBackView removeArrangedSubview:self.recipientLineView];
        [self.thePaidView removeFromSuperview];
        [self.orderInfoBackView removeArrangedSubview:self.thePaidView];
        [self.paidLineView removeFromSuperview];
        [self.orderInfoBackView removeArrangedSubview:self.paidLineView];
    }
}
#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.compulsoryInsuranceTable) {
        return self.compulsoryInsuranceTableArray.count;
    }else if (tableView == self.businessInsuranceTable){
        return self.businessInsuranceTableArray.count;
    }else{
        return self.timeTableArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.compulsoryInsuranceTable) {
        static NSString *cellID = @"CompulsoryInsuranceCell";
            CompulsoryInsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil][0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        cell.model = self.compulsoryInsuranceTableArray[indexPath.row];
        return cell;
    }else if (tableView == self.businessInsuranceTable) {
        static NSString *cellID = @"BusinessInsuranceCell";
        BusinessInsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.businessInsuranceTableArray[indexPath.row];
        return cell;
    }else {
        static NSString *cellID = @"TimeCell";
        TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (_whereFrom == 1) {
            cell.endModel = self.timeTableArray[indexPath.row];
        }else {
            cell.startModel = self.timeTableArray[indexPath.row];
        }
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
