//
//  BusinessInsuranceCell.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolicyDetailModel.h"

@interface BusinessInsuranceCell : UITableViewCell
@property (strong, nonatomic) SyxInsuranceCategorys *model;

@property (weak, nonatomic) IBOutlet UILabel *leftOneLab;

@property (weak, nonatomic) IBOutlet UILabel *leftTwoLab;

@property (weak, nonatomic) IBOutlet UILabel *leftThreeLab;

@property (weak, nonatomic) IBOutlet UILabel *leftFourLab;
@end
