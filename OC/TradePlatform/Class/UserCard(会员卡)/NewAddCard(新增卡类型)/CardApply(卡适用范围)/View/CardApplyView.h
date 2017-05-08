//
//  CardApplyView.h
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// 商品类型模型
#import "ServiceProviderModel.h"
// 商品
#import "CommodityShowStyleModel.h"
// cellview
#import "CardApplyCommodityCellView.h"

@protocol CardApplyDelegate <NSObject>

@optional
- (void)servicedidSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface CardApplyView : UIView

/** 服务类别 */
@property (strong, nonatomic) UITableView *serviceTable;
/** 当前选中的服务类别 */
@property (strong, nonatomic) UITableViewCell *selectedServiceCell;
/** 商品 */
@property (strong, nonatomic) UITableView *commodityTable;

/** 服务类别数据 */
@property (strong, nonatomic) NSMutableArray *serviceArray;
/** 商品数据 */
@property (strong, nonatomic) NSArray *commodityArray;

/** 商品服务区头名称 */
@property (strong, nonatomic) ServiceProviderModel *commodityScrvieStr;

/** 适用范围代理 */
@property (assign, nonatomic) id<CardApplyDelegate>delegate;


/** 选中的商品 */
@property (strong, nonatomic) NSMutableArray *chooseCommodityArray;
/** 选中的服务 */
@property (strong, nonatomic) NSMutableArray *chooseServiceArray;


@end
