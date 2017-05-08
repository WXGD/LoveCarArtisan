//
//  CustomString.m
//  LoveCarEHome
//
//  Created by 爱车e家 on 16/4/25.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import "CustomString.h"

@implementation CustomString

#pragma mark - 获取缓存的大小
+ (NSString *)checkTmpSize {
    
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    //
    NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
    return currentVolum;
}
#pragma mark - 计算出大小
+ (NSString *)fileSizeWithInterge:(NSInteger)size {
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}
#pragma mark - 判断字符串是否包含中文
+ (BOOL)isChinese:(NSString *)str {
    for(int i=0; i< [str length];i++) {
        
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 判断字符串中是否有？
+ (BOOL)judgeWhetherHaveQuestionMark:(NSString *)str {
    for(int i =0; i < [str length]; i++) {
        NSString *string = [str substringWithRange:NSMakeRange(i, 1)];
        if ([string isEqualToString:@"?"]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark - 判断字符串中是否有？如果有就拼接一个&，如果没有就拼接？
+ (NSString *)judgeWhetherHaveQuestionMarkAlsoMosaicParameter:(NSString *)string {
    // 判断字符串中是否包含？
    if ([CustomString judgeWhetherHaveQuestionMark:string]) {
        return [string stringByAppendingString:@"&"];
    }else {
        return [string stringByAppendingString:@"?"];
    }
}
#pragma mark - 将url的参数拆分为一个字典
+ (NSMutableDictionary *)urlParameterSplitIntoDictionay:(NSString *)urlStr {
    // 判断字符串中是否包含？
    if ([CustomString judgeWhetherHaveQuestionMark:urlStr]) {
        NSArray *urlArray = [urlStr componentsSeparatedByString:@"?"];
        NSString *parameter = [urlArray lastObject];
        if (parameter.length != 0) {
            //获取问号的位置，问号后是参数列表
            NSRange range = [urlStr rangeOfString:@"?"];
//            NSLog(@"参数列表开始的位置：%d", (int)range.location);
            //获取参数列表
            NSString *propertys = [urlStr substringFromIndex:(int)(range.location+1)];
//            NSLog(@"截取的参数列表：%@", propertys);
            //进行字符串的拆分，通过&来拆分，把每个参数分开
            NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
//            NSLog(@"把每个参数列表进行拆分，返回为数组：\n%@", subArray);
            //把subArray转换为字典
            //tempDic中存放一个URL中转换的键值对
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
            // 给字典添加健值对
            for (int j = 0 ; j < subArray.count; j++) {
                //在通过=拆分键和值
                NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
//            NSLog(@"再把每个参数通过=号进行拆分：\n%@", dicArray);
                //给字典加入元素
                [tempDic setValue:dicArray[1] forKey:dicArray[0]];
            }
//            NSLog(@"打印参数列表生成的字典：\n%@", tempDic);
            return tempDic;
        }
    }
    return nil;
}
#pragma mark - 将字典作为URL参数
+ (NSString *)takeDictionayUrl:(NSString *)urlStr parameter:(NSDictionary *)dictionary {
    //URL
    NSMutableString *URL = [NSMutableString stringWithFormat:urlStr,nil];
    //获取字典的所有keys
    NSArray * keys = [dictionary allKeys];
    //拼接字符串
    for (int j = 0; j < keys.count; j++){
        NSString *string;
        if (j == 0){
            //拼接时加？
            string = [NSString stringWithFormat:@"?%@=%@", keys[j], dictionary[keys[j]]];
        }else{
            //拼接时加&
            string = [NSString stringWithFormat:@"&%@=%@", keys[j], dictionary[keys[j]]];
        }
        //拼接字符串
        [URL appendString:string];
    }
//    NSLog(@"拼接好参数的URL%@", URL);
    return URL;
}
#pragma mark - 将字典排序，并拼接成URL所需参数的样式
+ (NSString *)URLparameterSort:(NSDictionary *)parameter {
    //获取字典的所有keys
    NSArray * keys = [parameter allKeys];
    NSArray *array2 = [keys sortedArrayUsingSelector:@selector(compare:)];
    //拼接字符串
    NSMutableString *URLparameter = [[NSMutableString alloc] init];
    for (int key = 0; key < array2.count; key++){
        NSString *string;
        NSString *dicValue = parameter[array2[key]];
        if (key == 0){
            if (dicValue.length != 0 && dicValue) {
                string = [NSString stringWithFormat:@"%@=%@", array2[key], dicValue];
            }
        }else{
            if (dicValue.length != 0 && dicValue) {
                //拼接时加&
                string = [NSString stringWithFormat:@"&%@=%@", array2[key], dicValue];
            }
        }
        if (string) {
            //拼接字符串
            [URLparameter appendString:string];
        }
    }
//    NSLog(@"拼接好参数的%@", string);
    return URLparameter;
}

#pragma mark - 判断字符串是否包含问号
+ (BOOL)isSpecialQuestionMark:(NSString *)str {
    for(int i =0; i < [str length]; i++) {
        NSString *string = [str substringWithRange:NSMakeRange(i, 1)];
        if ([string isEqualToString:@"?"]) {
            return YES;
        }
    }
    return NO;
}


#pragma mark - 判断字符串是否包含特殊字符
+ (BOOL)isSpecialCharacter:(NSString *)str {
    for(int i =0; i < [str length]; i++) {
        NSString *string = [str substringWithRange:NSMakeRange(i, 1)];
        if ([string isEqualToString:@"("]) {
            return YES;
        }else if ([string isEqualToString:@")"]) {
            return YES;
        }else if ([string isEqualToString:@"#"]) {
            return YES;
        }else if ([string isEqualToString:@"*"]) {
            return YES;
        }else if ([string isEqualToString:@"$"]) {
            return YES;
        }else if ([string isEqualToString:@"¥"]) {
            return YES;
        }else if ([string isEqualToString:@"?"]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark - 获取字符串中的数字,去除字符串中的中文和特殊字符
+ (NSString *)getNumber:(NSString *)str {
    
    NSString *iphoneStr = [NSString new];
    for(int i =0; i < [str length]; i++) {
        
        NSString *string = [str substringWithRange:NSMakeRange(i, 1)];
        if (![CustomString isChinese:string] && ![CustomString isSpecialCharacter:string]) {
            iphoneStr = [iphoneStr stringByAppendingString:string];
        }
    }
    return iphoneStr;
}


#pragma mark - 获取电话号码,去除字符串中的中文和特殊字符
+ (NSString *)getIphoneNumber:(NSString *)str {
    NSString *iphoneStr = [NSString new];
    for(int i =0; i < [str length]; i++) {
        NSString *string = [str substringWithRange:NSMakeRange(i, 1)];
        if (![CustomString isChinese:string] && ![CustomString isSpecialCharacter:string]) {
            iphoneStr = [iphoneStr stringByAppendingString:string];
        }
    }
    NSString *telStr = [NSString stringWithFormat:@"%@%@", @"tel://", iphoneStr];
    return telStr;
}
#pragma mark - 去掉nav下面的黑线
+ (void)removeTheBlackLineBelowNav:(UINavigationBar *)selfNav {
    // 去掉nav下面的黑线
    if ([selfNav respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=selfNav.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}
#pragma mark - 当没有评论内容的时候，根据评分判断评论内容
+ (NSString *)commentFractionContent:(NSString *)fraction {
    // 判断是否有评论内容
    if ([fraction integerValue] < 3) {
        return @"差评";
    }else if ([fraction integerValue] == 3) {
        return @"满意";
    }else if ([fraction integerValue] > 3 ) {
        return @"好评";
    }
    return nil;
}
#pragma mark - 获取汉字字符串拼音首字母
+ (NSString *)firstNameByChineseName:(NSString *)aName {
    // 转化为可变字符串
    NSMutableString *mutableName = [NSMutableString stringWithString:aName];
    // 转化为带音调的拼音
    CFStringTransform((CFMutableStringRef) mutableName, NULL, kCFStringTransformMandarinLatin, NO);
    // 去掉音调
    CFStringTransform((CFMutableStringRef) mutableName, NULL, kCFStringTransformStripDiacritics, NO);
    // 截取首字母
    NSString *firstName = [mutableName substringToIndex:1];
    return [firstName uppercaseString];
}

#pragma mark - 计算字符串所占的高度
+ (CGFloat)heightForString:(NSString *)aString textFont:(UIFont *)textFont textWidth:(CGFloat)textWidth {
    // 根据给定的字体和字号还有控件的宽度，计算出当前字符串的高度
    NSDictionary *dic = @{NSFontAttributeName : textFont};
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(textWidth, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}

#pragma mark - 获取一段字符串中的中文字
+ (NSString *)getAStringOfChineseWord:(NSString *)string {
    if (string == nil || [string isEqual:@""]) {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i=0; i<[string length]; i++) {
        int a = [string characterAtIndex:i];
        if (a < 0x9fff && a > 0x4e00) {
            [arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    NSString *chineseText = [[NSString alloc] init];
    for (NSString *chineseStr in arr) {
        chineseText = [chineseText stringByAppendingString:chineseStr];
    }
    return chineseText;
}


@end

