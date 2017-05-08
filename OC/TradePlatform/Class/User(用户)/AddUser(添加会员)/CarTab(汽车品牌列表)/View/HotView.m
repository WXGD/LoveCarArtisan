//
//  HotView.m
//  CarRepairFactory
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HotView.h"

@interface HotView ()

/** 热门车型0 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn0;
/** 热门车型1 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn1;
/** 热门车型2 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn2;
/** 热门车型3 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn3;
/** 热门车型4 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn4;
/** 热门车型5 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn5;
/** 热门车型6 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn6;
/** 热门车型7 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn7;
/** 热门车型8 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn8;
/** 热门车型9 */
@property (weak, nonatomic) IBOutlet ImageTxetBtn *hotBtn9;

@end

@implementation HotView

+ (HotView *)loadBlueViewFromXIB {
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HotView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

/** 布局热门车辆 */
- (void)hotBrandLayoutView {
    if (self.hotDataArray.count > 0) {
        self.hotBtn0.brand = self.hotDataArray[0];
        [self.hotBtn0 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 1) {
        self.hotBtn1.brand = self.hotDataArray[1];
        [self.hotBtn1 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 2) {
        self.hotBtn2.brand = self.hotDataArray[2];
        [self.hotBtn2 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 3) {
        self.hotBtn3.brand = self.hotDataArray[3];
        [self.hotBtn3 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 4) {
        self.hotBtn4.brand = self.hotDataArray[4];
        [self.hotBtn4 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 5) {
        self.hotBtn5.brand = self.hotDataArray[5];
        [self.hotBtn5 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 6) {
        self.hotBtn6.brand = self.hotDataArray[6];
        [self.hotBtn6 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 7) {
        self.hotBtn7.brand = self.hotDataArray[7];
        [self.hotBtn7 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 8) {
        self.hotBtn8.brand = self.hotDataArray[8];
        [self.hotBtn8 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hotDataArray.count > 9) {
        self.hotBtn9.brand = self.hotDataArray[9];
        [self.hotBtn9 addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = WhiteColor;
}

#pragma mark - 按钮点击方法
- (void)hotBtnAction:(UIButton *)button {
    NSInteger brandID = button.tag - 4720;
    CarBrandModel *brand = self.hotDataArray[brandID];
    if (_delegate && [_delegate respondsToSelector:@selector(hotViewBtnAction:)]) {
        [_delegate hotViewBtnAction:brand];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
