//
//  UIImageView+ProcessWebCache.m
//  CarRepairFactory
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImageView+ProcessWebCache.h"

@implementation UIImageView (ProcessWebCache)

- (void)setImageWithImageUrl:(NSString *)imageUrl perchImage:(NSString *)perchImage {
    if (imageUrl.length > 3) {
        NSString *http = [imageUrl substringToIndex:4];
        imageUrl = [http isEqualToString:@"http"] ? imageUrl : [API stringByAppendingString:imageUrl];
    }
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:perchImage]];
}

@end
