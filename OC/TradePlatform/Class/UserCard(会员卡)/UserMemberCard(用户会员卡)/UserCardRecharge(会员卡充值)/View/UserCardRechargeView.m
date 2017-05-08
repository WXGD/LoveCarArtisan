//
//  UserCardRechargeView.m
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCardRechargeView.h"

@interface UserCardRechargeView ()

/** 头部背景view */
@property (strong, nonatomic) UIView *headerView;

/** 余次/余额充值必填标记 */
@property (strong, nonatomic) UIImageView *recNoreSign;
/** 实收金额必填标记 */
@property (strong, nonatomic) UIImageView *netReceSign;

@end

@implementation UserCardRechargeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self userCardRechargeLayoutView];
        // 输入框响应
        [self userCardRechargeTextFieldSignal];
    }
    return self;
}

- (void)userCardRechargeLayoutView {
//    /** 头部背景view */
//    self.headerView = [[UIView alloc] init];
//    self.headerView.backgroundColor = ThemeColor;
//    [self addSubview:self.headerView];
//    /** 卡号 */
//    self.recCardNum = [[UsedCellView alloc] init];
//    self.recCardNum.backgroundColor = CLEARCOLOR;
//    self.recCardNum.cellLabel.text = @"卡号";
//    self.recCardNum.cellLabel.font = FourteenTypeface;
//    self.recCardNum.cellLabel.textColor = RGBA(255, 255, 255, 0.8);
//    self.recCardNum.describeLabel.textColor = WhiteColor;
//    self.recCardNum.describeLabel.font = FourteenTypeface;
//    self.recCardNum.isArrow = YES;
//    self.recCardNum.isCellImage = YES;
//    self.recCardNum.isSplistLine = YES;
//    [self.headerView addSubview:self.recCardNum];
//    /** 余次/余额 */
//    self.recNoreThan = [[UsedCellView alloc] init];
//    self.recNoreThan.backgroundColor = CLEARCOLOR;
//    self.recNoreThan.cellLabel.text = @"余次";
//    self.recNoreThan.cellLabel.font = FourteenTypeface;
//    self.recNoreThan.cellLabel.textColor = RGBA(255, 255, 255, 0.8);
//    self.recNoreThan.describeLabel.textColor = WhiteColor;
//    self.recNoreThan.describeLabel.font = FourteenTypeface;
//    self.recNoreThan.isArrow = YES;
//    self.recNoreThan.isCellImage = YES;
//    self.recNoreThan.isSplistLine = YES;
//    [self.headerView addSubview:self.recNoreThan];
//    /** 手机号 */
//    self.recUserPhone = [[UsedCellView alloc] init];\
//    self.recUserPhone.backgroundColor = CLEARCOLOR;
//    self.recUserPhone.cellLabel.text = @"手机号";
//    self.recUserPhone.cellLabel.font = FourteenTypeface;
//    self.recUserPhone.cellLabel.textColor = RGBA(255, 255, 255, 0.8);
//    self.recUserPhone.describeLabel.textColor = WhiteColor;
//    self.recUserPhone.describeLabel.font = FourteenTypeface;
//    self.recUserPhone.isArrow = YES;
//    self.recUserPhone.isCellImage = YES;
//    self.recUserPhone.isSplistLine = YES;
//    [self.headerView addSubview:self.recUserPhone];
    /** 余次/余额充值 */
    self.recNoreThanRecharge = [[UsedCellView alloc] init];
    self.recNoreThanRecharge.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.recNoreThanRecharge.cellLabel.font = FifteenTypeface;
    self.recNoreThanRecharge.cellLabel.textColor = GrayH1;
    self.recNoreThanRecharge.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.recNoreThanRecharge.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.recNoreThanRecharge.viceTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.recNoreThanRecharge.viceTextFiled.font = FourteenTypeface;
    self.recNoreThanRecharge.viceTextFiled.textColor = Black;
    self.recNoreThanRecharge.dividingLineChoice = DividingLineFullScreenLayout;
    self.recNoreThanRecharge.isArrow = YES;
    self.recNoreThanRecharge.isCellImage = YES;
    self.recNoreThanRecharge.isCellBtn = YES;
    [self addSubview:self.recNoreThanRecharge];
    /** 余次/余额充值必填标记 */
    self.recNoreSign = [[UIImageView alloc] init];
    self.recNoreSign.image = [UIImage imageNamed:@"required_marking"];
    [self.recNoreThanRecharge addSubview:self.recNoreSign];

    /** 实收金额 */
    self.netReceiptsMoney = [[UsedCellView alloc] init];
    self.netReceiptsMoney.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.netReceiptsMoney.cellLabel.text = @"实收金额";
    self.netReceiptsMoney.cellLabel.font = FifteenTypeface;
    self.netReceiptsMoney.cellLabel.textColor = GrayH1;
    self.netReceiptsMoney.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.netReceiptsMoney.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.netReceiptsMoney.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.netReceiptsMoney.viceTextFiled.placeholder = @"请输入实收金额";
    self.netReceiptsMoney.viceTextFiled.font = FourteenTypeface;
    self.netReceiptsMoney.viceTextFiled.textColor = Black;
    self.netReceiptsMoney.isArrow = YES;
    self.netReceiptsMoney.isCellImage = YES;
    self.netReceiptsMoney.isSplistLine = YES;
    self.netReceiptsMoney.isCellBtn = YES;
    [self addSubview:self.netReceiptsMoney];
    /** 实收金额必填标记 */
    self.netReceSign = [[UIImageView alloc] init];
    self.netReceSign.image = [UIImage imageNamed:@"required_marking"];
    [self.netReceiptsMoney addSubview:self.netReceSign];
    
    /** 服务师傅view */
    self.serviceMasterView = [[UsedCellView alloc] init];
    [self.serviceMasterView.arrowImage setImage:[UIImage imageNamed:@"bottom_arrow_gray"] forState:UIControlStateNormal];
    self.serviceMasterView.backgroundColor = WhiteColor;
    self.serviceMasterView.cellLabel.text = @"服务师傅";
    self.serviceMasterView.cellLabel.textColor = GrayH1;
    self.serviceMasterView.cellLabel.font = FifteenTypeface;
    self.serviceMasterView.describeLabel.font = FourteenTypeface;
    self.serviceMasterView.describeLabel.text = @"请选择服务师傅";
    self.serviceMasterView.describeLabel.textColor = Black;
    self.serviceMasterView.isSplistLine = YES;
    self.serviceMasterView.isCellImage = YES;
    [self addSubview:self.serviceMasterView];
    /** 确认充值 */
    self.confirmRechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmRechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    self.confirmRechargeBtn.titleLabel.font = FifteenTypeface;
    [self.confirmRechargeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.confirmRechargeBtn.backgroundColor = ThemeColor;
    self.confirmRechargeBtn.layer.masksToBounds = YES;
    self.confirmRechargeBtn.layer.cornerRadius = 2;
    [self addSubview:self.confirmRechargeBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
//    /** 头部背景view */
//    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.recUserPhone.cellLabel.mas_bottom).offset(20);
//    }];
//    /** 卡号 */
//    [self.recCardNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.headerView.mas_top).offset(20);
//        make.bottom.equalTo(self.recCardNum.cellLabel.mas_bottom);
//    }];
//    /** 余次/余额 */
//    [self.recNoreThan mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.recCardNum.mas_bottom).offset(16);
//        make.bottom.equalTo(self.recNoreThan.cellLabel.mas_bottom);
//    }];
//    /** 手机号 */
//    [self.recUserPhone mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.recNoreThan.mas_bottom).offset(16);
//        make.bottom.equalTo(self.recUserPhone.cellLabel.mas_bottom);
//    }];
    
    /** 余次/余额充值 */
    [self.recNoreThanRecharge mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 余次/余额充值必填标记 */
    [self.recNoreSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.recNoreThanRecharge.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.recNoreThanRecharge.cellLabel.mas_centerY);
    }];
    
    /** 实收金额 */
    [self.netReceiptsMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.recNoreThanRecharge.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 实收金额必填标记 */
    [self.netReceSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.netReceiptsMoney.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.netReceiptsMoney.cellLabel.mas_centerY);
    }];
    /** 服务师傅view */
    [self.serviceMasterView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.netReceiptsMoney.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 确认充值 */
    [self.confirmRechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.serviceMasterView.mas_bottom).offset(24);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@44);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - 输入框响应
- (void)userCardRechargeTextFieldSignal {
    /** 余次/余额充值 */
    RACSignal *noreThanSignal = self.recNoreThanRecharge.viceTextFiled.rac_textSignal;
    // 判断余次/余额输入
    RACSignal *noreThan =
    [noreThanSignal map:^id(NSString *text) {
        return @([text doubleValue] > 0);
    }];
    // 实收金额
    RACSignal *netReceiptsSignal = self.netReceiptsMoney.viceTextFiled.rac_textSignal;
    // 判断余次/余额输入
    RACSignal *netReceipts =
    [netReceiptsSignal map:^id(NSString *text) {
        return @([text doubleValue] > 0);
    }];    
    // 聚合余次/余额充值和实收金额
    RACSignal *allInfoSignal = [RACSignal combineLatest:@[noreThan, netReceipts]
                                                        reduce:^id(NSNumber *noreThan, NSNumber *netReceipts){
                                                            return @([noreThan boolValue]&&[netReceipts boolValue]);
                                                        }];
    
    // 根据输入框，修改确认充值是否可点击属性
    RAC(self.confirmRechargeBtn, enabled) =
    [allInfoSignal map:^id(NSNumber *textField){
        return@([textField boolValue]);
    }];
    // 根据账户输入框，修改确认充值是否可点击属性
    RAC(self.confirmRechargeBtn, backgroundColor) =
    [allInfoSignal map:^id(NSNumber *accountNumberTF){
        return[accountNumberTF boolValue] ? ThemeColor:RGB(221, 221, 221);
    }];
}


@end
