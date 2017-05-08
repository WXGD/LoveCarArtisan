//
//  EditCommodityWholeView.m
//  TradePlatform
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCommodityWholeView.h"

@interface EditCommodityWholeView ()

@end

@implementation EditCommodityWholeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self editCommodityLayoutView];
        // 输入框响应
        [self editCommodityTextFieldSignal];
    }
    return self;
}

- (void)editCommodityLayoutView {
    /** 商品名称 */
    self.editCommodityName = [[UsedCellView alloc] init];
    self.editCommodityName.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.editCommodityName.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.editCommodityName.viceTextFiled.placeholder = @"请输入名称";
    self.editCommodityName.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.editCommodityName.viceTextFiled.textColor = Black;
    self.editCommodityName.cellLabel.text = @"名称";
    self.editCommodityName.cellLabel.font = FifteenTypeface;
    self.editCommodityName.cellLabel.textColor = GrayH1;
    self.editCommodityName.isSplistLine = YES;
    self.editCommodityName.isArrow = YES;
    self.editCommodityName.isCellImage = YES;
    self.editCommodityName.isCellBtn = YES;
    [self addSubview:self.editCommodityName];
    /** 商品原价 */
    self.editCommodityOriginalPrice = [[UsedCellView alloc] init];
    self.editCommodityOriginalPrice.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.editCommodityOriginalPrice.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.editCommodityOriginalPrice.viceTextFiled.placeholder = @"请输入原价（选填）";
    self.editCommodityOriginalPrice.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.editCommodityOriginalPrice.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.editCommodityOriginalPrice.viceTextFiled.textColor = Black;
    self.editCommodityOriginalPrice.cellLabel.text = @"原价";
    self.editCommodityOriginalPrice.cellLabel.font = FifteenTypeface;
    self.editCommodityOriginalPrice.cellLabel.textColor = GrayH1;
    self.editCommodityOriginalPrice.describeLabel.text = @"元";
    self.editCommodityOriginalPrice.describeLabel.textColor = Black;
    self.editCommodityOriginalPrice.describeLabel.font = FourteenTypeface;
    self.editCommodityOriginalPrice.isSplistLine = YES;
    self.editCommodityOriginalPrice.isArrow = YES;
    self.editCommodityOriginalPrice.isCellImage = YES;
    self.editCommodityOriginalPrice.isCellBtn = YES;
    [self addSubview:self.editCommodityOriginalPrice];
    /** 商品销售价 */
    self.editCommodityPresentPrice = [[UsedCellView alloc] init];
    self.editCommodityPresentPrice.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.editCommodityPresentPrice.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.editCommodityPresentPrice.viceTextFiled.placeholder = @"请输入售价";
    self.editCommodityPresentPrice.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.editCommodityPresentPrice.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.editCommodityPresentPrice.viceTextFiled.textColor = Black;
    self.editCommodityPresentPrice.cellLabel.text = @"售价";
    self.editCommodityPresentPrice.cellLabel.font = FifteenTypeface;
    self.editCommodityPresentPrice.cellLabel.textColor = GrayH1;
    self.editCommodityPresentPrice.describeLabel.text = @"元";
    self.editCommodityPresentPrice.describeLabel.textColor = Black;
    self.editCommodityPresentPrice.describeLabel.font = FourteenTypeface;
    self.editCommodityPresentPrice.isSplistLine = YES;
    self.editCommodityPresentPrice.isArrow = YES;
    self.editCommodityPresentPrice.isCellImage = YES;
    self.editCommodityPresentPrice.isCellBtn = YES;
    [self addSubview:self.editCommodityPresentPrice];
    
    // 给当前页面添加清扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction)];
    [self addGestureRecognizer:swipeGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 商品名称 */
    [self.editCommodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 商品销售价 */
    [self.editCommodityPresentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.editCommodityName.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 商品原价 */
    [self.editCommodityOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.editCommodityPresentPrice.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
}

#pragma mark - 输入框响应
- (void)editCommodityTextFieldSignal {
    /** 商品名称 */
    RACSignal *editCommodityNameSignal = self.editCommodityName.viceTextFiled.rac_textSignal;
    // 判断卡名称输入位数
    RACSignal *editCommodityName =
    [editCommodityNameSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    /** 商品销售价 */
    RACSignal *editCommodityPresentPriceSignal = self.editCommodityPresentPrice.viceTextFiled.rac_textSignal;
    // 判断商品销售价
    RACSignal *editCommodityPresentPrice =
    [editCommodityPresentPriceSignal map:^id(NSString *text) {
        return @([text doubleValue] > 0);
    }];
    /** 商品原价 */
    RACSignal *editCommodityOriginalPriceSignal = self.editCommodityPresentPrice.viceTextFiled.rac_textSignal;
    // 判断商品原价
    RACSignal *editCommodityOriginalPrice =
    [editCommodityOriginalPriceSignal map:^id(NSString *text) {
        if (text.length != 0) {
            return @([text doubleValue] > 0);
        }else {
            return @(1);
        }
        
    }];
//    // 判断商品原价
//    RACSignal *editCommodityOriginalPriceLength =
//    [editCommodityOriginalPriceSignal map:^id(NSString *text) {
//        return @(text.length == 0);
//    }];
//    RACSignal *editOriginalPriceLength = [RACSignal combineLatest:@[editCommodityOriginalPrice, editCommodityOriginalPriceLength]
//                      reduce:^id(NSNumber *editCommodityOriginalPrice, NSNumber *editCommodityOriginalPriceLength){
//                          return @([editCommodityOriginalPrice boolValue] || [editCommodityOriginalPriceLength boolValue]);
//                      }];
    // 聚合以上信息
    self.editAggregationInfo = [RACSignal combineLatest:@[editCommodityName, editCommodityPresentPrice, editCommodityOriginalPrice]
                                             reduce:^id(NSNumber *editCommodityName, NSNumber *editCommodityPresentPrice, NSNumber *editCommodityOriginalPrice){
                                                 return @([editCommodityName boolValue] || [editCommodityPresentPrice boolValue] || [editCommodityOriginalPrice boolValue]);
                                             }];
}

- (void)swipeGestureAction {
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
