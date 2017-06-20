//
//  Api.h
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef Api_h
#define Api_h

/** 账号的存储路径 */
#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Access.token"]


#define AppKey @"fee6db1d46f038bc7bdbf3f7d32857f9"
#define AppSecret @"0ffd650fd58944e5cc08188b64e60b4f"

// 商城web
//#define MallsWEBAPI @"http://x.cheweifang.cn/mall/"
#define MallsWEBAPI @"http://xtest.cheweifang.cn/mall/"
// url
//#define WEBAPI @"http://x.cheweifang.cn/web/"
#define WEBAPI @"http://xtest.cheweifang.cn/web/"
/** API */
//#define API @"https://xapi.cheweifang.cn/index.php"
#define API @"https://xapitest.cheweifang.cn/index.php"
/** API版本号 */
#define APIEdition @"1"
#define APITWOEdition @"2"


/** 日志开关 */ // DEBUG
#ifdef DE
#define PDLog(...) NSLog(__VA_ARGS__)
#else
#define PDLog(...)
#endif


#endif /* Api_h */
