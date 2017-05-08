//
//  RootViewController.h
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

/** 新版登陆商户信息 */
@property (nonatomic, strong) MerchantInfoModel *merchantInfo;

/**
 *  显示没有数据页面
 */
-(void)showNoDataView:(void(^)(UILabel *noLabel, UIImageView *noImage))noDataView;

/**
 *  移除无数据页面
 */
-(void)removeNoDataView;


@end
