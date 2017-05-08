//
//  UIImage+Extension.h
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

// 缩放到指定大小
- (UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size;

// 通过缩放系数
- (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;
// 通过计算得到缩放系数
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;

@end
