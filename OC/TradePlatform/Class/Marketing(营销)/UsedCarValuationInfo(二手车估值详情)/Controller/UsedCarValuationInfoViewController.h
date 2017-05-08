//
//  UsedCarValuationInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "ValuationNotesModel.h"

@interface UsedCarValuationInfoViewController : RootViewController

/** 估值记录模型 */
@property (strong, nonatomic) ValuationNotesModel *valuationNotesModel;

@end
