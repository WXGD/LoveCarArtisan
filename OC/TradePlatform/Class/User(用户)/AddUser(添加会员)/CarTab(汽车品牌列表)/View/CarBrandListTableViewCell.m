//
//  CarBrandListTableViewCell.m
//  CarRepairFactory
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarBrandListTableViewCell.h"

@interface CarBrandListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageStr;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CarBrandListTableViewCell

- (void)setBrandModel:(CarBrandModel *)brandModel {
    
    _brandModel = brandModel;
    self.nameLabel.text = brandModel.name;
    [self.imageStr setImageWithImageUrl:brandModel.image perchImage:@"placeholder_car"];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
