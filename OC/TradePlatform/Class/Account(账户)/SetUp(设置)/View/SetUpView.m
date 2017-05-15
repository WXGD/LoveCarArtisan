//
//  SetUpView.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SetUpView.h"

@interface SetUpView ()

@end

@implementation SetUpView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpLayoutView];
    }
    return self;
}

- (void)setUpLayoutView {
    /** 清除缓存 */
    self.clearCacheView = [[UsedCellView alloc] init];
    self.clearCacheView.usedCellBtn.tag = ClearCacheBtnAction;
    self.clearCacheView.cellImage.image = [UIImage imageNamed:@"clear_cache"];
    self.clearCacheView.isCellImageSize = YES;
    self.clearCacheView.isCellImage = YES;
    self.clearCacheView.cellLabel.text = @"清除缓存";
    [self addSubview:self.clearCacheView];
    /** 当前版本 */
    self.currentVersionView = [[UsedCellView alloc] init];
    self.currentVersionView.usedCellBtn.tag = CurrentVersionBtnAction;
    self.currentVersionView.cellImage.image = [UIImage imageNamed:@"current_version"];
    self.currentVersionView.isCellImageSize = YES;
    self.currentVersionView.isArrow = YES;
    self.currentVersionView.isCellImage = YES;
    self.currentVersionView.cellLabel.text = @"当前版本";
    [self addSubview:self.currentVersionView];
    /** 意见反馈 */
    self.feedbackView = [[UsedCellView alloc] init];
    self.feedbackView.usedCellBtn.tag = FeedbackBtnAction;
    self.feedbackView.cellImage.image = [UIImage imageNamed:@"feedback"];
    self.feedbackView.isCellImageSize = YES;
    self.feedbackView.isCellImage = YES;
    self.feedbackView.cellLabel.text = @"意见反馈";
    [self addSubview:self.feedbackView];
    /** 关于我们 */
    self.aboutUsView = [[UsedCellView alloc] init];
    self.aboutUsView.usedCellBtn.tag = AboutUsBtnAction;
    self.aboutUsView.cellImage.image = [UIImage imageNamed:@"about_us"];
    self.aboutUsView.isCellImageSize = YES;
    self.aboutUsView.isCellImage = YES;
    self.aboutUsView.cellLabel.text = @"关于我们";
    self.aboutUsView.isSplistLine = YES;
    [self addSubview:self.aboutUsView];
    [self.aboutUsView setHidden:YES];
    /** 客服电话 */
    self.serviceNumView = [[UsedCellView alloc] init];
    self.serviceNumView.usedCellBtn.tag = ServiceNumBtnAction;
    self.serviceNumView.cellImage.image = [UIImage imageNamed:@"service_num"];
    self.serviceNumView.isCellImageSize = YES;
    self.serviceNumView.isCellImage = YES;
    self.serviceNumView.cellLabel.text = @"客服电话";
    self.serviceNumView.describeLabel.text = SERVICENUM;
    [self addSubview:self.serviceNumView];
    /** 功能介绍 */
    self.funcIntroView = [[UsedCellView alloc] init];
    self.funcIntroView.usedCellBtn.tag = funcIntroBtnAction;
    self.funcIntroView.cellImage.image = [UIImage imageNamed:@"service_num"];
    self.funcIntroView.isCellImageSize = YES;
    self.funcIntroView.isCellImage = YES;
    self.funcIntroView.cellLabel.text = @"功能介绍";
    [self addSubview:self.funcIntroView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 清除缓存 */
    [self.clearCacheView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(@50);
    }];
    /** 当前版本 */
    [self.currentVersionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.clearCacheView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 意见反馈 */
    [self.feedbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.currentVersionView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 关于我们 */
    [self.aboutUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.feedbackView.mas_bottom);
        make.height.mas_equalTo(@0);
    }];
    /** 客服电话 */
    [self.serviceNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.aboutUsView.mas_bottom).offset(15);
        make.height.mas_equalTo(@50);
    }];
    /** 功能介绍 */
    [self.funcIntroView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.serviceNumView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
}

@end
