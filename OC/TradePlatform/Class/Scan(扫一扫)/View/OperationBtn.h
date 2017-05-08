//
//  OperationBtn.h
//  Photo
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationBtn : UIView

/** 图片 */
@property (strong, nonatomic) UIImageView *operationImage;
/** 文字 */
@property (strong, nonatomic) UILabel *operationText;
/** 按钮 */
@property (strong, nonatomic) UIButton *operationButton;

@end
