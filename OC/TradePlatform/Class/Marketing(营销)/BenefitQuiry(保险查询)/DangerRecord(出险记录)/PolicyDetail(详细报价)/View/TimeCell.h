//
//  TimeCell.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PolicyDetailModel.h"

@interface TimeCell : UITableViewCell
@property (strong, nonatomic) InsuranceEndTimeModel *endModel;

@property (strong, nonatomic) InsuranceStartTimeModel *startModel;

@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

@end
