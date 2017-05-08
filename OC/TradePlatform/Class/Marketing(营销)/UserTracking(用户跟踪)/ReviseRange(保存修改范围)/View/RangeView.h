//
//  RangeView.h
//  Text
//
//  Created by 弓杰 on 2017/5/1.
//  Copyright © 2017年 弓杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RangeView : UIView

/** 开始时间 */
@property (strong, nonatomic) UITextField *startTF;
/** 结束时间 */
@property (strong, nonatomic) UITextField *endTF;
/** 操作按钮 */
@property (strong, nonatomic) UIButton *handleBtn;

@end
