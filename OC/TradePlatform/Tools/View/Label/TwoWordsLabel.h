//
//  TwoWordsLabel.h
//  TradePlatform
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

// 自定义两个label共同样式类型
typedef NS_ENUM(NSInteger, TwoWordsShowStyle) {
    /** 两个文字纵向布局，并相对父视图居中 */
    TextVerticallyLayoutAndSuperCenter,
    /** 两个文字横向布局，并相对父视图居中 */
    TextHorizontalLayoutAndSuperCenter,
    /** 两个文字和主图片纵向布局，并相对父视图居中 */
    TextAndImageVerticallyLayoutAndSuperCenter,
    /** 主图片和两个文字纵向布局，两个文字横向布局，并相对父视图居中 */
    ImageVerticallyAndHorizontalLayoutAndSuperCenter,
};


#import <UIKit/UIKit.h>

@interface TwoWordsLabel : UIView

/** 主图片 */
@property (strong, nonatomic) UIImageView *mainImage;
/** 主文字 */
@property (strong, nonatomic) UILabel *mainLabel;
/** 副文字 */
@property (strong, nonatomic) UILabel *viceLabel;
/** text样式 */
@property (assign, nonatomic) TwoWordsShowStyle twoWordsShowStyle;

@end
