//
//  StoreCellView.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCellView : UIView
/** 门店图片 */
@property (nonatomic, strong) UIImageView *storeImage;
/** 门店名称 */
@property (nonatomic, strong) UILabel *storeNameLabel;
/** 门店地址 */
@property (nonatomic, strong) UILabel *storeAddressLabel;
/** 箭头 */
@property (nonatomic, strong) UIImageView *arrowImage;
@end
