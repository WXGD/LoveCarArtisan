//
//  CustomObject.m
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CustomObject.h"

@implementation CustomObject


#pragma mark - 将字典排序，并拼接成URL所需参数的样式
+ (NSString *)dicPiecesURLStr:(NSDictionary *)dic {
    //获取字典的所有keys
    NSArray * keys = [dic allKeys];
    NSArray *array2 = [keys sortedArrayUsingSelector:@selector(compare:)];
    //拼接字符串
    NSMutableString *URLparameter = [[NSMutableString alloc] init];
    for (int key = 0; key < array2.count; key++){
        NSString *string;
        NSString *dicValue = dic[array2[key]];
        if (key == 0){
            NSString *value = [NSString stringWithFormat:@"%@", dicValue];
            if (value.length != 0 && dicValue) {
                string = [NSString stringWithFormat:@"%@=%@", array2[key], dicValue];
            }
        }else{
            NSString *value = [NSString stringWithFormat:@"%@", dicValue];
            if (value.length != 0 && dicValue) {
                // 判断此时URLparameter是否有值
                if (URLparameter.length == 0) {
                    //拼接时加&
                    string = [NSString stringWithFormat:@"%@=%@", array2[key], dicValue];
                }else {
                    //拼接时加&
                    string = [NSString stringWithFormat:@"&%@=%@", array2[key], dicValue];
                }
            }
        }
        if (string) {
            //拼接字符串
            [URLparameter appendString:string];
        }
    }
    PDLog(@"=====URLparameter====%@", URLparameter);
    return URLparameter;
}

#pragma mark -  判断电话号码的合法性
+ (BOOL)checkTel:(NSString *)str {
    
    /**
     * 手机号码: 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8],
     * 18[0-9], 170[0-9]
     *
     * 移动号段:134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,
     * 188, 147,178,1705
     *
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     *
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *mobileRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,
     * 147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    NSPredicate *predCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    /**
     * 中国联通：China Unicom 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    NSPredicate *predCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    /**
     * 中国电信：China Telecom 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *predCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    BOOL isMatch = NO;
    if ([pred evaluateWithObject:str] || [predCM evaluateWithObject:str] || [predCU evaluateWithObject:str] || [predCT evaluateWithObject:str]) {
        isMatch = YES;
    }
    return isMatch;
}
#pragma mark - 判断邮箱的合法性
+ (BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark - 判断字符串是不是金钱类型
+ (BOOL)isMoney:(NSString *)money {
    
    NSString *moneyRegex = @"^\\d+(.\\d{1,2})?$";
    NSPredicate *moneyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", moneyRegex];
    return [moneyTest evaluateWithObject:money];
}
#pragma mark - 判断字符串是不是车牌号类型
+ (BOOL)isPlnNumber:(NSString *)plnNumber {
    NSString *moneyRegex = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Za-z]{1}[A-Za-z]{1}[A-Za-z0-9]{4}[A-Za-z0-9挂学警港澳]{1}$";
    NSPredicate *moneyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", moneyRegex];
    return [moneyTest evaluateWithObject:plnNumber];
}
#pragma mark - 按钮倒计时
+ (void)buttonCountdown:(UIButton *)sender {
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60 == 0 ? 60 : timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 判断是否是指定控制器
+ (BOOL)judgeAppointController:(Class)appointVC currentVC:(UIViewController *)currentVC {
    for (UIViewController *controller in currentVC.navigationController.viewControllers) {
        if ([controller isKindOfClass:appointVC]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 返回到指定控制器 
+ (void)returnAppointController:(Class)appointVC currentVC:(UIViewController *)currentVC {
    for (UIViewController *controller in currentVC.navigationController.viewControllers) {
        if ([controller isKindOfClass:appointVC]) {
            [currentVC.navigationController popToViewController:controller animated:YES];
        }
    }
}

#pragma mark - 判断身份证是否有效
+ (BOOL)isIDCorrect:(NSString *)IDNumber

{
    if (IDNumber.length!=18) {
        return NO;
    }
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}
@end
