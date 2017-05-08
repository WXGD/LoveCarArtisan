//
//  UpdateReminderView.m
//  CarRepairFactory
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UpdateReminderView.h"

@interface UpdateReminderView ()

/** 背景view */
@property (nonatomic, strong) UIView *updateReminderBackView;
/** 销毁按钮 */
@property (nonatomic, strong) UIButton *closeBtn;
/** 发现新版本 */
@property (nonatomic, strong) UILabel *versionLabel;
///** 新版本更新内容 */
//@property (nonatomic, strong) UILabel *versionCententLabel;
/** 新版本更新内容 */
@property (nonatomic, strong) UIWebView *versionCententWeb;
/** 更新按钮 */
@property (nonatomic, strong) UIButton *updateBtn;

@end

@implementation UpdateReminderView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        [self payBoxlayoutView];
    }
    return self;
}
#pragma mark - 更新按钮点击方法
// 点击更新跳转到appstore
- (void)updateBtnAction:(UIButton *)button {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionInfo.app_url]];
}
#pragma mark - 更新内容赋值方法
- (void)setVersionInfo:(UpdateReminderModel *)versionInfo {
    _versionInfo = versionInfo;
    _versionLabel.text = versionInfo.title;
    [self.versionCententWeb loadHTMLString:versionInfo.upgrade_info baseURL:nil];
}


- (void)payBoxlayoutView {
    if (!_updateReminderBackView) {
        /** 背景view */
        _updateReminderBackView = [[UIView alloc] init];
        _updateReminderBackView.layer.cornerRadius = 5;
        _updateReminderBackView.layer.masksToBounds = YES;
        _updateReminderBackView.backgroundColor = [UIColor colorWithWhite:1. alpha:.95];
        [self addSubview:_updateReminderBackView];
        /** 销毁按钮 */
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"╳" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_updateReminderBackView addSubview:_closeBtn];
        /** 发现新版本 */
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.font = EighteenTypeface;
        _versionLabel.textColor = BlueColor;
        [_updateReminderBackView addSubview:_versionLabel];
//        /** 新版本更新内容 */
//        _versionCententLabel = [[UILabel alloc] init];
//        _versionCententLabel.font = TwelveTypeface;
//        _versionCententLabel.textColor = BlackText;
//        _versionCententLabel.numberOfLines = 0;
//        [_updateReminderBackView addSubview:_versionCententLabel];
        /** 新版本更新内容 */
        _versionCententWeb = [[UIWebView alloc] init];
        _versionCententWeb.backgroundColor = [UIColor clearColor];
        _versionCententWeb.scrollView.backgroundColor = [UIColor clearColor];
        _versionCententWeb.opaque = NO;
        _versionCententWeb.scrollView.scrollEnabled = NO;
        [_updateReminderBackView addSubview:_versionCententWeb];
        /** 更新按钮 */
        _updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_updateBtn setTitle:@"更新" forState:UIControlStateNormal];
        [_updateBtn setBackgroundColor:ThemeColor];
        [_updateBtn addTarget:self action:@selector(updateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _updateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _updateBtn.layer.masksToBounds = YES;
        _updateBtn.layer.cornerRadius = 5;
        [_updateReminderBackView addSubview:_updateBtn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [_updateReminderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
    }];
    /** 销毁按钮 */
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.updateReminderBackView.mas_top);
        make.right.equalTo(self.updateReminderBackView.mas_right);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
    /** 发现新版本 */
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.updateReminderBackView.mas_top).offset(10);
        make.centerX.equalTo(self.updateReminderBackView.mas_centerX);
    }];
//    /** 新版本更新内容 */
//    [_versionCententLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.top.equalTo(self.versionLabel.mas_bottom).offset(5);
//        make.right.equalTo(self.updateReminderBackView.mas_right).offset(-20);
//        make.left.equalTo(self.updateReminderBackView.mas_left).offset(20);
//    }];
    /** 新版本更新内容 */
    [_versionCententWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.versionLabel.mas_bottom).offset(5);
        make.right.equalTo(self.updateReminderBackView.mas_right).offset(-20);
        make.left.equalTo(self.updateReminderBackView.mas_left).offset(20);
        make.height.mas_equalTo(150);
    }];
    /** 更新按钮 */
    [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.versionCententWeb.mas_bottom).offset(20);
        make.right.equalTo(self.updateReminderBackView.mas_right).offset(-20);
        make.left.equalTo(self.updateReminderBackView.mas_left).offset(20);
        make.height.mas_equalTo(@44);
    }];
    /** 背景view高度 */
    [_updateReminderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.updateBtn.mas_bottom).offset(20);
    }];
}

#pragma mark - 显示
- (void)show {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    _updateReminderBackView.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    _updateReminderBackView.alpha = 0;
    
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _updateReminderBackView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _updateReminderBackView.alpha = 1.0;
    } completion:nil];
}

#pragma mark - 销毁
- (void)dismiss {
    
    [UIView animateWithDuration:0.3f animations:^{
        _updateReminderBackView.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        _updateReminderBackView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
