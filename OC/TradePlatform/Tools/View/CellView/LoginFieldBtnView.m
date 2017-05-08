//
//  LoginFieldBtnView.m
//  CarRepairFactory
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginFieldBtnView.h"

@interface LoginFieldBtnView ()

/** 分割线 */
@property (strong, nonatomic) UIView *splistLineView;

@end

@implementation LoginFieldBtnView


- (instancetype)init {
    self = [super init];
    if (self) {
        // 默认 输入框+按钮类型
        self.loginCellStyleType = InputBoxAddButtonType;
        // 默认分割线样式 全屏
        self.loginCellDividingLineType = LoginCellDividingLineFullScreenLayout;
        self.backgroundColor = [UIColor whiteColor];
        [self loginLayoutView];
    }
    return self;
}

- (void)loginLayoutView {
    /** 内容输入框 */
    self.contentField = [[UITextField alloc] init];
    self.contentField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.contentField];
    /** 输入框和按钮分割线 */
    self.tfDividingLine = [[UIView alloc] init];
    self.tfDividingLine.backgroundColor = DividingLine;
    [self addSubview:self.tfDividingLine];
    /** 验证按钮 */
    self.tfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.tfBtn];
    /** view分割线 */
    self.viewDividingLine = [[UIView alloc] init];
    self.viewDividingLine.backgroundColor = DividingLine;
    [self addSubview:self.viewDividingLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.loginCellStyleType) {
            /** 纯输入框类型 */
        case PureTnputBoxType: {
            [self pureTnputBoxType];
            break;
        }
            /** 输入框+按钮类型 */
        case InputBoxAddButtonType: {
            [self inputBoxAddButtonType];
            break;
        }
        default:
            break;
    }
}

/** 纯输入框类型 */
- (void)pureTnputBoxType {
    @weakify(self)
    /** 内容输入框 */
    [self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    /** view分割线 */
    switch (self.loginCellDividingLineType) {
            /** 全屏 */
        case LoginCellDividingLineFullScreenLayout: {
            [self.viewDividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.left.equalTo(self.mas_left);
                make.right.equalTo(self.mas_right);
                make.bottom.equalTo(self.mas_bottom);
                make.height.mas_equalTo(0.5);
            }];
            break;
        }
        default:
            break;
    }
}

/** 输入框+按钮类型 */
- (void)inputBoxAddButtonType {
    @weakify(self)
    /** 验证按钮 */
    [self.tfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-16);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 输入框和按钮分割线 */
    [self.tfDividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.tfBtn.mas_left).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@0.5);
    }];
    /** 内容输入框 */
    [self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.tfDividingLine.mas_left).offset(-16);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** view分割线 */
    switch (self.loginCellDividingLineType) {
            /** 全屏 */
        case LoginCellDividingLineFullScreenLayout: {
            [self.viewDividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.left.equalTo(self.mas_left);
                make.right.equalTo(self.mas_right);
                make.bottom.equalTo(self.mas_bottom);
                make.height.mas_equalTo(@0.5);
            }];
            break;
        }
        default:
            break;
    }
}

@end
