//
//  HotView.h
//  CarRepairFactory
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageTxetBtn.h"

@protocol HotViewDelegate <NSObject>

@optional
- (void)hotViewBtnAction:(CarBrandModel *)brandModel;

@end

@interface HotView : UIView

/** 热门数据数组 */
@property (strong, nonatomic) NSArray *hotDataArray;


+ (HotView *)loadBlueViewFromXIB;
/** 布局热门车辆 */
- (void)hotBrandLayoutView;
/** 代理 */
@property (strong, nonatomic) id<HotViewDelegate>delegate;

@end
