//
//  CustomCell.m
//  CustomCell
//
//  Created by apple on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

/** 灰色1(66,66,66) */
#define GrayH1Color [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
/** 分割线颜色(E5,E5,E5) */
#define lineColor [UIColor colorWithRed:229 / 254.0 green:229 / 254.0 blue:229 / 254.0 alpha:1]
/** 文字黑色 */
#define BlackColor [UIColor colorWithRed:51 / 254.0 green:51 / 254.0 blue:51 / 254.0 alpha:1]

/** 14号字 */
#define FourteenFont [UIFont systemFontOfSize:14]
/** 12号字 */
#define TwelveFont [UIFont systemFontOfSize:12]

#import "CustomCell.h"

@interface CustomCell ()

@end

@implementation CustomCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 设置初始值
        [self customCellSetInitialValues];
        // view布局
        [self customCellLayoutView];
    }
    return self;
}

#pragma mark - 设置初始值
- (void)customCellSetInitialValues {
    /** view样式 */
    self.cellStyle = HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn;
    /** 分割线样式 */
    self.lineStyle = FullScreenLayout;
    /** 分割线高度 */
    self.lineHeight = 0.5;
    /** 左边界距离 */
    self.leftBorder = 16;
    /** 右边界距离 */
    self.rightBorder = -16;
    /** 主标题距离主图片 */
    self.mmImgStep = 16;
    /** 主标题下边距离中线 */
    self.mTitleBom = -5;
    /** 左副标题上边距离主标题下边 */;
    self.lvTitleTop = 10;
    /** 主副标题间距 */
    self.mvTitleStep = 16;
    /** 副输入框距离右副标题距离 */
    self.vTFrvTitleStep = -16;
    /** 右副标题距离右副图片 */
    self.rvvImgStep = -16;
}



