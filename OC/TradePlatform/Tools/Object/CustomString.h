//
//  CustomString.h
//  LoveCarEHome
//
//  Created by 爱车e家 on 16/4/25.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomString : NSString

/** 获取缓存的大小 */
+ (NSString *)checkTmpSize;
/** 计算出缓存的大小 */
+ (NSString *)fileSizeWithInterge:(NSInteger)size;
/** 判断字符串是否包含中文 */
+ (BOOL)isChinese:(NSString *)str;
/** 判断字符串是否包含问号 */
+ (BOOL)isSpecialQuestionMark:(NSString *)str;
/** 判断字符串是否包含特殊字符 */
+ (BOOL)isSpecialCharacter:(NSString *)str;
/** 判断字符串中是否有？ */
+ (BOOL)judgeWhetherHaveQuestionMark:(NSString *)str;
/** 判断字符串中是否有？如果有就拼接一个&，如果没有就C？ */
+ (NSString *)judgeWhetherHaveQuestionMarkAlsoMosaicParameter:(NSString *)string;
/** 获取电话号码,去除字符串中的中文和特殊字符 */
+ (NSString *)getIphoneNumber:(NSString *)str;
/** 获取字符串中的数字,去除字符串中的中文和特殊字符 */
+ (NSString *)getNumber:(NSString *)str;
/** 去掉nav下面的黑线 */
+ (void)removeTheBlackLineBelowNav:(UINavigationBar *)selfNav;
/** 将url的参数拆分为一个字典 */
+ (NSMutableDictionary *)urlParameterSplitIntoDictionay:(NSString *)urlStr;
/** 将字典作为URL参数 */
+ (NSString *)takeDictionayUrl:(NSString *)urlStr parameter:(NSDictionary *)dictionary;
/** 将字典排序，并拼接成URL所需参数的样式 */
+ (NSString *)URLparameterSort:(NSDictionary *)parameter;
/** 当没有评论内容的时候，根据评分判断评论内容 */
+ (NSString *)commentFractionContent:(NSString *)fraction;
/** 获取汉字字符串拼音首字母 */
+ (NSString *)firstNameByChineseName:(NSString *)aName;
/** 计算字符串所占的高度 */
+ (CGFloat)heightForString:(NSString *)aString textFont:(UIFont *)textFont textWidth:(CGFloat)textWidth;
/** 获取一段字符串中的中文字 */
+ (NSString *)getAStringOfChineseWord:(NSString *)string;




@end
