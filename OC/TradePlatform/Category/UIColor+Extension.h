//
//  UIColor+Extension.h
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

/** 从十六进制字符串获取颜色 */
#define HEXSTR_RGB(V)   [UIColor colorWithHexString:V]
#define HEXSTR_RGBA(V, A)   [UIColor colorWithHexString:V alpha:A]
/** 从十六进制数字获取颜色 */
#define HEX_RGB(V)  [UIColor colorWithHex:V]
#define HEX_RGBA(V, A)   [UIColor colorWithHex:V alpha:A]
/** RGB颜色 */
#define RGB(R,G,B)  [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#define RGBA(R,G,B,A)   [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
/** 随机色 */
#define RANDOMCOLOR [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1]
/** 清除背景色 */
#define CLEARCOLOR [UIColor clearColor]


#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 * 从十六进制字符串获取颜色
 *
 * @parameter color:16进制字符串。支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 * @parameter alpha:透明度
 * @return 颜色。color类型
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/**
 * 从十六进制字符串获取颜色，透明度默认为1
 *
 * @parameter color:16进制字符串。支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 * @return 颜色。color类型
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
/**
 * 从十六进制数字获取颜色
 *
 * @parameter color:16进制数字
 * @parameter alpha:透明度
 * @return 颜色。color类型
 */
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
/**
 * 从十六进制数字获取颜色，透明度默认为1
 *
 * @parameter color:16进制数字
 * @return 颜色。color类型
 */
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
/**
 * 把color类型颜色转换成十六进制字符
 *
 * @parameter color:颜色
 * @return 十六进制字符
 */
+ (NSString *)hexFromUIColor:(UIColor*)color;

@end