#pragma mark - view布局
- (void)customCellLayoutView {
    /** 分割线 */
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = lineColor;
    [self addSubview:self.lineView];
    /** 主图片 */
    self.mainImg = [[UIImageView alloc] init];
    [self.mainImg setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.mainImg setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.mainImg];
    /** 主标题 */
    self.mainLabel = [[UILabel alloc] init];
    self.mainLabel.font = FourteenFont;
    self.mainLabel.textColor = BlackColor;
    [self.mainLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.mainLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.mainLabel];
    /** 左边副标题 */
    self.leftViceLabel = [[UILabel alloc] init];
    self.leftViceLabel.font = TwelveFont;
    self.leftViceLabel.textColor = GrayH1Color;
    [self.leftViceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.leftViceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.leftViceLabel];
    /** 右边副标题 */
    self.rightViceLabel = [[UILabel alloc] init];
    self.rightViceLabel.font = TwelveFont;
    self.rightViceLabel.textColor = GrayH1Color;
    [self.rightViceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.rightViceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.rightViceLabel];
    /** 副输入框 */
    self.viceTF = [[UITextField alloc] init];
    self.viceTF.font = FourteenFont;
    self.viceTF.textColor = BlackColor;
    [self addSubview:self.viceTF];
    /** 箭头图片 */
    self.arrowImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowImg setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
    [self.arrowImg setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.arrowImg setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.arrowImg];
    /** 副按钮 */
    self.viceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.viceBtn];
    /** 主按钮 */
    self.mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.mainBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 分割线
    [self lineLayout];
    // cell样式
    switch (self.cellStyle) {
            /** 所有控件横向布局(没有主图片，没有副图片) */
        case HorizontalLayoutNotMImgAndVImg: {
            [self horizontalLayoutNotMImgAndVImg];
            break;
        }
            /** 所有控件横向布局(有主图片，没有副图片) */
        case HorizontalLayoutHaveMImgAndNotVImg: {
            [self horizontalLayoutHaveMImgAndNotVImg];
            break;
        }
            /** 所有控件横向布局(没有主图片，有副图片，有副按钮) */
        case HorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn: {
            [self horizontalLayoutNotMImgAndHaveVImgAndHaveVBtn];
            break;
        }
            /** 所有控件横向布局(没有主图片，有副图片，没有副按钮) */
        case HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn: {
            [self horizontalLayoutNotMImgAndHaveVImgAndNotVBtn];
            break;
        }
            /** 所有控件横向布局(有主图片，有副图片，有副按钮) */
        case HorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn: {
            [self horizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn];
            break;
        }
            /** 所有控件横向布局(有主图片，有副图片，没有副按钮) */
        case HorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn: {
            [self horizontalLayoutHaveMImgAndHaveVImgAndNotVBtn];
            break;
        }
            /** 大图片，文字纵向布局(没有副图片) */
        case BigImgVerticallyLayoutNotVImg: {
            [self bigImgVerticallyLayoutNotVImg];
            break;
        }
            /** 大图片，文字纵向布局(有副图片，没有副按钮) */
        case BigImgVerticallyLayoutHaveVImgAndNotVBtn: {
            [self bigImgVerticallyLayoutHaveVImgAndNotVBtn];
            break;
        }
            /** 大图片，文字纵向布局(有副图片，有副按钮) */
        case BigImgVerticallyLayoutHaveVImgAndHaveVBtn: {
            [self bigImgVerticallyLayoutHaveVImgAndHaveVBtn];
            break;
        }
            /** 文字纵向布局(没有主图片，没有副图片) */
        case VerticallyLayoutNotVImg: {
            [self verticallyLayoutNotVImg];
            break;
        }
            /** 文字纵向布局(没有主图片，有副图片，没有副按钮) */
        case VerticallyLayoutHaveVImgAndNotVBtn: {
            [self verticallyLayoutHaveVImgAndNotVBtn];
            break;
        }
            /** 文字纵向布局(没有主图片，有副图片，有副按钮) */
        case VerticallyLayoutHaveVImgAndHaveVBtn: {
            [self verticallyLayoutHaveVImgAndHaveVBtn];
            break;
        }
            /** 副标题为输入框(没有主图片，没有副图片) */
        case ViceTFHorizontalLayoutNotMImgAndNotVImg: {
            // 隐藏主按钮
            [self.mainBtn setHidden:YES];
            [self viceTFHorizontalLayoutNotMImgAndNotVImg];
            break;
        }
            /** 副标题为输入框(有主图片，没有副图片) */
        case ViceTFHorizontalLayoutHaveMImgAndNotVImg: {
            // 隐藏主按钮
            [self.mainBtn setHidden:YES];
            [self viceTFHorizontalLayoutHaveMImgAndNotVImg];
            break;
        }
            /** 副标题为输入框(没有主图片，有副图片，有副按钮) */
        case ViceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn: {
            // 隐藏主按钮
            [self.mainBtn setHidden:YES];
            [self viceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn];
            break;
        }
            /** 副标题为输入框(没有主图片，有副图片，没有副按钮) */
        case ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn: {
            // 隐藏主按钮
            [self.mainBtn setHidden:YES];
            [self viceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn];
            break;
        }
            /** 副标题为输入框(有主图片，有副图片，有副按钮) */
        case ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn: {
            // 隐藏主按钮
            [self.mainBtn setHidden:YES];
            [self viceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn];
            break;
        }
            /** 副标题为输入框(有主图片，有副图片，没有副按钮) */
        case ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn: {
            // 隐藏主按钮
            [self.mainBtn setHidden:YES];
            [self viceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 分割线布局方式
- (void)lineLayout {
    @weakify(self)
    switch (self.lineStyle) {
            /** 全屏 */
        case FullScreenLayout: {
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.left.equalTo(self.mas_left);
                make.right.equalTo(self.mas_right);
                make.bottom.equalTo(self.mas_bottom);
                make.height.mas_equalTo(self.lineHeight);
            }];
            break;
        }
            /** 居中 */
        case CenterLayout: {
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.left.equalTo(self.mas_left).offset(16);
                make.right.equalTo(self.mas_right);
                make.bottom.equalTo(self.mas_bottom).offset(-16);
                make.height.mas_equalTo(self.lineHeight);
            }];
            break;
        }
            /** 局右 */
        case RightLayout: {
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.left.equalTo(self.mas_left).offset(16);
                make.right.equalTo(self.mas_right);
                make.bottom.equalTo(self.mas_bottom);
                make.height.mas_equalTo(self.lineHeight);
            }];
            break;
        }
            /** 没有分割线 */
        case NotLine: {
            [self.lineView setHidden:YES];
            break;
        }
        default:
            break;
    }
}


