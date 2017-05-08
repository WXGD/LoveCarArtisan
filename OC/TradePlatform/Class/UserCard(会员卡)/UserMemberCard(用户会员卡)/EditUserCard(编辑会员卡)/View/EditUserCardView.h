//
//  EditUserCardView.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditUserCardView : UIView

/** 卡号 */
@property (strong, nonatomic) UsedCellView *editCardNum;
/** 余次/余额 */
@property (strong, nonatomic) UsedCellView *editNoreThan;
/** 有效期 */
@property (strong, nonatomic) UsedCellView *editExpiryDate;

@end
