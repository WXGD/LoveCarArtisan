//
//  EditCarInfoView.m
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCarInfoView.h"

@interface EditCarInfoView ()

@end

@implementation EditCarInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self editCarInfoLayoutView];
        /** 修改车牌号的输入框限制 */
        [self editPlnTextFieldSignal];
    }
    return self;
}
#pragma mark - view布局
- (void)editCarInfoLayoutView {
    /** 车牌号 */
    self.editPln = [[CustomCell alloc] init];
    self.editPln.lineStyle = NotLine;
    self.editPln.cellStyle = ViceTFHorizontalLayoutNotMImgAndNotVImg;
    self.editPln.mainLabel.text = @"车牌号：";
    self.editPln.mainLabel.font = FifteenTypeface;
    self.editPln.mainLabel.textColor = Black;
    self.editPln.viceTF.placeholder = @"请输入车牌号";
    self.editPln.viceTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.editPln];
    self.editPln.vTFLeftBorder = 95;
    [self.editPln.mainBtn setHidden:YES];
    /** 品牌车系 */
    self.editCar = [[CustomCell alloc] init];
    self.editCar.lineStyle = NotLine;
    self.editCar.cellStyle = HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    self.editCar.mainLabel.text = @"品牌车系：";
    self.editCar.mainLabel.font = FifteenTypeface;
    self.editCar.mainLabel.textColor = Black;
    [self addSubview:self.editCar];
    /** 品牌图片 */
    self.editCarImage = [[UIImageView alloc] init];
    self.editCarImage.image = [UIImage imageNamed:@"placeholder_car"];
    [self.editCar addSubview:self.editCarImage];
    [self.editCar sendSubviewToBack:self.editCarImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 车牌号 */
    [self.editPln mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 品牌车系 */
    [self.editCar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.editPln.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 品牌图片 */
    [self.editCarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.editCar.mas_centerY);
        make.right.equalTo(self.editCar.rightViceLabel.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
}


/** 修改车牌号的输入框限制 */
- (void)editPlnTextFieldSignal {
    /** 车牌号 */
    RACSignal *plnSignal = self.editPln.viceTF.rac_textSignal;
    // 判断车牌号输入框输入位数
    RACSignal *plnMinNumber = [plnSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    // 判断车牌号输入框输入位数
    RACSignal *plnMaxNumber = [plnSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制车牌号输入框可输入位数
    RAC(self.editPln.viceTF, text) =
    [plnMaxNumber map:^id(NSNumber *plnTF){
        return [plnTF boolValue] ? [self.editPln.viceTF.text substringToIndex:16] : self.editPln.viceTF.text;
    }];
    RACSignal *plnType = [plnSignal map:^id(NSString *text) {
        return @([CustomObject isPlnNumber:text]);
    }];
    // 聚合以上信息
    self.aggregationInfo = [RACSignal combineLatest:@[plnMinNumber, plnType]
                             reduce:^id(NSNumber *plnNumber, NSNumber *plnType){
                                 return @([plnNumber boolValue]&&[plnType boolValue]);
                             }];
}


@end
