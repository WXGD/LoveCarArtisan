//
//  UsedCellView.m
//  TradePlatform
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UsedCellView.h"

@interface UsedCellView ()

/** 分割线 */
@property (strong, nonatomic) UIView *splistLineView;

@end

@implementation UsedCellView
- (instancetype)init {
    self = [super init];
    if (self) {
        // 默认横向布局
        self.usedCellTypeChoice = AllViewHorizontalLayout;
        // 默认分割线样式
        self.dividingLineChoice = DividingLineRightLayout;
        // 默认cell图片尺寸
        self.cellImageSize = CGSizeMake(16, 16);
        /** 大图距离上边（所有控件纵向居中分布，专用） */
        self.bigImageTop = 5;
        self.backgroundColor = [UIColor whiteColor];
        [self cellArrowLayoutView];
    }
    return self;
}

- (void)cellArrowLayoutView {
    
    /** 图片 */
    self.cellImage = [[UIImageView alloc] init];
    [self addSubview:self.cellImage];
    /** 文字 */
    self.cellLabel = [[UILabel alloc] init];
    self.cellLabel.font = [UIFont systemFontOfSize:14];
    self.cellLabel.textColor = Black;
    [self addSubview:self.cellLabel];
    /** 副标题 */
    self.viceLabel = [[UILabel alloc] init];
    self.viceLabel.font = [UIFont systemFontOfSize:12];
    self.viceLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self addSubview:self.viceLabel];
    /** 输入框副标题 */
    self.viceTextFiled = [[UITextField alloc] init];
    self.viceTextFiled.textAlignment = NSTextAlignmentCenter;
    self.viceTextFiled.borderStyle = UITextBorderStyleLine;
    self.viceTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.viceTextFiled.font = [UIFont systemFontOfSize:14];
    self.viceTextFiled.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self addSubview:self.viceTextFiled];
    /** 描述文字 */
    self.describeLabel = [[UILabel alloc] init];
    self.describeLabel.font = [UIFont systemFontOfSize:12];
    self.describeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self addSubview:self.describeLabel];
    /** 描述图片 */
    self.describeImage = [[UIImageView alloc] init];
    [self addSubview:self.describeImage];
    
    /** 箭头 */
    self.arrowImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowImage setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
    [self addSubview:self.arrowImage];
    /** 分割线 */
    self.splistLineView = [[UIView alloc] init];
    self.splistLineView.backgroundColor = VCBackground;
    [self addSubview:self.splistLineView];
    /** 按钮点击 */
    self.usedCellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.usedCellBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.usedCellTypeChoice) {
        case AllViewHorizontalLayout:{
            [self allViewHorizontalLayout];
            break;
        }
        case BigPictureVerticallyLayout:{
            [self bigPictureVerticallyLayout];
            break;
        }
        case DescribeImageHorizontalLayout: {
            [self describeImageHorizontalLayout];
            break;
        }
        case DescribeImageTextHorizontalLayout: {
            [self describeImageTextHorizontalLayout];
            break;
        }
        case AllViewVerticallyCenterLayout: {
            [self allViewVerticallyCenterLayout];
            break;
        }
        case ViceTextFiledHorizontalLayout: {
            [self viceTextFiledHorizontalLayout];
            break;
        }
            /** 只有一个输入框输入框 */
        case OnlyTextFiledLayout: {
            [self onlyTextFiledLayout];
            break;
        }
        default:
            break;
    }
    
}

/** 所有控件横向布局 */
- (void)allViewHorizontalLayout {
    @weakify(self)
    // 判断有没有图片
    if (!self.isCellImage) {
        // 判断是否需要自定义cell图片大小
        if (_isCellImageSize) {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }else {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
            }];
        }
    }else {
        /** 图片 */
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 文字 */
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellImage.mas_right).offset(16);
    }];
    /** 副标题 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellLabel.mas_right).offset(10);
    }];
    // 判断有没有箭头
    if (!self.isArrow) {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-16);
        }];
    }else {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 描述文字 */
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImage.mas_left).offset(-16);
    }];
    /** 分割线 */
    if (!self.isSplistLine) {
        /** 分割线样式 */
        switch (self.dividingLineChoice) {
            case DividingLineFullScreenLayout: {
                self.splistLineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
                break;
            }
            case DividingLineCenterLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 30, 0.5);
                break;
            }
            case DividingLineRightLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 15, 0.5);
                break;
            }
            default:
                break;
        }
    }
    /** 按钮点击 */
    if (!self.isCellBtn) {
        self.usedCellBtn.frame = CGRectMake(0, 0, self.width, self.height);
    }
}

