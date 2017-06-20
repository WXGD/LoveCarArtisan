//
//  ChangeStartEndTimeView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangeStartEndTimeView.h"

@implementation ChangeStartEndTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self changeTimeLayoutView];
    }
    return self;
}

- (void)changeTimeLayoutView {
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = WhiteColor;
    [self addSubview:self.bgView];
    
    self.startTf = [[UITextField alloc] init];
    self.startTf.placeholder = @"请选择起始时间";
    self.startTf.textAlignment = NSTextAlignmentCenter;
    self.startTf.backgroundColor = HEXSTR_RGB(@"f5f5f5");
    self.startTf.layer.cornerRadius = 2;
    self.startTf.clipsToBounds = YES;
    self.startTf.font = FourteenTypeface;
    [self addSubview:self.startTf];
    
    self.endTf = [[UITextField alloc] init];
    self.endTf.placeholder = @"请选择结束时间";
    self.endTf.textAlignment = NSTextAlignmentCenter;
    self.endTf.backgroundColor = HEXSTR_RGB(@"f5f5f5");
    self.endTf.layer.cornerRadius = 2;
    self.endTf.clipsToBounds = YES;
    self.endTf.font = FourteenTypeface;
    [self addSubview:self.endTf];
    
    self.image = [[UIImageView alloc] init];
    self.image.image = [UIImage imageNamed:@"exchangeTime"];
    [self addSubview:self.image];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.startTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.mas_top).offset(24);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo((ScreenW-80)*1.0/2);
    }];
    
    [self.endTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.top.equalTo(self.mas_top).offset(24);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo((ScreenW-80)*1.0/2);
    }];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.startTf.mas_centerY);
    }];
}
- (BOOL)changeStartEndTimeFieldSignal {
    if (_startTf.text.length>0  && _endTf.text.length > 0) {
        return YES;
    }else{
        return NO;
    }
}
@end
