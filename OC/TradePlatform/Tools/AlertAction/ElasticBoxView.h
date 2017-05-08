//
//  ElasticBoxView.h
//  CarRepairMerchant
//
//  Created by apple on 2016/12/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElasticBoxView : UIView

/** 显示 */
- (void)show;
/** 销毁 */
- (void)dismiss;
/** 弹框内容 */
@property (nonatomic, strong) UIView *boxAlert;
/** 销毁按钮 */
@property (nonatomic, strong) UIButton *closeBtn;

@end
