//
//  QueryPromptView.m
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QueryPromptView.h"

@interface QueryPromptView()

/** 显示内容的容器 */
@property (nonatomic, strong) UIImageView *containerImage;
/** 显示内容 */
@property (nonatomic, strong) UILabel *containerLabel;

@end

@implementation QueryPromptView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self queryPromptViewLayoutView];
        // 计时2秒
        dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
        dispatch_after(timer, dispatch_get_main_queue(), ^(void){
            // 修改textfield文字颜色
            self.queryTF.textColor = Black;
            [self removeFromSuperview];
        });
    }
    return self;
}
#pragma mark - view布局
- (void)queryPromptViewLayoutView {
    /** 显示内容的容器 */
    self.containerImage = [[UIImageView alloc] init];
    self.containerImage.image = [UIImage imageNamed:@"query_prompt"];
    [self addSubview:self.containerImage];
    /** 显示内容 */
    self.containerLabel = [[UILabel alloc] init];
    self.containerLabel.text = @"格式不正确，请确认后再输入！";
    self.containerLabel.textColor = WhiteColor;
    self.containerLabel.font = TwelveTypeface;
    [self.containerImage addSubview:self.containerLabel];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 显示内容的容器 */
    [self.containerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@25);
    }];
    /** 显示内容 */
    [self.containerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.containerImage.mas_left).offset(15);
        make.centerY.equalTo(self.containerImage.mas_centerY).offset(2);
    }];
    /** 显示内容的容器 */
    [self.containerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.containerLabel.mas_right).offset(15);
    }];
}


@end
