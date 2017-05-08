//
//  NewAddCardView.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewAddCardView.h"

@interface NewAddCardView ()

/** 卡名称 */
@property (strong, nonatomic) UIImageView *cardNamesign;
/** 卡次数/余额 */
@property (strong, nonatomic) UIImageView *cardNumbersign;
/** 卡销售价 */
@property (strong, nonatomic) UIImageView *cardSalesPricesign;
/** 可用服务view */
@property (strong, nonatomic) UIView *canServiceView;
@property (strong, nonatomic) UILabel *canServiceTitleLabel;
@property (strong, nonatomic) UIImageView *arrowImage;

@end

@implementation NewAddCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self newAddCardLayoutView];
        // 输入框响应
//        [self newAddCardTextFieldSignal];
    }
    return self;
}

- (void)newAddCardLayoutView {
    /** 卡名称 */
    self.cardName = [[UsedCellView alloc] init];
    self.cardName.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.cardName.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.cardName.viceTextFiled.placeholder = @"请输入名称";
    self.cardName.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.cardName.viceTextFiled.textColor = Black;
    self.cardName.cellLabel.text = @"名称";
    self.cardName.cellLabel.font = FifteenTypeface;
    self.cardName.cellLabel.textColor = GrayH1;
    self.cardName.dividingLineChoice = DividingLineFullScreenLayout;
    self.cardName.isArrow = YES;
    self.cardName.isCellImage = YES;
    self.cardName.isCellBtn = YES;
    [self addSubview:self.cardName];
    /** 卡名称 */
    self.cardNamesign = [[UIImageView alloc] init];
    self.cardNamesign.image = [UIImage imageNamed:@"required_marking"];
    [self.cardName addSubview:self.cardNamesign];
    /** 卡类型 */
    self.cardType = [[UsedCellView alloc] init];
    self.cardType.cellLabel.text = @"类型";
    self.cardType.cellLabel.font = FifteenTypeface;
    self.cardType.cellLabel.textColor = GrayH1;
    self.cardType.describeLabel.font = ThirteenTypeface;
    self.cardType.describeLabel.textColor = Black;
    self.cardType.dividingLineChoice = DividingLineFullScreenLayout;
    self.cardType.isCellImage = YES;
    self.cardType.usedCellBtn.tag = CardTypeBtnAction;
    [self addSubview:self.cardType];
    /** 卡次数 */
    self.cardNumber = [[UsedCellView alloc] init];
    self.cardNumber.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.cardNumber.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.cardNumber.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.cardNumber.viceTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.cardNumber.viceTextFiled.textColor = Black;
    self.cardNumber.cellLabel.font = FifteenTypeface;
    self.cardNumber.cellLabel.textColor = GrayH1;
    self.cardNumber.isSplistLine = YES;
    self.cardNumber.isArrow = YES;
    self.cardNumber.isCellImage = YES;
    self.cardNumber.isCellBtn = YES;
    [self addSubview:self.cardNumber];
    /** 卡次数/余额 */
    self.cardNumbersign = [[UIImageView alloc] init];
    self.cardNumbersign.image = [UIImage imageNamed:@"required_marking"];
    [self.cardNumber addSubview:self.cardNumbersign];
    /** 卡销售价 */
    self.cardSalesPrice = [[UsedCellView alloc] init];
    self.cardSalesPrice.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.cardSalesPrice.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.cardSalesPrice.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.cardSalesPrice.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.cardSalesPrice.viceTextFiled.placeholder = @"请输入会员卡售价";
    self.cardSalesPrice.viceTextFiled.textColor = Black;
    self.cardSalesPrice.cellLabel.text = @"售价";
    self.cardSalesPrice.cellLabel.font = FifteenTypeface;
    self.cardSalesPrice.cellLabel.textColor = GrayH1;
    self.cardSalesPrice.dividingLineChoice = DividingLineFullScreenLayout;
    self.cardSalesPrice.isArrow = YES;
    self.cardSalesPrice.isCellImage = YES;
    self.cardSalesPrice.isCellBtn = YES;
    [self addSubview:self.cardSalesPrice];
    /** 卡销售价 */
    self.cardSalesPricesign = [[UIImageView alloc] init];
    self.cardSalesPricesign.image = [UIImage imageNamed:@"required_marking"];
    [self.cardSalesPrice addSubview:self.cardSalesPricesign];
    /** 卡原价 */
    self.cardOriginalPrice = [[UsedCellView alloc] init];
    self.cardOriginalPrice.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.cardOriginalPrice.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.cardOriginalPrice.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.cardOriginalPrice.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.cardOriginalPrice.viceTextFiled.placeholder = @"请输入会员卡原价";
    self.cardOriginalPrice.viceTextFiled.textColor = Black;
    self.cardOriginalPrice.cellLabel.text = @"原价";
    self.cardOriginalPrice.cellLabel.font = FifteenTypeface;
    self.cardOriginalPrice.cellLabel.textColor = GrayH1;
    self.cardOriginalPrice.isSplistLine = YES;
    self.cardOriginalPrice.isArrow = YES;
    self.cardOriginalPrice.isCellImage = YES;
    self.cardOriginalPrice.isCellBtn = YES;
    [self addSubview:self.cardOriginalPrice];
    /** 卡适用范围 */
    /** 可用服务view */
    self.canServiceView = [[UIView alloc] init];
    self.canServiceView.backgroundColor = WhiteColor;
    [self addSubview:self.canServiceView];
    
    self.canServiceTitleLabel = [[UILabel alloc] init];
    self.canServiceTitleLabel.text = @"可用服务";
    self.canServiceTitleLabel.textColor = GrayH1;
    self.canServiceTitleLabel.font = FifteenTypeface;
    [self.canServiceView addSubview:self.canServiceTitleLabel];
    
    self.canServiceContentLabel = [[UILabel alloc] init];
    self.canServiceContentLabel.textColor = Black;
    self.canServiceContentLabel.font = ThirteenTypeface;
    self.canServiceContentLabel.textAlignment = NSTextAlignmentRight;
    self.canServiceContentLabel.text = @"全部服务";
    self.canServiceContentLabel.numberOfLines = 0;
    [self.canServiceView addSubview:self.canServiceContentLabel];
    
    self.arrowImage = [[UIImageView alloc] init];
    self.arrowImage.image = [UIImage imageNamed:@"right_arrow"];
    [self.canServiceView addSubview:self.arrowImage];
    
    self.canServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canServiceBtn.tag = CardApplyBtnAction;
    [self.canServiceView addSubview:self.canServiceBtn];

    
    // 给当前页面添加清扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction)];
    [self addGestureRecognizer:swipeGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 卡名称 */
    [self.cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@50);
    }];
    /** 名称必填标记 */
    [self.cardNamesign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cardName.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.cardName.cellLabel.mas_centerY);
    }];
    
    /** 卡类型 */
    [self.cardType mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.cardName.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 卡次数 */
    [self.cardNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.cardType.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 卡次数/余额必填标记 */
    [self.cardNumbersign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cardNumber.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.cardNumber.cellLabel.mas_centerY);
    }];
    /** 卡销售价 */
    [self.cardSalesPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.cardNumber.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 卡销售价必填标记 */
    [self.cardSalesPricesign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cardSalesPrice.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.cardSalesPrice.cellLabel.mas_centerY);
    }];
    /** 卡原价 */
    [self.cardOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.cardSalesPrice.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 卡适用范围 */
    [self.canServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardOriginalPrice.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.canServiceContentLabel.mas_bottom).offset(18);
    }];
    [self.canServiceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.canServiceView.mas_top).offset(16);
        make.left.equalTo(self.canServiceView.mas_left).offset(16);
        make.width.mas_equalTo(@61.5);
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.canServiceTitleLabel.mas_centerY);
        make.right.equalTo(self.canServiceView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self.canServiceContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.canServiceTitleLabel.mas_top).offset(2);
        make.left.equalTo(self.canServiceTitleLabel.mas_right).offset(28);
        make.right.equalTo(self.arrowImage.mas_left).offset(-16);
    }];
    [self.canServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.canServiceView.mas_top);
        make.left.equalTo(self.canServiceView.mas_left);
        make.right.equalTo(self.canServiceView.mas_right);
        make.bottom.equalTo(self.canServiceView.mas_bottom);
    }];
}


