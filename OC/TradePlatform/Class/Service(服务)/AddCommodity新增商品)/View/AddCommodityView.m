//
//  AddCommodityView.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCommodityView.h"

@interface AddCommodityView ()

/** 名称必填标记 */
@property (strong, nonatomic) UIImageView *nameRequiredMarking;
/** 销售价必填标记 */
@property (strong, nonatomic) UIImageView *presentPriceRequiredMarking;

@end

@implementation AddCommodityView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addCommodityLayoutView];
        // 输入框响应
        [self addCommodityTextFieldSignal];
    }
    return self;
}

- (void)addCommodityLayoutView {
    /** 商品类别 */
    self.commodityCategories = [[UsedCellView alloc] init];
    self.commodityCategories.cellLabel.text = @"类别";
    self.commodityCategories.cellLabel.font = FifteenTypeface;
    self.commodityCategories.cellLabel.textColor = GrayH1;
    self.commodityCategories.describeLabel.font = ThirteenTypeface;
    self.commodityCategories.describeLabel.textColor = Black;
    self.commodityCategories.isSplistLine = YES;
    self.commodityCategories.isCellImage = YES;
    self.commodityCategories.usedCellBtn.tag = CommodityCategoriesBottonAction;
    [self addSubview:self.commodityCategories];
    /** 商品名称 */
    self.commodityName = [[UsedCellView alloc] init];
    self.commodityName.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.commodityName.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.commodityName.viceTextFiled.placeholder = @"请输入名称";
    self.commodityName.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.commodityName.viceTextFiled.textColor = Black;
    self.commodityName.cellLabel.text = @"名称";
    self.commodityName.cellLabel.font = FifteenTypeface;
    self.commodityName.cellLabel.textColor = GrayH1;
    self.commodityName.isSplistLine = YES;
    self.commodityName.isArrow = YES;
    self.commodityName.isCellImage = YES;
    self.commodityName.isCellBtn = YES;
    [self addSubview:self.commodityName];
    /** 名称必填标记 */
    self.nameRequiredMarking = [[UIImageView alloc] init];
    self.nameRequiredMarking.image = [UIImage imageNamed:@"required_marking"];
    [self.commodityName addSubview:self.nameRequiredMarking];
    /** 商品原价 */
    self.commodityOriginalPrice = [[UsedCellView alloc] init];
    self.commodityOriginalPrice.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.commodityOriginalPrice.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.commodityOriginalPrice.viceTextFiled.placeholder = @"请输入原价（选填）";
    self.commodityOriginalPrice.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.commodityOriginalPrice.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.commodityOriginalPrice.viceTextFiled.textColor = Black;
    self.commodityOriginalPrice.cellLabel.text = @"原价";
    self.commodityOriginalPrice.cellLabel.font = FifteenTypeface;
    self.commodityOriginalPrice.cellLabel.textColor = GrayH1;
    self.commodityOriginalPrice.describeLabel.text = @"元";
    self.commodityOriginalPrice.describeLabel.textColor = Black;
    self.commodityOriginalPrice.describeLabel.font = FourteenTypeface;
    self.commodityOriginalPrice.isSplistLine = YES;
    self.commodityOriginalPrice.isArrow = YES;
    self.commodityOriginalPrice.isCellImage = YES;
    self.commodityOriginalPrice.isCellBtn = YES;
    [self addSubview:self.commodityOriginalPrice];
    /** 商品销售价 */
    self.commodityPresentPrice = [[UsedCellView alloc] init];
    self.commodityPresentPrice.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.commodityPresentPrice.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.commodityPresentPrice.viceTextFiled.placeholder = @"请输入售价";
    self.commodityPresentPrice.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.commodityPresentPrice.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.commodityPresentPrice.viceTextFiled.textColor = Black;
    self.commodityPresentPrice.cellLabel.text = @"售价";
    self.commodityPresentPrice.cellLabel.font = FifteenTypeface;
    self.commodityPresentPrice.cellLabel.textColor = GrayH1;
    self.commodityPresentPrice.describeLabel.text = @"元";
    self.commodityPresentPrice.describeLabel.textColor = Black;
    self.commodityPresentPrice.describeLabel.font = FourteenTypeface;
    self.commodityPresentPrice.isSplistLine = YES;
    self.commodityPresentPrice.isArrow = YES;
    self.commodityPresentPrice.isCellImage = YES;
    self.commodityPresentPrice.isCellBtn = YES;
    [self addSubview:self.commodityPresentPrice];
    /** 销售价必填标记 */
    self.presentPriceRequiredMarking = [[UIImageView alloc] init];
    self.presentPriceRequiredMarking.image = [UIImage imageNamed:@"required_marking"];
    [self.commodityPresentPrice addSubview:self.presentPriceRequiredMarking];
    
    
    // 给当前页面添加清扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction)];
    [self addGestureRecognizer:swipeGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 商品类别 */
    [self.commodityCategories mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 商品名称 */
    [self.commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.commodityCategories.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 名称必填标记 */
    [self.nameRequiredMarking mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.commodityName.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.commodityName.cellLabel.mas_centerY);
    }];
    /** 商品销售价 */
    [self.commodityPresentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.commodityName.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 销售价必填标记 */
    [self.presentPriceRequiredMarking mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.commodityPresentPrice.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.commodityPresentPrice.cellLabel.mas_centerY);
    }];
    /** 商品原价 */
    [self.commodityOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.commodityPresentPrice.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
}

#pragma mark - 输入框响应
- (void)addCommodityTextFieldSignal {
    /** 商品名称 */
    RACSignal *commodityNameSignal = self.commodityName.viceTextFiled.rac_textSignal;
    // 判断卡名称输入位数
    RACSignal *commodityName =
    [commodityNameSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    /** 商品销售价 */
    RACSignal *commodityPresentPriceSignal = self.commodityPresentPrice.viceTextFiled.rac_textSignal;
    // 判断商品销售价
    RACSignal *commodityPresentPrice =
    [commodityPresentPriceSignal map:^id(NSString *text) {
        return @([text doubleValue] > 0);
    }];
    // 聚合以上信息
    self.aggregationInfo = [RACSignal combineLatest:@[commodityName, commodityPresentPrice]
                                                   reduce:^id(NSNumber *commodityName, NSNumber *commodityPresentPrice){
                                                       return @([commodityName boolValue]&&[commodityPresentPrice boolValue]);
                                                   }];
}

- (void)swipeGestureAction {
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
