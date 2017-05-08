//
//  CommodityOperationBtn.m
//  TradePlatform
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommodityOperationBtn.h"

@implementation CommodityOperationBtn

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
//    @weakify(self)
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.centerX.equalTo(self.mas_centerX);
//        make.bottom.equalTo(self.mas_centerY).offset(-5);
//    }];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.centerX.equalTo(self.mas_centerX);
//        make.top.equalTo(self.mas_centerY).offset(5);
//    }];
    // 计算titleLabel的frame
    self.titleLabel.x = (self.width - self.titleLabel.width) / 2;
    self.titleLabel.y = self.height / 2 + 5;

    // 计算imageView的frame
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = self.height / 2 - self.imageView.height - 5;
}

@end