//#pragma mark - 输入框响应
//- (void)newAddCardTextFieldSignal {
//    /** 卡名称 */
//    RACSignal *cardNameSignal = self.cardName.viceTextFiled.rac_textSignal;
//    // 判断卡名称输入位数
//    RACSignal *cardName =
//    [cardNameSignal map:^id(NSString *text) {
//        return @(text.length > 0);
//    }];
//
//    /** 卡次数 */
//    RACSignal *cardNumberSignal = self.cardNumber.viceTextFiled.rac_textSignal;
//    // 判断卡次数输入位数
//    RACSignal *cardNumber =
//    [cardNumberSignal map:^id(NSString *text) {
//        return @([text integerValue] > 0);
//    }];
//
//    /** 卡销售价 */
//    RACSignal *cardSalesPriceSignal = self.cardSalesPrice.viceTextFiled.rac_textSignal;
//    // 判断余额输入位数
//    RACSignal *cardSalesPrice =
//    [cardSalesPriceSignal map:^id(NSString *text) {
//        return @([text floatValue] > 0);
//    }];
//    // 聚合以上信息
//    self.aggregationInfo = [RACSignal combineLatest:@[cardName, cardNumber, cardSalesPrice]
//                                                        reduce:^id(NSNumber *cardName, NSNumber *cardNumber, NSNumber *cardSalesPrice){
//                                                            return @([cardName boolValue]&&[cardNumber boolValue]&&[cardSalesPrice boolValue]);
//                                                        }];
//}

- (void)swipeGestureAction {
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
