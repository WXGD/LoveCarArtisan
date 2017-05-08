//
//  CALayer+XibConfiguration.m
//  TradePlatform
//
//  Created by 祝豪杰 on 17/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)
- (void)setBorderUIColor:(UIColor *)color

{

  self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor

{

  return [UIColor colorWithCGColor:self.borderColor];
}
@end
