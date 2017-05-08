//
//  CommercialCityWebViewController.h
//  TradePlatform
//
//  Created by apple on 2017/4/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WebViewController.h"

@interface CommercialCityWebViewController : WebViewController

/** url */
@property (nonatomic, copy) NSString *webUrl;
/** 本地路径 */
@property (nonatomic, copy) NSString *localPath;

@end