/** 大图片，文字纵向布局 */
- (void)bigPictureVerticallyLayout {
    @weakify(self)
    // 判断有没有图片
    if (!self.isCellImage) {
        // 判断是否需要自定义cell图片大小
        if (_isCellImageSize) {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }else {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
            }];
        }
    }else {
        /** 图片 */
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 文字 */
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_centerY).offset(-5);
        make.left.equalTo(self.cellImage.mas_right).offset(16);
    }];
    /** 副标题 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_centerY).offset(5);
        make.left.equalTo(self.cellLabel.mas_left);
    }];
    // 判断有没有箭头
    if (!self.isArrow) {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
    }else {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 描述文字 */
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImage.mas_left).offset(-5);
    }];
    /** 分割线 */
    if (!self.isSplistLine) {
        /** 分割线样式 */
        switch (self.dividingLineChoice) {
            case DividingLineFullScreenLayout: {
                self.splistLineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
                break;
            }
            case DividingLineCenterLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 30, 0.5);
                break;
            }
            case DividingLineRightLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 15, 0.5);
                break;
            }
            default:
                break;
        }
    }
    /** 按钮点击 */
    if (!self.isCellBtn) {
        self.usedCellBtn.frame = CGRectMake(0, 0, self.width, self.height);
    }
}

/** 描述信息为图片 */
- (void)describeImageHorizontalLayout {
    @weakify(self)
    // 判断有没有图片
    if (!self.isCellImage) {
        // 判断是否需要自定义cell图片大小
        if (_isCellImageSize) {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(15);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }else {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(15);
            }];
        }
    }else {
        /** 图片 */
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 文字 */
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellImage.mas_right).offset(5);
    }];
    /** 副标题 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellLabel.mas_right).offset(5);
    }];
    // 判断有没有箭头
    if (!self.isArrow) {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
    }else {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 描述图片 */
    [self.describeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImage.mas_left).offset(-16);
        make.size.mas_equalTo(_describeImageSize);
    }];
    /** 分割线 */
    if (!self.isSplistLine) {
        self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 30, 0.5);
    }
    /** 按钮点击 */
    if (!self.isCellBtn) {
        self.usedCellBtn.frame = CGRectMake(0, 0, self.width, self.height);
    }
}
/** 描述信息有图片和文字 */
- (void)describeImageTextHorizontalLayout {
    @weakify(self)
    // 判断有没有图片
    if (!self.isCellImage) {
        // 判断是否需要自定义cell图片大小
        if (_isCellImageSize) {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }else {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
            }];
        }
    }else {
        /** 图片 */
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 文字 */
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellImage.mas_right).offset(16);
    }];
    /** 副标题 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellLabel.mas_right).offset(5);
    }];
    // 判断有没有箭头
    if (!self.isArrow) {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-16);
        }];
    }else {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 描述文字 */
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImage.mas_left).offset(-16);
    }];
    /** 描述图片 */
    [self.describeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.describeLabel.mas_left).offset(-16);
        make.size.mas_equalTo(_describeImageSize);
    }];
    /** 分割线 */
    if (!self.isSplistLine) {
        /** 分割线样式 */
        switch (self.dividingLineChoice) {
            case DividingLineFullScreenLayout: {
                self.splistLineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
                break;
            }
            case DividingLineCenterLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 30, 0.5);
                break;
            }
            case DividingLineRightLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 15, 0.5);
                break;
            }
            default:
                break;
        }
    }
    /** 按钮点击 */
    if (!self.isCellBtn) {
        self.usedCellBtn.frame = CGRectMake(0, 0, self.width, self.height);
    }
}

