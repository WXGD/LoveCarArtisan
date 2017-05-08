//
//  ValuationRecordCell.h
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValuationNotesModel.h"

@interface ValuationRecordCell : UITableViewCell

/** 估值记录模型 */
@property (strong, nonatomic) ValuationNotesModel *valuationNotesModel;

@end
