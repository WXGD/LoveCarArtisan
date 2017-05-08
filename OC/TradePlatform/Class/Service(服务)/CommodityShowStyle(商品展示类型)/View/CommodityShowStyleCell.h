//
//  CommodityShowStyleCell.h
//  TradePlatform
//
//  Created by 弓杰 on 2016/12/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GJBaseTableViewCell.h"
#import "CommodityShowStyleModel.h"
#import "CommodityOperationBtn.h"

@interface CommodityShowStyleCell : UITableViewCell

@property (nonatomic, strong) CommodityShowStyleModel *commodityShowModel;
/** 上架 */
@property (strong, nonatomic) CommodityOperationBtn *shelvesBtn;
/** 下架 */
@property (strong, nonatomic) CommodityOperationBtn *theShelfBtn;

@end
