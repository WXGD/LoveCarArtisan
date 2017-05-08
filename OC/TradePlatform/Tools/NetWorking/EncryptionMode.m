//
//  EncryptionMode.m
//  LoveCarMerchant
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//


#import "EncryptionMode.h"
#import "GJMD5.h"


@implementation EncryptionMode

NSTimeInterval timeInterval;

// sigMD5加密
- (NSString *)repuestUrlAddSig {
    timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%.f", timeInterval];
    NSString *sig = [NSString stringWithFormat:@"%@%@%@", AppKey, AppSecret, timeStr];
    NSString *sigMD5 = [GJMD5 md5HexDigest:sig];
    NSString *addSig = [NSString stringWithFormat:@"?sig=%@", sigMD5];
    return addSig;
}
// Authorizationbase64加密
- (NSString *)repuestAuthorization  {
    NSString *timeStr = [NSString stringWithFormat:@"%.f", timeInterval];
    NSString *authorization = [NSString stringWithFormat:@"%@:%@", AppKey, timeStr];
    NSData *nsdata = [authorization dataUsingEncoding:NSUTF8StringEncoding];
    NSString* base64Encoded = [nsdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64Encoded;
}



// sigMD5加密
+ (NSString *)repuestUrlAddSigParameters:(NSMutableDictionary *)parameters timeStr:(NSString *)timeStr {
    // 获取URL参数，并将参数变成一个字典
    // 初始化一个字符串
    NSString *URLparameter = [[NSString alloc] init];
    if (parameters) {
        // 将字典排序，并用&链接在一起
        URLparameter = [CustomObject dicPiecesURLStr:parameters];
    }else {
        // 如果字典为空，初始化一个字典
        parameters = [[NSMutableDictionary alloc] init];
    }
    PDLog(@"sig-parameters%@", parameters);
    // 拼接sig参数
    NSString *sig = [NSString stringWithFormat:@"%@%@%@%@", AppKey, AppSecret, timeStr, URLparameter];
    PDLog(@"sig%@", sig);
    // md5加密
    NSString *sigMD5 = [GJMD5 md5HexDigest:sig];
    return sigMD5;
}
// Authorizationbase64加密
+ (NSString *)repuestAuthorizationTimeStr:(NSString *)timeStr {
    NSString *authorization = [NSString stringWithFormat:@"%@:%@", AppKey, timeStr];
    NSData *nsdata = [authorization dataUsingEncoding:NSUTF8StringEncoding];
    NSString* base64Encoded = [nsdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64Encoded;
}



@end
