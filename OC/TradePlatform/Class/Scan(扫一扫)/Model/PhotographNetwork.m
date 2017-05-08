//
//  PhotographNetwork.m
//  TradePlatform
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PhotographNetwork.h"

@implementation PhotographNetwork

+ (void)photographModifyImage:(UIImage *)modifyImage success:(void(^)(NSMutableDictionary *responseObject))success {
   
    NSString *URL = @"http://v.juhe.cn/certificates/query.php?key=a932cfbb0bc6bae2c415102e23ba0df4";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"cardType"] = @"19";
    [TPNetRequest tokenPOST:URL parameters:parameters ProgressHUD:@"正在识别图片..." falseDate:nil parentController:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        NSData *data = UIImageJPEGRepresentation(modifyImage, 0.2);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"f.jpg" mimeType:@"image/jpeg"];
    } success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);

        if ([[NSString stringWithFormat:@"%@", responseObject[@"error_code"]] isEqualToString:@"0"]) {
            if (success) {
                success(responseObject);
            }
        }else {
            [MBProgressHUD showError:@"识别失败，请重新拍照"];
        }
    } failure:^(NSError *error) {
        PDLog(@"sigln%@", error);
        [MBProgressHUD showError:@"请求失败"];
    }];
    
}


@end
