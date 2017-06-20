//
//  PlnCellView.h
//  TradePlatform
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaftaBtn : UIView

/** 标题文字 */
@property (strong, nonatomic) UILabel *titleLabel;
/** 标记图片 */
@property (strong, nonatomic) UIImageView *signImage;
/** 按钮 */
@property (strong, nonatomic) UIButton *caftaBtn;


@end


@interface PlnCellView : UIView

/** 车牌号输入框 */
@property (strong, nonatomic) UITextField *plnTF;
/** 选择车辆按钮 */
@property (strong, nonatomic) UIButton *choiceCarBtn;
/** 城市简称按钮 */
@property (strong, nonatomic) CaftaBtn *caftaBtn;

@end






