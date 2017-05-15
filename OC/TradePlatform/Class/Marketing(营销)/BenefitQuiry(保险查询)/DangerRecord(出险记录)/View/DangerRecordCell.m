//
//  DangerRecordCell.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DangerRecordCell.h"

@implementation DangerRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/** 查看保单Action */
- (IBAction)lookDetailClick:(id)sender {
    if (_lookDetailClick) {
        _lookDetailClick(@"");
    }
}
-(void)setDangerModel:(DangerRecordModel *)dangerModel{
    _dangerModel = dangerModel;
    self.carNumLab.text = dangerModel.car_plate_no;
    self.stateLab.textColor = GrayH1;
    if (dangerModel.status == 1) {
        self.stateLab.text = @"待支付";
        for (UIView *vi in _lookDetailView.subviews) {
            [vi removeFromSuperview];
        }
        _lookDetailHeightConst.constant = 0;
    }else if (dangerModel.status == 2) {
        self.stateLab.text = @"出保中";
        for (UIView *vi in _lookDetailView.subviews) {
            [vi removeFromSuperview];
        }
        _lookDetailHeightConst.constant = 0;
    }else if (dangerModel.status == 3) {
        self.stateLab.text = @"已出保";
        self.stateLab.textColor = HEXSTR_RGB(@"#45c018");
        _lookDetailHeightConst.constant = 43;
    }
    self.nameLab.text = dangerModel.owner_name;
    self.carTypeLab.text = dangerModel.license_brand_model;
    self.insuranceTypeLab.text = dangerModel.insurance_company_name;
    self.insuranceMoneyLab.text = [NSString stringWithFormat:@"%.2f元",dangerModel.actual_total_price];    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
