//
//  JiuGongBtn.m
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JiuGongBtn.h"

@implementation JiuGongBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jiuGongBtnLayoutView];
    }
    return self;
}

- (void)topBotBtnAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(jiuGongBtnAction:tag:)]) {
        [_delegate jiuGongBtnAction:button tag:self.tag];
    }
}

- (void)setBtnImageArray:(NSMutableArray *)btnImageArray {
    _btnImageArray = btnImageArray;
    if (btnImageArray.count < 9) {
        for (int i = 0; i < 9 - btnImageArray.count; i++) {
            [_btnImageArray addObject:@""];
        }
    }
    
    self.btn1.topImage.image = [UIImage imageNamed:self.btnImageArray[0]];
    self.btn2.topImage.image = [UIImage imageNamed:self.btnImageArray[1]];
    self.btn3.topImage.image = [UIImage imageNamed:self.btnImageArray[2]];
    self.btn4.topImage.image = [UIImage imageNamed:self.btnImageArray[3]];
    self.btn5.topImage.image = [UIImage imageNamed:self.btnImageArray[4]];
    self.btn6.topImage.image = [UIImage imageNamed:self.btnImageArray[5]];
    self.btn7.topImage.image = [UIImage imageNamed:self.btnImageArray[6]];
    self.btn8.topImage.image = [UIImage imageNamed:self.btnImageArray[7]];
    self.btn9.topImage.image = [UIImage imageNamed:self.btnImageArray[8]];

}

- (void)setBtnTextArray:(NSMutableArray *)btnTextArray {
    _btnTextArray = btnTextArray;
    if (btnTextArray.count < 9) {
        for (int i = 0; i <= 9 - btnTextArray.count; i++) {
            [_btnTextArray addObject:@""];
        }
    }
    self.btn1.bomText.text = self.btnTextArray[0];
    self.btn2.bomText.text = self.btnTextArray[1];
    self.btn3.bomText.text = self.btnTextArray[2];
    self.btn4.bomText.text = self.btnTextArray[3];
    self.btn5.bomText.text = self.btnTextArray[4];
    self.btn6.bomText.text = self.btnTextArray[5];
    self.btn7.bomText.text = self.btnTextArray[6];
    self.btn8.bomText.text = self.btnTextArray[7];
    self.btn9.bomText.text = self.btnTextArray[8];
}

- (void)jiuGongBtnLayoutView {
    
    self.btn1 = [[TopBotBtn alloc] init];
    self.btn1.topBotBtn.tag = 27421;
    [self.btn1.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn1];
    
    self.btn2 = [[TopBotBtn alloc] init];
    self.btn2.topBotBtn.tag = 27422;
    [self.btn2.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn2];
    
    self.btn3 = [[TopBotBtn alloc] init];
    self.btn3.topBotBtn.tag = 27423;
    [self.btn3.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn3];
    
    self.btn4 = [[TopBotBtn alloc] init];
    self.btn4.topBotBtn.tag = 27424;
    [self.btn4.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn4];
    
    self.btn5 = [[TopBotBtn alloc] init];
    self.btn5.topBotBtn.tag = 27425;
    [self.btn5.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn5];
    
    self.btn6 = [[TopBotBtn alloc] init];
    self.btn6.topBotBtn.tag = 27426;
    [self.btn6.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn6];
    
    self.btn7 = [[TopBotBtn alloc] init];
    self.btn7.topBotBtn.tag = 27427;
    [self.btn7.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn7];
    
    self.btn8 = [[TopBotBtn alloc] init];
    self.btn8.topBotBtn.tag = 27428;
    [self.btn8.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn8];
    
    self.btn9 = [[TopBotBtn alloc] init];
    self.btn9.topBotBtn.tag = 27429;
    [self.btn9.topBotBtn addTarget:self action:@selector(topBotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn9];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
    }];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.btn2.mas_left);
        make.centerY.equalTo(self.btn2.mas_centerY);
    }];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.btn2.mas_right);
        make.centerY.equalTo(self.btn2.mas_centerY);
    }];
    
    
    [self.btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.btn2.mas_bottom);
    }];
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.btn5.mas_left);
        make.centerY.equalTo(self.btn5.mas_centerY);
    }];
    [self.btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.btn5.mas_right);
        make.centerY.equalTo(self.btn5.mas_centerY);
    }];
    
    [self.btn8 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.btn5.mas_bottom);
    }];
    [self.btn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.btn8.mas_left);
        make.centerY.equalTo(self.btn8.mas_centerY);
    }];
    [self.btn9 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.btn8.mas_right);
        make.centerY.equalTo(self.btn8.mas_centerY);
    }];
    
    
    [@[self.btn1, self.btn2, self.btn3, self.btn4, self.btn5, self.btn6, self.btn7, self.btn8, self.btn9] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.btn1.mas_width);
        make.height.equalTo(self.btn1.mas_width);
    }];

    // self
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.btn9.mas_bottom);
    }];
}

@end
