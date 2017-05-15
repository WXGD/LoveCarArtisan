//
//  BusinessInsuranceCell.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BusinessInsuranceCell.h"

@implementation BusinessInsuranceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(SyxInsuranceCategorys *)model{
    _model = model;
    self.leftOneLab.text = model.insurance_category_name;
    self.leftTwoLab.text = [NSString stringWithFormat:@"%.2f万元",model.coverage];
    self.leftFourLab.text = [NSString stringWithFormat:@"%.2f元",model.premium];
    if (model.is_free == 1) {
        self.leftThreeLab.text = @"不计";
    }else {
        self.leftThreeLab.text = @"";
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
