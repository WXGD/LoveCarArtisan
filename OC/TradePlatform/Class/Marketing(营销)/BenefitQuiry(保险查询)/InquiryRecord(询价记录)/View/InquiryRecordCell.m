//
//  InquiryRecordCell.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "InquiryRecordCell.h"
@interface InquiryRecordCell()
@property (weak, nonatomic) IBOutlet UIView *reasonView;
@property (weak, nonatomic) IBOutlet UIView *lookDetailView;

@end
@implementation InquiryRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setInquiryModel:(InquiryRecordModel *)inquiryModel{
    _reasonHeightConst.constant = 66;
    _lookDetailHeightConst.constant = 44;
    _inquiryModel = inquiryModel;
    _carNumLab.text = inquiryModel.car_plate_no;
    _nameLab.text = inquiryModel.name;
    _timeLab.text = inquiryModel.create_time;
    _carTypeLab.text = inquiryModel.license_brand_model;
    if (inquiryModel.status==1) {
        _stateLab.text = @"报价中";
        _stateLab.textColor = GrayH1;
        _reasonHeightConst.constant = 0;
        for (UIView *vi in _reasonView.subviews) {
            [vi removeFromSuperview];
        }
        _lookDetailHeightConst.constant = 0;
        for (UIView *vi in _lookDetailView.subviews) {
            [vi removeFromSuperview];
        }
    }else if (inquiryModel.status == 2) {
        _stateLab.text = @"已报价";
        _stateLab.textColor = ThemeColor;
        _reasonHeightConst.constant = 0;
        for (UIView *vi in _reasonView.subviews) {
            [vi removeFromSuperview];
        }
    }else if (inquiryModel.status == 7) {
        _stateLab.text = @"已出保";
        _stateLab.textColor = GrayH1;
        _reasonHeightConst.constant = 0;
        for (UIView *vi in _reasonView.subviews) {
            [vi removeFromSuperview];
        }
        _lookDetailHeightConst.constant = 0;
        for (UIView *vi in _lookDetailView.subviews) {
            [vi removeFromSuperview];
        }
    }else {
        _stateLab.text = @"核保失败";
        _stateLab.textColor = HEXSTR_RGB(@"ef5350");
        _lookDetailHeightConst.constant = 0;
        for (UIView *vi in _lookDetailView.subviews) {
            [vi removeFromSuperview];
        }
        _reasonLab.text = inquiryModel.fail_reason;
        _noteLab.text = inquiryModel.remark;
    }
}
- (IBAction)lookDetailClick:(id)sender {
    if (_lookDetailClick) {
        _lookDetailClick(_inquiryModel);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
