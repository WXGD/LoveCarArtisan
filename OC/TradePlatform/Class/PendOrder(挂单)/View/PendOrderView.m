//
//  PendOrderView.m
//  TradePlatform
//
//  Created by 祝豪杰 on 17/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PendOrderView.h"

@implementation PendOrderView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self pendOrderLayoutView];
  }
  return self;
}

#pragma mark - view布局
- (void)pendOrderLayoutView {
  /** 商品类别名称 */
  self.labLeft = [[UILabel alloc] init];
  self.labLeft.textColor = Black;
  self.labLeft.font = TwelveTypeface;
  [self addSubview:self.labLeft];

  /** 数量 */
  self.labCenter = [[UILabel alloc] init];
  self.labCenter.textColor = GrayH2;
  self.labCenter.font = TwelveTypeface;
  [self addSubview:self.labCenter];

  /** 金额 */
  self.labRight = [[UILabel alloc] init];
  self.labRight.textColor = GrayH1;
  self.labRight.font = TwelveTypeface;
  [self addSubview:self.labRight];
    
}
- (void)layoutSubviews {
  [super layoutSubviews];
  @weakify(self)
      /** 商品类别名称 */
      [self.labLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self) make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_equalTo(@12);
      }];
  /** 数量 */
  [self.labCenter mas_makeConstraints:^(MASConstraintMaker *make) {
    @strongify(self) make.centerY.equalTo(self.labLeft.mas_centerY);
    make.centerX.equalTo(self.mas_centerX);
    make.height.equalTo(self.labLeft.mas_height);
  }];
  /** 金额 */
  [self.labRight mas_makeConstraints:^(MASConstraintMaker *make) {
    @strongify(self) make.centerY.equalTo(self.labLeft.mas_centerY);
    make.right.equalTo(self.mas_right).offset(-16);
    make.height.equalTo(self.labLeft.mas_height);
  }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
