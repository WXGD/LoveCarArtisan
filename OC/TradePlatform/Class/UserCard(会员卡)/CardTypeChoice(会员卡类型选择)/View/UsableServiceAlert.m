//
//  UsableServiceAlert.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsableServiceAlert.h"

@interface UsableServiceAlert ()

/** 弹框标记图片 */
@property (nonatomic, strong) UIImageView *alertSigImage;
/** 弹框背景图片 */
@property (nonatomic, strong) UIImageView *alertBackImage;
/** 可用服务标题 */
@property (nonatomic, strong) UILabel *usableServiceTitleLabel;
/** 分割线 */
@property (nonatomic, strong) UIView *dividingLineView;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation UsableServiceAlert

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
    
    /** 弹框背景图片 */
    self.alertBackImage = [[UIImageView alloc] init];
    self.alertBackImage.image = [UIImage imageNamed:@"open_card_alert_back"];
    self.alertBackImage.userInteractionEnabled = YES;
    [self addSubview:self.alertBackImage];
    /** 弹框标记图片 */
    self.alertSigImage = [[UIImageView alloc] init];
    self.alertSigImage.image = [UIImage imageNamed:@"open_card_alert_sign"];
    self.alertSigImage.userInteractionEnabled = YES;
    [self.alertBackImage addSubview:self.alertSigImage];
    /** 可用服务标题 */
    self.usableServiceTitleLabel = [[UILabel alloc] init];
    self.usableServiceTitleLabel.text = @"可用服务";
    self.usableServiceTitleLabel.font = EighteenTypefaceBold;
    self.usableServiceTitleLabel.textColor = Black;
    [self.alertBackImage addSubview:self.usableServiceTitleLabel];
    /** 可用服务内容 */
    self.usableServiceContentLabel = [[UILabel alloc] init];
    self.usableServiceContentLabel.font = FourteenTypeface;
    self.usableServiceContentLabel.textColor = GrayH1;
    self.usableServiceContentLabel.numberOfLines = 0;
    [self.alertBackImage addSubview:self.usableServiceContentLabel];
    /** 分割线 */
    self.dividingLineView = [[UIImageView alloc] init];
    self.dividingLineView.backgroundColor = DividingLine;
    [self addSubview:self.dividingLineView];
    /** 确定按钮 */
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = EighteenTypeface;
    [self.confirmBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.alertBackImage addSubview:self.confirmBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 弹框背景图片 */
    [self.alertBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(@(320 * WScale));
        make.bottom.equalTo(self.confirmBtn.mas_bottom);
    }];
    /** 弹框标记图片 */
    [self.alertSigImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.alertBackImage.mas_top).offset(32);
    }];
    /** 可用服务标题 */
    [self.usableServiceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.alertSigImage.mas_bottom).offset(15);
        make.centerX.equalTo(self.mas_centerX);
    }];
    /** 可用服务内容 */
    [self.usableServiceContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usableServiceTitleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.alertBackImage.mas_left).offset(24);
        make.right.equalTo(self.alertBackImage.mas_right).offset(-24);
    }];
    /** 分割线 */
    [self.dividingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usableServiceContentLabel.mas_bottom).offset(32);
        make.left.equalTo(self.alertBackImage.mas_left).offset(0);
        make.right.equalTo(self.alertBackImage.mas_right).offset(-0);
        make.height.mas_equalTo(@0.5);
    }];
    /** 确定按钮 */
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.dividingLineView.mas_bottom);
        make.left.equalTo(self.alertBackImage.mas_left);
        make.right.equalTo(self.alertBackImage.mas_right);
        make.height.mas_equalTo(@51);
    }];
}

#pragma mark - 显示
- (void)show {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.alertBackImage.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.alertBackImage.alpha = 0;
    
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alertBackImage.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.alertBackImage.alpha = 1.0;
    } completion:nil];
}

#pragma mark - 销毁
- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
        self.alertBackImage.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        self.alertBackImage.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end

