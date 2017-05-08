//
//  SelectProvinceView.m
//  LoveCarEHome
//
//  Created by 弓杰 on 16/3/18.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#define viewH ScreenW / 9 * 4
#define ScreensH [UIScreen mainScreen].bounds.size.height
#define viewY ScreensH - viewH

#import "SelectProvinceView.h"
#import "ProvinceBtn.h"

@interface SelectProvinceView ()

/**  */
@property (nonatomic, strong) ProvinceBtn *provinceBtn;
@end

@implementation SelectProvinceView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        
        [self layoutView];
    }
    return self;
}
#pragma mark - 布局视图
- (void)layoutView {
    
    self.provinceBtn = [ProvinceBtn loadBlueViewFromXIB];
    self.provinceBtn.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.provinceBtn];
    
    // 省份简称通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(provinceBtnAction:) name:@"ProvinceBtnNotification" object:nil];
}

#pragma mark - 省份简称
- (void)provinceBtnAction:(NSNotification *)province {
    
    [self dismiss];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}



#pragma mark - 显示
- (void)show {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    self.provinceBtn.frame = CGRectMake(0, ScreensH, ScreenW, viewH);

    [UIView animateWithDuration:.7f animations:^{
        self.provinceBtn.frame = CGRectMake(0, viewY, ScreenW, viewH);
    } completion:nil];
}

#pragma mark - 销毁
- (void)dismiss {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.provinceBtn.frame = CGRectMake(0, ScreensH, ScreenW, viewH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismiss];
}

// 移除通知
// - (void)dealloc {
//
//    [[NSNotificationCenter defaultCenter]removeObserver:self
//                                                   name:@"ProvinceBtnNotification"
//                                                 object:nil];
//}


@end
