//
//  SearchView.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView


- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认输入框样式，nav布局
        self.searchType = NavigationLayout;
        [self searchLayoutView];
    }
    return self;
}

- (void)searchLayoutView {
    /** 搜索view */
    self.searchView = [[UIView alloc] init];
    self.searchView.backgroundColor = RGBA(255, 255, 255, 0.20);
    self.searchView.layer.masksToBounds = YES;
    self.searchView.layer.cornerRadius = 2;
    [self addSubview:self.searchView];
    /** 搜索放大镜 */
    self.searchMagnifierImage = [[UIImageView alloc] init];
    self.searchMagnifierImage.image = [UIImage imageNamed:@"nav_search_aplan"];
    [self.searchView addSubview:self.searchMagnifierImage];
    /** 搜索输入框 */
    self.searchTF = [[UITextField alloc] init];
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.placeholder = @"手机号 车牌号 会员卡号";
    [self.searchTF setValue:RGBA(256, 256, 256, 0.6)  forKeyPath:@"_placeholderLabel.textColor"];
    [self.searchTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.searchTF.textColor = WhiteColor;
    self.searchTF.font = FourteenTypeface;
    [self.searchView addSubview:self.searchTF];
    /** 搜索按钮 */
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = FifteenTypeface;
    [self addSubview:self.searchBtn];
    /** 覆盖整个控件的按钮 */
    self.viewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.viewBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.searchType) {
            /** nav上使用的尺寸 */
        case NavigationLayout:{
            [self navigationLayout];
            break;
        }
            /** 普通view尺寸 */
        case OrdinaryViewLayout:{
            [self ordinaryViewLayout];
            break;
        }
        default:
            break;
    }
}
/** nav上使用的尺寸 */
- (void)navigationLayout {
    @weakify(self)
    /** 搜索view */
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        if (!self.isSearchWidth) {
            make.width.mas_equalTo(@(240 * WScale));
        }else{
            make.width.mas_equalTo(@(290 * WScale));
        }
    }];
    if (!self.isSearch) {
        /** 搜索按钮 */
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.searchView.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(@50);
        }];
    }else {
        /** 搜索按钮 */
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.searchView.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(@0);
        }];
    }
    /** 搜索放大镜 */
    [self.searchMagnifierImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.searchView.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.searchMagnifierImage.mas_height);
    }];
    /** 搜索输入框 */
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.searchMagnifierImage.mas_right).offset(10);
        make.right.equalTo(self.searchView.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.searchBtn.mas_right);
        make.height.mas_equalTo(@30);
    }];
    if (!self.isViewBtn) {
        /** 覆盖整个控件的按钮 */
        [self.viewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
        }];
    }
}
/** 普通view尺寸 */
- (void)ordinaryViewLayout {
    @weakify(self)
    /** 搜索view */
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 搜索放大镜 */
    [self.searchMagnifierImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.searchView.mas_left).offset(16);
        make.centerY.equalTo(self.searchView.mas_centerY);
        make.width.equalTo(self.searchMagnifierImage.mas_height);
    }];
    /** 搜索输入框 */
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.searchMagnifierImage.mas_right).offset(10);
        make.right.equalTo(self.searchView.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    if (!self.isViewBtn) {
        /** 覆盖整个控件的按钮 */
        [self.viewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
        }];
    }
}

@end
