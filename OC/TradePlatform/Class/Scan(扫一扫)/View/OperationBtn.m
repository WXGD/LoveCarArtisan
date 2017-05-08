//
//  OperationBtn.m
//  Photo
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OperationBtn.h"

@interface OperationBtn ()

@end

@implementation OperationBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self operationBtnLayoutView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self operationBtnLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)operationBtnLayoutView {
    /** 图片 */
    self.operationImage = [[UIImageView alloc] init];
    [self addSubview:self.operationImage];
    /** 文字 */
    self.operationText = [[UILabel alloc] init];
    self.operationText.font = TwelveTypeface;
    self.operationText.textColor = RGBA(255, 255, 255, 0.8);
    [self addSubview:self.operationText];
    /** 按钮 */
    self.operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.operationButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 图片 */
    [self.operationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
    }];
    /** 文字 */
    [self.operationText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.operationImage.mas_bottom).offset(8);
    }];
    /** 按钮 */
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
