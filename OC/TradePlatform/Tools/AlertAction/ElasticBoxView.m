//
//  ElasticBoxView.m
//  CarRepairMerchant
//
//  Created by apple on 2016/12/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ElasticBoxView.h"

@interface ElasticBoxView ()


@end

@implementation ElasticBoxView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        [self payBoxlayoutView];
    }
    return self;
}

- (void)payBoxlayoutView {
    if (!_boxAlert) {
        
        _boxAlert = [[UIView alloc] init];
        _boxAlert.layer.cornerRadius = 5;
        _boxAlert.layer.masksToBounds = YES;
        _boxAlert.backgroundColor = [UIColor colorWithWhite:1. alpha:.95];
        [self addSubview:_boxAlert];
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"╳" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_boxAlert addSubview:_closeBtn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [_boxAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(40);
        make.right.equalTo(self.mas_right).offset(-40);
    }];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.boxAlert.mas_top);
        make.right.equalTo(self.boxAlert.mas_right);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
}

#pragma mark - 显示
- (void)show {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    _boxAlert.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    _boxAlert.alpha = 0;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _boxAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _boxAlert.alpha = 1.0;
    } completion:nil];
}

#pragma mark - 销毁
- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
        _boxAlert.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        _boxAlert.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
