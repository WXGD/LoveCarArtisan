//
//  SmallPrintCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SmallPrintCell.h"

@interface SmallPrintCell ()

/** cell标题 */
@property (strong, nonatomic) UILabel *cllTitleLabel;
/** cell选中标记 */
@property (strong, nonatomic) UIImageView *cellImg;
/** cell分割线 */
@property (strong, nonatomic) UIView *cellLineView;

@end

@implementation SmallPrintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = WhiteColor;
        /** cell标题 */
        self.cllTitleLabel = [[UILabel alloc] init];
        self.cllTitleLabel.text = @"不计免赔";
        self.cllTitleLabel.textColor = Black;
        self.cllTitleLabel.font = FourteenTypeface;
        [self.contentView addSubview:self.cllTitleLabel];
        /** cell选中标记 */ 
        self.cellImg = [[UIImageView alloc] init];
        self.cellImg.image = [UIImage imageNamed:@"benefit_small_print_fit"];
        [self.cellImg setHidden:YES];
        [self.contentView addSubview:self.cellImg];
        /** cell分割线 */
        self.cellLineView = [[UIView alloc] init];
        self.cellLineView.backgroundColor = DividingLine;
        [self.contentView addSubview:self.cellLineView];
    }
    return self;
}

/** 标题 */
- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    if ([titleStr isEqualToString:@"不投保"]  || [titleStr isEqualToString:@"投保"]) {
        /** cell标题 */
        self.cllTitleLabel.text = titleStr;
    }else {
        /** cell标题 */
        self.cllTitleLabel.text = [NSString stringWithFormat:@"%@万", titleStr];
    }
}

/** 选中标记 */
- (void)setCheckMark:(BOOL)checkMark {
    _checkMark = checkMark;
    if (checkMark) { // 选中
        [self.cellImg setHidden:NO];
        self.cllTitleLabel.textColor = ThemeColor;
    }else { // 没有选中
        [self.cellImg setHidden:YES];
        self.cllTitleLabel.textColor = Black;
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** cell标题 */
    [self.cllTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    /** cell选中标记 */
    [self.cellImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    /** cell分割线 */
    [self.cellLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
}

@end