#pragma mark - 所有控件横向布局(没有主图片，没有副图片)
- (void)horizontalLayoutNotMImgAndVImg {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
#pragma mark - 所有控件横向布局(有主图片，没有副图片)
- (void)horizontalLayoutHaveMImgAndNotVImg {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - 所有控件横向布局(没有主图片，有副图片，有副按钮)
- (void)horizontalLayoutNotMImgAndHaveVImgAndHaveVBtn {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 副按钮 */
    [self.viceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.rightViceLabel.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.viceBtn.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
#pragma mark - 所有控件横向布局(没有主图片，有副图片，没有副按钮)
- (void)horizontalLayoutNotMImgAndHaveVImgAndNotVBtn {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - 所有控件横向布局(有主图片，有副图片，有副按钮)
- (void)horizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 副按钮 */
    [self.viceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.rightViceLabel.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.viceBtn.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

/** 所有控件横向布局(有主图片，有副图片，没有副按钮) */
- (void)horizontalLayoutHaveMImgAndHaveVImgAndNotVBtn {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 大图片，文字纵向布局(没有副图片) */
- (void)bigImgVerticallyLayoutNotVImg {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY).offset(self.mTitleBom);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainLabel.mas_bottom).offset(self.lvTitleTop);
        make.left.equalTo(self.mainLabel.mas_left);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 大图片，文字纵向布局(有副图片，没有副按钮) */
- (void)bigImgVerticallyLayoutHaveVImgAndNotVBtn {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY).offset(self.mTitleBom);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainLabel.mas_bottom).offset(self.lvTitleTop);
        make.left.equalTo(self.mainLabel.mas_left);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 大图片，文字纵向布局(有副图片，有副按钮) */
- (void)bigImgVerticallyLayoutHaveVImgAndHaveVBtn {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY).offset(self.mTitleBom);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainLabel.mas_bottom).offset(self.lvTitleTop);
        make.left.equalTo(self.mainLabel.mas_left);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 副按钮 */
    [self.viceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.rightViceLabel.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.viceBtn.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

/** 文字纵向布局(没有主图片，没有副图片) */
- (void)verticallyLayoutNotVImg {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY).offset(self.mTitleBom);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainLabel.mas_bottom).offset(self.lvTitleTop);
        make.left.equalTo(self.mainLabel.mas_left);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 文字纵向布局(没有主图片，有副图片，没有副按钮) */
- (void)verticallyLayoutHaveVImgAndNotVBtn {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY).offset(self.mTitleBom);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainLabel.mas_bottom).offset(self.lvTitleTop);
        make.left.equalTo(self.mainLabel.mas_left);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 文字纵向布局(没有主图片，有副图片，有副按钮) */
- (void)verticallyLayoutHaveVImgAndHaveVBtn {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY).offset(self.mTitleBom);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 左边副标题 */
    [self.leftViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mainLabel.mas_bottom).offset(self.lvTitleTop);
        make.left.equalTo(self.mainLabel.mas_left);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 副按钮 */
    [self.viceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.rightViceLabel.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.viceBtn.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 副标题为输入框(没有主图片，没有副图片) */
- (void)viceTFHorizontalLayoutNotMImgAndNotVImg {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 副输入框 */
    [self.viceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (self.vTFLeftBorder != 0) {
            make.left.equalTo(self.mas_left).offset(self.vTFLeftBorder);
        }else {
            make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
        }
        make.right.equalTo(self.rightViceLabel.mas_left).offset(self.vTFrvTitleStep);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 副标题为输入框(有主图片，没有副图片) */
- (void)viceTFHorizontalLayoutHaveMImgAndNotVImg {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 副输入框 */
    [self.viceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (self.vTFLeftBorder != 0) {
            make.left.equalTo(self.mas_left).offset(self.vTFLeftBorder);
        }else {
            make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
        }
        make.right.equalTo(self.rightViceLabel.mas_left).offset(self.vTFrvTitleStep);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 副标题为输入框(没有主图片，有副图片，有副按钮) */
- (void)viceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 副输入框 */
    [self.viceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (self.vTFLeftBorder != 0) {
            make.left.equalTo(self.mas_left).offset(self.vTFLeftBorder);
        }else {
            make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
        }
        make.right.equalTo(self.rightViceLabel.mas_left).offset(self.vTFrvTitleStep);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 副按钮 */
    [self.viceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.rightViceLabel.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.viceBtn.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 副标题为输入框(没有主图片，有副图片，没有副按钮) */
- (void)viceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn {
    @weakify(self)
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
    }];
    /** 副输入框 */
    [self.viceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (self.vTFLeftBorder != 0) {
            make.left.equalTo(self.mas_left).offset(self.vTFLeftBorder);
        }else {
            make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
        }
        make.right.equalTo(self.rightViceLabel.mas_left).offset(self.vTFrvTitleStep);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

/** 副标题为输入框(有主图片，有副图片，有副按钮) */
- (void)viceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 副输入框 */
    [self.viceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (self.vTFLeftBorder != 0) {
            make.left.equalTo(self.mas_left).offset(self.vTFLeftBorder);
        }else {
            make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
        }
        make.right.equalTo(self.rightViceLabel.mas_left).offset(self.vTFrvTitleStep);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 副按钮 */
    [self.viceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.rightViceLabel.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.viceBtn.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 副标题为输入框(有主图片，有副图片，没有副按钮) */
- (void)viceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn {
    @weakify(self)
    /** 主图片 */
    [self.mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.leftBorder);
        if (!CGSizeEqualToSize(self.mainImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.mainImgSize);
        }
    }];
    /** 主标题 */
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mainImg.mas_right).offset(self.mmImgStep);
    }];
    /** 副输入框 */
    [self.viceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (self.vTFLeftBorder != 0) {
            make.left.equalTo(self.mas_left).offset(self.vTFLeftBorder);
        }else {
            make.left.equalTo(self.mainLabel.mas_right).offset(self.mvTitleStep);
        }
        make.right.equalTo(self.rightViceLabel.mas_left).offset(self.vTFrvTitleStep);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** 箭头图片 */
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(self.rightBorder);
        if (!CGSizeEqualToSize(self.arrowImgSize, CGSizeZero)) {
            make.size.mas_equalTo(self.arrowImgSize);
        }
    }];
    /** 右边副标题 */
    [self.rightViceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImg.mas_left).offset(self.rvvImgStep);
    }];
    /** 主按钮 */
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}


@end
