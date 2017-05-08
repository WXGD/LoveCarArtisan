//
//  ImageTxetBtn.m
//  CarTab
//
//  Created by 弓杰 on 16/2/22.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import "ImageTxetBtn.h"

@interface ImageTxetBtn ()

/** 图片 */
@property (nonatomic, strong) UIImageView *image;
/** 文字 */
@property (nonatomic, strong) UILabel *label;

@end

@implementation ImageTxetBtn

- (void)setImageTxetBackgroundImage:(NSString *)image title:(NSString *)title forState:(UIControlState)state {
    [self.image setImageWithImageUrl:image perchImage:@"placeholder_car"];
    self.label.text = title;
}

- (void)setBrand:(CarBrandModel *)brand {
    _brand = brand;
    [self.image setImageWithImageUrl:_brand.image perchImage:@"placeholder_car"];
    self.label.text = _brand.name;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self imageTxetBtnLayoutView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self imageTxetBtnLayoutView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self imageTxetBtnLayoutView];
    }
    return self;
}

#pragma mark - 布局视图
- (void)imageTxetBtnLayoutView {
    
    self.image = [[UIImageView alloc] init];
    [self addSubview:self.image];
    
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.label];
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    @weakify(self)
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.height.mas_equalTo(@17);
    }];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.label.mas_top);
        make.width.equalTo(self.image.mas_height);
    }];
    

}

@end
