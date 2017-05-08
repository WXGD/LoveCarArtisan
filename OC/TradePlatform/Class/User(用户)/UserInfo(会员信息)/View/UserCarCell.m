//
//  UserCarCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCarCell.h"

@interface UserCarCell ()


@end

@implementation UserCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userCarView = [[UserCarView alloc] init];
        [self.contentView addSubview:self.userCarView];
    }
    return self;
}

- (void)setUserCarModel:(UserCarModel *)userCarModel {
    _userCarModel = userCarModel;
    /** 车品牌图片 */
    [self.userCarView.carBrandImage setImageWithImageUrl:userCarModel.image perchImage:@"placeholder_car"];
    /** 车系 */
    self.userCarView.carBrandLabel.text = userCarModel.car_brand_series;
    /** 车牌号 */
    self.userCarView.carPlnLabel.text = userCarModel.car_plate_no;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.userCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

@end
