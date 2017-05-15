//
//  AccountBankCell.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AccountBankCell.h"

@implementation AccountBankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.cornerRadius = 4;
    _bgView.clipsToBounds = YES;
}
-(void)setBankCommonModel:(BankCommonModel *)bankCommonModel{
    _bankCommonModel = bankCommonModel;
    self.bankNameLab.text = bankCommonModel.bank;
    self.bankNumLab.text = bankCommonModel.card_no;
    if (_bankViewFrom == 1) {
        _cancelBtn.hidden = YES;
        _setBtn.hidden = YES;
        if (_indP.row==0) {
            _setBtn.hidden = NO;
            _setBtn.enabled = NO;
            [_setBtn setTitle:@"当前提现账户" forState:UIControlStateNormal];
        }
    }else if (_bankViewFrom == 2) {
        _cancelBtn.hidden = NO;
        _setBtn.hidden = NO;
        _cancelBtn.enabled = YES;
        _setBtn.enabled = YES;
        if (_indP.row==0) {
            _setBtn.enabled = NO;
            _setBtnWidthConstraint.constant = 90;
            _setBtn.layer.borderWidth = 0;
            [_setBtn setTitle:@"当前提现账户" forState:UIControlStateNormal];
            _setBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
        }else{
            _setBtnWidthConstraint.constant = 105;
            _setBtn.layer.borderWidth = 1;
            _setBtn.layer.borderColor = ThemeColor.CGColor;
            _setBtn.layer.cornerRadius = 1;
            _setBtn.clipsToBounds = YES;
            [_setBtn setTitle:@"设为默认提现账户" forState:UIControlStateNormal];
            _setBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
}
- (IBAction)cancelBtnClick:(id)sender {
    if (_cancelBtnClick) {
        _cancelBtnClick(_bankCommonModel);
    }
}
- (IBAction)setBtnClick:(id)sender {
    if (_setDefaultBtnClick) {
        _setDefaultBtnClick(_bankCommonModel);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
