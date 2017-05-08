//
//  ChangePassworkView.m
//  TradePlatform
//
//  Created by apple on 2017/1/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangePassworkView.h"

@interface ChangePassworkView ()

/** 旧密码 */
@property (strong, nonatomic) UIView *PWOldTFTitle;

/** 新密码 */
@property (strong, nonatomic) UIView *PWNewTFTitle;

/** 确认密码 */
@property (strong, nonatomic) UIView *PWConfirmTFTitle;

@end

@implementation ChangePassworkView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self changePassworkLayoutView];
    }
    return self;
}

- (void)changePassworkLayoutView {
    
    /** 旧密码 */
    /** 修改标记 */
    self.PWOldTitle = [[UILabel alloc] init];
    self.PWOldTitle.font = FifteenTypeface;
    self.PWOldTitle.textColor = Black;
    self.PWOldTitle.text = @"旧密码：";
    [self addSubview:self.PWOldTitle];
    /** 修改信息输入框 */
    self.PWOldTF = [[UITextField alloc] init];
    self.PWOldTF.textAlignment = NSTextAlignmentCenter;
    self.PWOldTF.placeholder = @"请输入6~16位旧密码";
    self.PWOldTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.PWOldTF.secureTextEntry = YES;
    [self addSubview:self.PWOldTF];
    /** 输入框标记 */
    self.PWOldTFTitle = [[UIView alloc] init];
    self.PWOldTFTitle.backgroundColor = VCBackground;
    [self addSubview:self.PWOldTFTitle];
    
    /** 新密码 */
    /** 修改标记 */
    self.PWNewTitle = [[UILabel alloc] init];
    self.PWNewTitle.font = FifteenTypeface;
    self.PWNewTitle.textColor = Black;
    self.PWNewTitle.text = @"新密码：";
    [self addSubview:self.PWNewTitle];
    /** 修改信息输入框 */
    self.PWNewTF = [[UITextField alloc] init];
    self.PWNewTF.textAlignment = NSTextAlignmentCenter;
    self.PWNewTF.placeholder = @"请输入6~16位新密码";
    self.PWNewTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.PWNewTF.secureTextEntry = YES;
    [self addSubview:self.PWNewTF];
    /** 输入框标记 */
    self.PWNewTFTitle = [[UIView alloc] init];
    self.PWNewTFTitle.backgroundColor = VCBackground;
    [self addSubview:self.PWNewTFTitle];
    
    /** 确认密码 */
    /** 修改标记 */
    self.PWConfirmTitle = [[UILabel alloc] init];
    self.PWConfirmTitle.font = FifteenTypeface;
    self.PWConfirmTitle.textColor = Black;
    self.PWConfirmTitle.text = @"确认密码：";
    [self addSubview:self.PWConfirmTitle];
    /** 修改信息输入框 */
    self.PWConfirmTF = [[UITextField alloc] init];
    self.PWConfirmTF.textAlignment = NSTextAlignmentCenter;
    self.PWConfirmTF.placeholder = @"请再次输入6~16位新密码";
    self.PWConfirmTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.PWConfirmTF.secureTextEntry = YES;
    [self addSubview:self.PWConfirmTF];
    /** 输入框标记 */
    self.PWConfirmTFTitle = [[UIView alloc] init];
    self.PWConfirmTFTitle.backgroundColor = VCBackground;
    [self addSubview:self.PWConfirmTFTitle];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 旧密码 */
    /** 修改标记 */
    [self.PWOldTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.mas_top).offset(15);
    }];
    /** 修改信息输入框 */
    [self.PWOldTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.PWOldTitle.mas_centerY);
        make.left.equalTo(self.PWOldTitle.mas_right).offset(10);
        make.width.mas_equalTo(@(180 * WScale));
    }];
    /** 输入框标记 */
    [self.PWOldTFTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.PWOldTF.mas_left);
        make.right.equalTo(self.PWOldTF.mas_right);
        make.bottom.equalTo(self.PWOldTF.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];

    /** 新密码 */
    /** 修改标记 */
    [self.PWNewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.PWOldTitle.mas_bottom).offset(15);
    }];
    /** 修改信息输入框 */
    [self.PWNewTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.PWNewTitle.mas_centerY);
        make.left.equalTo(self.PWNewTitle.mas_right).offset(10);
        make.width.mas_equalTo(@(180 * WScale));
    }];
    /** 输入框标记 */
    [self.PWNewTFTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.PWNewTF.mas_left);
        make.right.equalTo(self.PWNewTF.mas_right);
        make.bottom.equalTo(self.PWNewTF.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
 
    /** 确认密码 */
    /** 修改标记 */
    [self.PWConfirmTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.PWNewTitle.mas_bottom).offset(15);
    }];
    /** 修改信息输入框 */
    [self.PWConfirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.PWConfirmTitle.mas_centerY);
        make.left.equalTo(self.PWConfirmTitle.mas_right).offset(10);
        make.width.mas_equalTo(@(180 * WScale));
    }];
    /** 输入框标记 */
    [self.PWConfirmTFTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.PWConfirmTF.mas_left);
        make.right.equalTo(self.PWConfirmTF.mas_right);
        make.bottom.equalTo(self.PWConfirmTF.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
}


