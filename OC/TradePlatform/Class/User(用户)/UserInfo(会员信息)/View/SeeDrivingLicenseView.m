//
//  SeeDrivingLicenseView.m
//  TradePlatform
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SeeDrivingLicenseView.h"

@implementation SeeDrivingLicenseView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8f];
        [self seeDrivingLicenseLayoutView];
    }
    return self;
}


#pragma mark - 布局视图
- (void)seeDrivingLicenseLayoutView {
    if (!_drivingLicenseImage) {
        self.drivingLicenseImage = [[UIImageView alloc] init];
        _drivingLicenseImage.userInteractionEnabled = YES;
        _drivingLicenseImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_drivingLicenseImage];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.drivingLicenseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}


#pragma mark - 显示
- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    _drivingLicenseImage.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    _drivingLicenseImage.alpha = 0;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _drivingLicenseImage.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _drivingLicenseImage.alpha = 1.0;
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
