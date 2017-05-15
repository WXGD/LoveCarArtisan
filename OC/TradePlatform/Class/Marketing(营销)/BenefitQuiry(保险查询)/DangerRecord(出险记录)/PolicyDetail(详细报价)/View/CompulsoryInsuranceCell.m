//
//  CompulsoryInsuranceCell.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CompulsoryInsuranceCell.h"

@implementation CompulsoryInsuranceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(JqxInsuranceCategorys *)model{
    _model = model;
    self.leftLab.text = model.insurance_category_name;
    self.centerLab.text = [NSString stringWithFormat:@"%.2f万元",model.coverage];
    self.rightLab.text = [NSString stringWithFormat:@"%.2f元",model.premium];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
