//
//  UsedCarBrandCell.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarBrandCell.h"

@interface UsedCarBrandCell ()

/** 品牌名 */
@property (nonatomic, strong) UILabel *carBrandName;
/** 品牌图标 */
@property (nonatomic, strong) UIImageView *carBrandImage;
/** 分割线 */
@property (nonatomic, strong) UIView *carBrandLineView;

@end

@implementation UsedCarBrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 品牌图标 */
        self.carBrandImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.carBrandImage];
        /** 品牌名 */
        self.carBrandName = [[UILabel alloc] init];
        self.carBrandName.textColor = Black;
        self.carBrandName.font = FifteenTypeface;
        [self.contentView addSubview:self.carBrandName];
        /** 分割线 */
        self.carBrandLineView = [[UIView alloc] init];
        self.carBrandLineView.backgroundColor = VCBackground;
        [self.contentView addSubview:self.carBrandLineView];
    }
    return self;
}


- (void)setUsedCarBrandModel:(UsedCarBrandModel *)usedCarBrandModel {
    _usedCarBrandModel = usedCarBrandModel;
    /** 品牌名 */
    self.carBrandName.text = usedCarBrandModel.name;
    /** 品牌图标 */
    [self.carBrandImage setImageWithImageUrl:usedCarBrandModel.image_src perchImage:@"placeholder_car"];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 品牌图标 */
    [self.carBrandImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    /** 品牌名 */
    [self.carBrandName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.carBrandImage.mas_right).offset(16);
    }];
    /** 分割线 */
    [self.carBrandLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.carBrandName.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
}


@end
