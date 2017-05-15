//
//  Config.h
//  CarRepairMerchant
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef Config_h
#define Config_h


/*************************************************手机屏幕尺寸**********************************************/
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPad ([[UIScreen mainScreen] currentMode].size.width/[[UIScreen mainScreen] currentMode].size.height>0.7)
/*************************************************尺寸**********************************************/
//NavBar高度
#define NavigationBar_HEIGHT 44
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/** 屏幕宽高 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height - 64
/*************************************************系统**********************************************/
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
// app信息字典
#define APP_INFO [[NSBundle mainBundle] infoDictionary]
// 获取软件版本号 version
#define VERSION [APP_INFO objectForKey:@"CFBundleShortVersionString"]
// 获取内部软件版本号 build
#define BUILD [APP_INFO objectForKey:@"CFBundleVersion"]
// UDID
#define UDID [[UIDevice currentDevice].identifierForVendor UUIDString]
/*************************************************图片**********************************************/
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]
//建议使用前两种宏定义,性能高于后者
/*************************************************颜色**********************************************/
/** 主题色 */
#define ThemeColor [UIColor colorWithRed:69/255.0 green:192/255.0 blue:24/255.0 alpha:1]
/** 白色 */
#define WhiteColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
/** 红色 */
#define RedColor [UIColor colorWithRed:229/255.0 green:57/255.0 blue:53/255.0 alpha:1]
/** 蓝色 */
#define BlueColor [UIColor colorWithRed:30/255.0 green:136/255.0 blue:229/255.0 alpha:1]
/** 黑色 */
#define Black [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
/** 黑色4c4c4c */
#define BlackH1 [UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1]
/** 深灰色 */
#define GrayH1 [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
/** 次灰色 */
#define GrayH2 [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]
/** 浅灰色 */
#define GrayH3 [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1]
/** 浅灰色cccccc */
#define GrayH4 [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
/** 浅灰色dddddd */
#define GrayH5 [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]
/** 按钮不可点击颜色 */
#define NotClick [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1]
/** 分割线颜色 */
#define DividingLine [UIColor colorWithRed:229 / 254.0 green:229 / 254.0 blue:229 / 254.0 alpha:1]
/** 控制器背景颜色 */
#define VCBackground [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
#define VCBackgroundTwo [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
#define VCBackgroundThree [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]
/*************************************************text字号**********************************************/
/** 10号字 */
#define TenTypeface [UIFont systemFontOfSize:10]
/** 11号字 */
#define ElevenTypeface [UIFont systemFontOfSize:11]
/** 12号字 */
#define TwelveTypeface [UIFont systemFontOfSize:12]
/** 13号字 */
#define ThirteenTypeface [UIFont systemFontOfSize:13]
/** 14号字 */
#define FourteenTypeface [UIFont systemFontOfSize:14]
/** 14号加粗字 */
#define FourteenTypefaceBold [UIFont fontWithName:@"Helvetica-Bold" size:14]
/** 15号字 */
#define FifteenTypeface [UIFont systemFontOfSize:15]
/** 15号加粗字 */
#define FifteenTypefaceBold [UIFont fontWithName:@"Helvetica-Bold" size:15]
/** 16号字 */
#define SixteenTypeface [UIFont systemFontOfSize:16]
/** 16号加粗字 */
#define SixteenTypefaceBold [UIFont fontWithName:@"Helvetica-Bold" size:16]
/** 17号字 */
#define SeventeenTypeface [UIFont systemFontOfSize:17]
/** 18号字 */
#define EighteenTypeface [UIFont systemFontOfSize:18]
/** 18号加粗字 */
#define EighteenTypefaceBold [UIFont fontWithName:@"Helvetica-Bold" size:18]
/** 19号字 */
#define NineteenTypeface [UIFont systemFontOfSize:19]
/** 20号字 */
#define TwentyTypeface [UIFont systemFontOfSize:20]
/** 21号字 */
#define  TwentyOneTypeface [UIFont systemFontOfSize:21]
/** 22号字 */
#define  TwentyTwoTypeface [UIFont systemFontOfSize:22]
/** 23号字 */
#define  TwentyThreeTypeface [UIFont systemFontOfSize:23]
/** 24号字 */
#define  TwentyFourTypeface [UIFont systemFontOfSize:24]
/** 24号字加粗字 */
#define  TwentyFourTypefaceBold [UIFont fontWithName:@"Helvetica-Bold" size:24]
/** 30号字 */
#define  ThirtyTypeface [UIFont systemFontOfSize:30]
/** 36号字 */
#define  ThirtySixTypeface [UIFont systemFontOfSize:36]
/** 40号字 */
#define  FortyTypeface [UIFont systemFontOfSize:40]
/*************************************************其他**********************************************/
//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]
//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
// 屏幕设计高度比例
#define HScale [UIScreen mainScreen].bounds.size.height / 640
// 屏幕设计宽度度比例
#define WScale [UIScreen mainScreen].bounds.size.width / 360
// 客服电话 4006-371-806
#define SERVICENUM @"15537326767"

#endif /* Config_h */
