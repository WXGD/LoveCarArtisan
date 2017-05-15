//
//  TimeCell.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TimeCell.h"

@implementation TimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setStartModel:(InsuranceStartTimeModel *)startModel{
    _startModel = startModel;
    self.leftLab.text = [NSString stringWithFormat:@"%@生效时间",startModel.name];
    self.rightLab.text = startModel.restart_by_time;
}
-(void)setEndModel:(InsuranceEndTimeModel *)endModel{
    _endModel = endModel;
    self.leftLab.text = [NSString stringWithFormat:@"%@到期时间",endModel.name];
    self.rightLab.text = endModel.used_by_time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
