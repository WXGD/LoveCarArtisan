//
//  AnalysisView.m
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AnalysisView.h"
#import "JHChartHeader.h"
#import "LeftRigFaxView.h"

@interface AnalysisView ()

/** 表格 */
@property (strong, nonatomic) JHColumnChart *columnFormView;
/** 周 */
@property (strong, nonatomic) UIButton *weekBtn;
/** 月 */
@property (strong, nonatomic) UIButton *monthBtn;
/** 季度 */
@property (strong, nonatomic) UIButton *quarterBtn;
/** 左边 */
@property (strong, nonatomic) LeftRigFaxView *leftFaxView;
/** 右边 */
@property (strong, nonatomic) LeftRigFaxView *rightFaxView;

@end


@implementation AnalysisView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self analysisLayoutView];
    }
    return self;
}

- (void)analysisLayoutView {
    /** 周 */
    self.weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weekBtn setTitle:@"周" forState:UIControlStateNormal];
    [self.weekBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.weekBtn.titleLabel.font = FifteenTypeface;
    [self addSubview:self.weekBtn];
    /** 月 */
    self.monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.monthBtn setTitle:@"月" forState:UIControlStateNormal];
    [self.monthBtn setTitleColor:Black forState:UIControlStateNormal];
    self.monthBtn.titleLabel.font = FifteenTypeface;
    [self addSubview:self.monthBtn];
    /** 季度 */
    self.quarterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.quarterBtn setTitle:@"季度" forState:UIControlStateNormal];
    [self.quarterBtn setTitleColor:Black forState:UIControlStateNormal];
    self.quarterBtn.titleLabel.font = FifteenTypeface;
    [self addSubview:self.quarterBtn];
    /** 表格 */
    self.columnFormView = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, 144, ScreenW, 335 * HScale)];
    self.columnFormView.valueShowInfo =  @[
                              @[@"增加10%", @""],
                              @[@"增加10%", @""],
                              @[@"", @"减小10%"],
                              @[@"增加10%", @""],
                              @[@"增加10%", @""],
                              @[@"增加10%", @""],
                              @[@"增加10%", @""],
                              @[@"", @"减小10%"],
                              @[@"", @"减小10%"],
                              @[@"", @"减小10%"],
                              @[@"", @"减小10%"],
                              @[@"增加10%", @""],
                              @[@"增加10%", @""],
                              ];
    self.columnFormView.valueArr = @[
                        @[@21, @10],
                        @[@22, @10],
                        @[@1, @10],
                        @[@21, @10],
                        @[@19, @10],
                        @[@12, @10],
                        @[@15, @10],
                        @[@9, @10],
                        @[@8, @10],
                        @[@6, @10],
                        @[@9, @10],
                        @[@18, @10],
                        @[@23, @10],
                        ];
    self.columnFormView.xShowInfoText = @[@"A班级",@"B班级",@"C班级",@"D班级",@"E班级",@"F班级",@"G班级",@"H班级",@"i班级",@"J班级",@"L班级",@"M班级",@"N班级"];
    self.columnFormView.originSize = CGPointMake(30, 20);
    self.columnFormView.drawFromOriginX = 20;
    self.columnFormView.typeSpace = 40;
    self.columnFormView.isShowYLine = YES;
    self.columnFormView.columnWidth = 30;
    self.columnFormView.bgVewBackgoundColor = [UIColor whiteColor];
    self.columnFormView.drawTextColorForX_Y = [UIColor blackColor];
    self.columnFormView.colorForXYLine = [UIColor darkGrayColor];
    self.columnFormView.columnBGcolorsArr = @[RGB(93, 128, 188), RGB(179, 81, 81)];
    self.columnFormView.columnTitleBGcolorsArr = @[[UIColor redColor], [UIColor greenColor]];
    [self.columnFormView showAnimation];
    [self addSubview:self.columnFormView];
    /** 左边 */
    self.leftFaxView = [[LeftRigFaxView alloc] init];
    self.leftFaxView.rightText.text = @"上周";
    self.leftFaxView.leftImage.backgroundColor = RGB(93, 128, 188);
    [self addSubview:self.leftFaxView];
    /** 右边 */
    self.rightFaxView = [[LeftRigFaxView alloc] init];
    self.rightFaxView.rightText.text = @"本周";
    self.rightFaxView.leftImage.backgroundColor = RGB(179, 81, 81);
    [self addSubview:self.rightFaxView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 月 */
    [self.monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
    }];
    /** 周 */
    [self.weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.monthBtn.mas_left);
        make.centerY.equalTo(self.monthBtn.mas_centerY);
    }];
    /** 季度 */
    [self.quarterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.monthBtn.mas_right);
        make.centerY.equalTo(self.monthBtn.mas_centerY);
    }];
    /** 周,月,季度 */
    [@[self.weekBtn, self.monthBtn, self.quarterBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@70);
    }];
    /** 表格 */
    [self.columnFormView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.monthBtn.mas_bottom);
        make.height.mas_equalTo(@(335 * HScale));
    }];
    /** 左边 */
    [self.leftFaxView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
    }];
    /** 右边 */
    [self.rightFaxView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.leftFaxView.mas_right);
    }];
    /** 左边,右边 */
    [@[self.leftFaxView, self.rightFaxView] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.columnFormView.mas_bottom).offset(30);
        make.width.equalTo(self.leftFaxView.mas_width);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.leftFaxView.mas_bottom).offset(20);
    }];
}

@end
