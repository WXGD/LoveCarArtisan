//
//  CustomObject.h
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomObject : NSObject

#pragma mark -

/**
* 将字典排序，并拼接成URL所需参数的样式
*
* @parameter dic:需要拼接的字典
* @return URL样式的字符串
*/
+ (NSString *)dicPiecesURLStr:(NSDictionary *)dic;
/**
 * 判断电话号码的合法性
 *
 * @parameter str:手机号
 */
+ (BOOL)checkTel:(NSString *)str;
/**
 * 判断邮箱的合法性
 *
 * @parameter email:邮箱
 */
+ (BOOL)isValidateEmail:(NSString *)email;
/**
 * 判断输入价格的合法性
 *
 * @parameter money:金额
 */
+ (BOOL)isMoney:(NSString *)money;
/**
 * 判断字符串是不是车牌号类型
 *
 * @parameter money:车牌号
 */
+ (BOOL)isPlnNumber:(NSString *)plnNumber;
/**
 * 按钮倒计时
 *
 * @parameter sender:需要显示倒计时等按钮
 */
+ (void)buttonCountdown:(UIButton *)sender;
/**
 * 判断是否是指定控制器
 *
 * @parameter currentVC:当前控制器
 * @parameter cppointVC:指定控制器
 */
+ (BOOL)judgeAppointController:(Class)appointVC currentVC:(UIViewController *)currentVC;

@end
