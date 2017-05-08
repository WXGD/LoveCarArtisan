//
//  ChangeCarInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangeCarInfoView.h"

@implementation ChangeCarInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self changeCarInfoLayoutView];
        [self changePlnTextFieldSignal];
    }
    return self;
}
#pragma mark - view布局
- (void)changeCarInfoLayoutView {
    /** 车牌号 */
    self.editPln = [[UsedCellView alloc] init];
    self.editPln.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.editPln.cellLabel.text = @"车牌号：";
    self.editPln.cellLabel.font = FifteenTypeface;
    self.editPln.viceTextFiled.placeholder = @"请输入车牌号";
    self.editPln.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.editPln.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.editPln.isSplistLine = YES;
    self.editPln.isArrow = YES;
    self.editPln.isCellImage = YES;
    self.editPln.isCellBtn = YES;
    [self addSubview:self.editPln];
    /** 品牌车系 */
    self.editCar = [[UsedCellView alloc] init];
    self.editCar.usedCellTypeChoice = DescribeImageTextHorizontalLayout;
    self.editCar.cellLabel.text = @"品牌车系：";
    self.editCar.cellLabel.font = FifteenTypeface;
    self.editCar.viceLabel.text = @"请选择品牌车系";
    self.editCar.describeImageSize = CGSizeMake(35, 35);
    self.editCar.isSplistLine = YES;
    self.editCar.isCellImage = YES;
    [self addSubview:self.editCar];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 车牌号 */
    [self.editPln mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@50);
    }];
    /** 品牌车系 */
    [self.editCar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.editPln.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];

}


/** 修改车牌号的输入框限制 */
- (RACSignal *)changePlnTextFieldSignal {
    /** 车牌号 */
    RACSignal *plnSignal = self.editPln.viceTextFiled.rac_textSignal;
    // 判断车牌号输入框输入位数
    RACSignal *plnMinNumber = [plnSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    // 判断车牌号输入框输入位数
    RACSignal *plnMaxNumber = [plnSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制车牌号输入框可输入位数
    RAC(self.editPln.viceTextFiled, text) =
    [plnMaxNumber map:^id(NSNumber *plnTF){
        return [plnTF boolValue] ? [self.editPln.viceTextFiled.text substringToIndex:16] : self.editPln.viceTextFiled.text;
    }];
    
    RACSignal *plnType = [plnSignal map:^id(NSString *text) {
        return @([CustomObject isPlnNumber:text]);
    }];
    // 聚合以上信息
    return [RACSignal combineLatest:@[plnMinNumber, plnType]
                                       reduce:^id(NSNumber *plnNumber, NSNumber *plnType){
                                           return @([plnNumber boolValue]&&[plnType boolValue]);
                                       }];
}


@end
