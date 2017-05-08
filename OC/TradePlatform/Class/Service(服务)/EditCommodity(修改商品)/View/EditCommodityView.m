//
//  EditCommodityView.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCommodityView.h"

@implementation EditCommodityView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self editServiceLayoutView];
    }
    return self;
}

- (void)editServiceLayoutView {
    /** 修改信息输入框 */
    self.changeTextField = [[UITextField alloc] init];
    self.changeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.changeTextField setValue:FifteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.changeTextField.font = FifteenTypeface;
    [self addSubview:self.changeTextField];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 修改信息输入框 */
    [self.changeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    /** self高度 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];    
}

#pragma mark - 输入框响应
// 修改商品名称名的输入框限制
- (RACSignal *)changeCommodityNameTextFieldSignal {
    // 获取姓名signal
    RACSignal *commodityNameSignal = self.changeTextField.rac_textSignal;
    // 判断姓名输入框输入位数
    RACSignal *commodityName = [commodityNameSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    return commodityName;
}

// 修改商品原价的输入框限制
- (RACSignal *)changeOriginalPriceTextFieldSignal {
    /** 服务原价 */
    RACSignal *originalPriceSignal = self.changeTextField.rac_textSignal;
    // 判断销售价价格
    RACSignal *originalPrice =
    [originalPriceSignal map:^id(NSString *text) {
        return @([text doubleValue] > 0);
    }];
    return originalPrice;
}
// 修改商品销售价的输入框限制
- (RACSignal *)changePresentPriceTextFieldSignal {
    /** 服务原价 */
    RACSignal *presentPriceSignal = self.changeTextField.rac_textSignal;
    // 判断销售价价格
    RACSignal *presentPrice =
    [presentPriceSignal map:^id(NSString *text) {
        return @([text doubleValue] > 0);
    }];
    return presentPrice;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
