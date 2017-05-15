//
//  ShareView.m
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShareView.h"
#import "ShareOptionBtn.h"

@interface ShareView ()

/** view */
@property (strong, nonatomic) UIView *serviceView;
/** 取消 */
@property (strong, nonatomic) UIButton *cancelBtn;
/** 分享选项 */
@property (strong, nonatomic) UIStackView *shareOptionStackView;
/** 微信分享 */
//@property (strong, nonatomic) ShareOptionBtn *weiXinShareBtn;
/** 手机号分享 */
@property (strong, nonatomic) ShareOptionBtn *phoneShareBtn;
/** 短信分享 */
@property (strong, nonatomic) ShareOptionBtn *smsShareBtn;


@end

@implementation ShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        [self shareViewLayoutView];
    }
    return self;
}

// 分享项目选择按钮
- (void)shareOptionBottonAction:(UIButton *)button {
    
    if (_delegate && [_delegate respondsToSelector:@selector(shareOptionChoiceBtnAction:)]) {
        [_delegate shareOptionChoiceBtnAction:button];
    }
    
    
    switch (button.tag) {
            /** 微信分享 */
        case WeiXinShareBtnAction: {
            
            break;
        }
            /** 手机号分享 */
        case PhoneShareBtnAction: {
            
            break;
        }
            /** 短信分享 */
        case SmsShareBtnAction: {
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - view布局
- (void)shareViewLayoutView {
    /** view */
    self.serviceView = [[UIView alloc] init];
    self.serviceView.backgroundColor = HEXSTR_RGB(@"f5f5f5");
    [self addSubview:self.serviceView];
    /** 取消 */
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = FifteenTypeface;
    self.cancelBtn.backgroundColor = WhiteColor;
    [self.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.serviceView addSubview:self.cancelBtn];
    /** 分享选项 */
    self.shareOptionStackView = [[UIStackView alloc] init];
    self.shareOptionStackView.axis = UILayoutConstraintAxisHorizontal;
    [self.serviceView addSubview:self.shareOptionStackView];
    /** 微信分享 */
//    self.weiXinShareBtn = [[ShareOptionBtn alloc] init];
//    self.weiXinShareBtn.topImage.image = [UIImage imageNamed:@"record_weixin_share"];
//    self.weiXinShareBtn.bomText.text = @"微信分享";
//    self.weiXinShareBtn.backgroundColor = WhiteColor;
//    self.weiXinShareBtn.topBotBtn.tag = WeiXinShareBtnAction;
//    [self.shareOptionStackView addArrangedSubview:self.weiXinShareBtn];
    /** 手机号分享 */
    self.phoneShareBtn = [[ShareOptionBtn alloc] init];
    self.phoneShareBtn.topImage.image = [UIImage imageNamed:@"record_phone_share"];
    self.phoneShareBtn.bomText.text = @"电话分享";
    self.phoneShareBtn.backgroundColor = WhiteColor;
    self.phoneShareBtn.topBotBtn.tag = PhoneShareBtnAction;
    [self.phoneShareBtn.topBotBtn addTarget:self action:@selector(shareOptionBottonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareOptionStackView addArrangedSubview:self.phoneShareBtn];
    /** 短信分享 */
    self.smsShareBtn = [[ShareOptionBtn alloc] init];
    self.smsShareBtn.topImage.image = [UIImage imageNamed:@"record_sms_share"];
    self.smsShareBtn.bomText.text = @"短信分享";
    self.smsShareBtn.backgroundColor = WhiteColor;
    self.smsShareBtn.topBotBtn.tag = SmsShareBtnAction;
    [self.smsShareBtn.topBotBtn addTarget:self action:@selector(shareOptionBottonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareOptionStackView addArrangedSubview:self.smsShareBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** view */
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 取消 */
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.serviceView.mas_bottom);
        make.left.equalTo(self.serviceView.mas_left);
        make.right.equalTo(self.serviceView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 分享选项 */
    [self.shareOptionStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cancelBtn.mas_top).offset(-10);
        make.left.equalTo(self.serviceView.mas_left);
        make.right.equalTo(self.serviceView.mas_right);
        make.height.mas_equalTo(@116);
    }];
    /** 微信分享 */
//    [self.weiXinShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.weiXinShareBtn.mas_width);
//    }];
    /** 手机号分享 */
    [self.phoneShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.phoneShareBtn.mas_width);
    }];
    /** 短信分享 */
    [self.smsShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.phoneShareBtn.mas_width);
    }];
    /** view */
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.shareOptionStackView.mas_top);
    }];
}



#pragma mark - 显示
- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - 销毁
- (void)dismiss {
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