#pragma mark - 输入框响应
// 修改旧密码，新秘密，确认密码的输入框限制
- (RACSignal *)changePassworkTextFieldSignal {
    
    /** 旧密码 */
    // 获取旧密码signal
    RACSignal *PWOldTFSignal = self.PWOldTF.rac_textSignal;
    // 判断旧密码输入框最大输入位数
    RACSignal *PWOldMaxNumber =
    [PWOldTFSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制旧密码输入框可输入位数
    RAC(self.PWOldTF, text) =
    [PWOldMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.PWOldTF.text substringToIndex:16] : self.PWOldTF.text;
    }];
    // 判断旧密码输入框最小输入位数
    RACSignal *PWOldMinNumber =
    [PWOldTFSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    
    /** 新密码 */
    // 获取旧密码signal
    RACSignal *PWNewTFSignal = self.PWNewTF.rac_textSignal;
    // 判断旧密码输入框最大输入位数
    RACSignal *PWNewTFMaxNumber =
    [PWNewTFSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制旧密码输入框可输入位数
    RAC(self.PWNewTF, text) =
    [PWNewTFMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.PWNewTF.text substringToIndex:16] : self.PWNewTF.text;
    }];
    // 判断旧密码输入框最小输入位数
    RACSignal *PWNewTFMinNumber =
    [PWNewTFSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    
    /** 确认密码 */
    // 获取旧密码signal
    RACSignal *PWConfirmTFSignal = self.PWConfirmTF.rac_textSignal;
    // 判断旧密码输入框最大输入位数
    RACSignal *PWConfirmTFMaxNumber =
    [PWConfirmTFSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制旧密码输入框可输入位数
    RAC(self.PWConfirmTF, text) =
    [PWConfirmTFMaxNumber map:^id(NSNumber *passworkNumberTF){
        return [passworkNumberTF boolValue] ? [self.PWConfirmTF.text substringToIndex:16] : self.PWConfirmTF.text;
    }];
    // 判断旧密码输入框最小输入位数
    RACSignal *PWConfirmTFMinNumber =
    [PWConfirmTFSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    // 聚合以上信息
    RACSignal *aggregationInfo = [RACSignal combineLatest:@[PWOldMinNumber, PWNewTFMinNumber, PWConfirmTFMinNumber]
                                             reduce:^id(NSNumber *PWOldMinNumber, NSNumber *PWNewTFMinNumber, NSNumber *PWConfirmTFMinNumber){
                                                 return @([PWOldMinNumber boolValue]&&[PWNewTFMinNumber boolValue]&&[PWConfirmTFMinNumber boolValue]);
                                             }];
    return aggregationInfo;
}


@end