/** 所有控件纵向居中分布 */
- (void)allViewVerticallyCenterLayout {
    @weakify(self)
    // 判断有没有图片
    if (!self.isCellImage) {
        // 判断是否需要自定义cell图片大小
        if (_isCellImageSize) {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerX.equalTo(self.mas_centerX);
                make.top.equalTo(self.mas_top).offset(_bigImageTop);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }else {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerX.equalTo(self.mas_centerX);
                make.top.equalTo(self.mas_top).offset(_bigImageTop);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }
    }else {
        /** 图片 */
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(_bigImageTop);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 文字 */
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.cellImage.mas_bottom).offset(5);
    }];
    /** 副标题 */
    [self.viceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.cellLabel.mas_bottom).offset(5);
    }];
    // 判断有没有箭头
    if (!self.isArrow) {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }else {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 描述文字 */
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.viceLabel.mas_bottom).offset(5);
    }];
    /** 分割线 */
    if (!self.isSplistLine) {
        /** 分割线样式 */
        switch (self.dividingLineChoice) {
            case DividingLineFullScreenLayout: {
                self.splistLineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
                break;
            }
            case DividingLineCenterLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 30, 0.5);
                break;
            }
            case DividingLineRightLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 15, 0.5);
                break;
            }
            default:
                break;
        }
    }
    /** 按钮点击 */
    if (!self.isCellBtn) {
        self.usedCellBtn.frame = CGRectMake(0, 0, self.width, self.height);
    }
}
/** 副标题为输入框 */
- (void)viceTextFiledHorizontalLayout {
    @weakify(self)
    // 判断有没有图片
    if (!self.isCellImage) {
        // 判断是否需要自定义cell图片大小
        if (_isCellImageSize) {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }else {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }
    }else {
        /** 图片 */
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(11);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 文字 */
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellImage.mas_right).offset(5);
    }];
    // 判断有没有箭头
    if (!self.isArrow) {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-16);
        }];
    }else {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-11);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 描述文字 */
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImage.mas_left).offset(-5);
    }];
    /** 输入框副标题 */
    [self.viceTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(115);
        make.right.equalTo(self.describeLabel.mas_left).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    /** 分割线 */
    if (!self.isSplistLine) {
        /** 分割线样式 */
        switch (self.dividingLineChoice) {
            case DividingLineFullScreenLayout: {
                self.splistLineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
                break;
            }
            case DividingLineCenterLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 30, 0.5);
                break;
            }
            case DividingLineRightLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 15, 0.5);
                break;
            }
            default:
                break;
        }
    }
    /** 按钮点击 */
    if (!self.isCellBtn) {
        self.usedCellBtn.frame = CGRectMake(0, 0, self.width, self.height);
    }
}

/** 只有一个输入框输入框 */
- (void)onlyTextFiledLayout {
    @weakify(self)
    // 判断有没有图片
    if (!self.isCellImage) {
        // 判断是否需要自定义cell图片大小
        if (_isCellImageSize) {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }else {
            /** 图片 */
            [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(self.mas_left).offset(16);
                make.size.mas_equalTo(self.cellImageSize);
            }];
        }
    }else {
        /** 图片 */
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(11);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 文字 */
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellImage.mas_right).offset(5);
    }];
    // 判断有没有箭头
    if (!self.isArrow) {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-16);
        }];
    }else {
        /** 箭头 */
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-11);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    /** 描述文字 */
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.arrowImage.mas_left).offset(-5);
    }];
    /** 输入框副标题 */
    [self.viceTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.cellLabel.mas_right).offset(5);
        make.right.equalTo(self.describeLabel.mas_left).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    /** 分割线 */
    if (!self.isSplistLine) {
        /** 分割线样式 */
        switch (self.dividingLineChoice) {
            case DividingLineFullScreenLayout: {
                self.splistLineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
                break;
            }
            case DividingLineCenterLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 30, 0.5);
                break;
            }
            case DividingLineRightLayout: {
                self.splistLineView.frame = CGRectMake(15, self.height - 0.5, self.width - 15, 0.5);
                break;
            }
            default:
                break;
        }
    }
}

    
@end
