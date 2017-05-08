//
//  AddSubNumView.m
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddSubNumView.h"

@interface AddSubNumView ()


@end

@implementation AddSubNumView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubNumLayoutView];
    }
    return self;
}
// 加
- (void)addBtnAction:(UIButton *)button {
    NSInteger num = [self.numTF.text integerValue];
    num += 1;
    self.numTF.text = [NSString stringWithFormat:@"%ld", num];
    [self.subBtn setHidden:NO];
    if (_delegate && [_delegate respondsToSelector:@selector(addSubBtnDelegate:)]) {
        [_delegate addSubBtnDelegate:button];
    }
}
// 减
- (void)subBtnAction:(UIButton *)button {
    NSInteger num = [self.numTF.text integerValue];
    num -= 1;
    if (num == 1) {
        [self.subBtn setHidden:YES];
    }
    self.numTF.text = [NSString stringWithFormat:@"%ld", num];
    if (_delegate && [_delegate respondsToSelector:@selector(addSubBtnDelegate:)]) {
        [_delegate addSubBtnDelegate:button];
    }
}
/** 数量 */
- (void)setNumStr:(NSString *)numStr {
    _numStr = numStr;
    NSInteger num = [numStr integerValue];
    if (num == 1) {
        [self.subBtn setHidden:YES];
    }else {
        [self.subBtn setHidden:NO];
    }
    self.numTF.text = [NSString stringWithFormat:@"%@", numStr];
}


- (void)addSubNumLayoutView {
    /** 数量 */
    self.numTF = [[UITextField alloc] init];
    self.numTF.text = @"1";
    self.numTF.userInteractionEnabled = NO;
    [self addSubview:self.numTF];
    /** 加号 */
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setImage:[UIImage imageNamed:@"cashier_add"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addBtn];
    /** 减号 */
    self.subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.subBtn setImage:[UIImage imageNamed:@"cashier_sub"] forState:UIControlStateNormal];
    [self.subBtn addTarget:self action:@selector(subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.subBtn];
    [self.subBtn setHidden:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 减号 */
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    /** 数量 */
    [self.numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.subBtn.mas_centerY);
        make.left.equalTo(self.subBtn.mas_right);
    }];
    /** 加号 */
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.subBtn.mas_centerY);
        make.left.equalTo(self.numTF.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.addBtn.mas_right);
        make.bottom.equalTo(self.addBtn.mas_bottom);
    }];
}

@end
