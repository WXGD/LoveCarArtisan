//
//  CompulsoryInsuranceCell.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolicyDetailModel.h"

@interface CompulsoryInsuranceCell : UITableViewCell
@property (strong, nonatomic) JqxInsuranceCategorys *model;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *centerLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

@end
