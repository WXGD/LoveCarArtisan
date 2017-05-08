//
//  CancellationViewCell.h
//  TradePlatform
//
//  Created by 弓杰 on 2017/3/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leftRigText.h"
// 模型
#import "CancellationModel.h"

@interface CancellationViewCell : UITableViewCell

/** 核销按钮 */
@property (nonatomic, strong) UIButton *cancellationBtn;
/** 赠品模型 */
@property (nonatomic, strong) CancellationModel *cancellationModel;

@end
