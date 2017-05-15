//
//  DrivingPermitView.m
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DrivingPermitView.h"

@interface DrivingPermitView ()


@end

@implementation DrivingPermitView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2f];
        [self drivingPermitLayoutView];
    }
    return self;
}


#pragma mark - 布局视图
- (void)drivingPermitLayoutView {
    if (!_drivingPermitImage) {
        self.drivingPermitImage = [[UIImageView alloc] init];
        _drivingPermitImage.userInteractionEnabled = YES;
        [self addSubview:_drivingPermitImage];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.drivingPermitImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).offset(39);
        make.right.equalTo(self.mas_right).offset(-39);
    }];
}


#pragma mark - 显示
- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    _drivingPermitImage.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    _drivingPermitImage.alpha = 0;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _drivingPermitImage.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _drivingPermitImage.alpha = 1.0;
    } completion:nil];
}

#pragma mark - 销毁
- (void)dismiss {
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

@end
