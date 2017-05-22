//
//  StoreCell.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "StoreCell.h"
#import "StoreCellView.h"

@interface StoreCell ()

/** 订单cell */
@property (strong, nonatomic) StoreCellView *storeCellView;

@end
@implementation StoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = WhiteColor;
        /** 订单cell */
        self.storeCellView = [[StoreCellView alloc] init];
        [self.contentView addSubview:self.storeCellView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 订单cell */
    [self.storeCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}
-(void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    [self.storeCellView.storeImage setImageWithImageUrl:storeModel.thumb_image_url perchImage:@"placeholder_search_user"];
    self.storeCellView.storeNameLabel.text = storeModel.name;
    self.storeCellView.storeAddressLabel.text = storeModel.address;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
