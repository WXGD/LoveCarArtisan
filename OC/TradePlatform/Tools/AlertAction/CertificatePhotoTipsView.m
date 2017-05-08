//
//  CertificatePhotoTipsView.m
//  LoveCarEHome
//
//  Created by 爱车e家 on 16/5/10.
//  Copyright © 2016年 爱车e家. All rights reserved.
//

#import "CertificatePhotoTipsView.h"

@interface CertificatePhotoTipsView ()

/** 展示图片 */
@property (nonatomic, strong) UIImageView *payment;

@end

@implementation CertificatePhotoTipsView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.width = [UIScreen mainScreen].bounds.size.width-80;
        self.height = 200;
        self.x = 40;
        if ([UIScreen mainScreen].bounds.size.width == 320) {
            self.y = ([UIScreen mainScreen].bounds.size.height - self.height) / 2 - 100;
        }else {
            self.y = ([UIScreen mainScreen].bounds.size.height - self.height) / 2 - 100;
        }
        [self layoutView];
    }
    return self;
}


#pragma mark - 布局视图
- (void)layoutView {
    if (!_payment) {
        
        self.payment = [[UIImageView alloc] init];
        _payment.image = [UIImage imageNamed:@"驾驶证"];
        _payment.layer.cornerRadius = 5;
        _payment.layer.masksToBounds = YES;
        _payment.userInteractionEnabled = YES;
        [self addSubview:_payment];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _payment.x = 0;
    _payment.y = 0;
    _payment.width = self.width;
    _payment.height = self.height;
}


#pragma mark - 显示
- (void)show {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    _payment.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    _payment.alpha = 0;
    
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _payment.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _payment.alpha = 1.0;
    } completion:nil];
}

#pragma mark - 销毁
- (void)dismiss {
 
    [self removeFromSuperview];
}

@end
