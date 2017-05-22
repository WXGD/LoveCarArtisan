//
//  ModuleCell.h
//  TradePlatform
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleView.h"
#import "ServiceModuleModel.h"

@interface ModuleCell : UICollectionViewCell

/** 按钮1 */
@property (strong, nonatomic) ModuleView *btnOne;
/** 按钮2 */
@property (strong, nonatomic) ModuleView *btnTwo;
/** 按钮3 */
@property (strong, nonatomic) ModuleView *btnThree;


/** cell位置 */
@property (strong, nonatomic) NSIndexPath *indexPath;
/** 按钮数据 */
@property (strong, nonatomic) NSArray *btnArray;

@end

