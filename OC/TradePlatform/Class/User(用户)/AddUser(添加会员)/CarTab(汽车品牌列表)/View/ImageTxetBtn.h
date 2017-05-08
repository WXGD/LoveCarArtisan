//
//  ImageTxetBtn.h
//  CarTab
//
//  Created by 弓杰 on 16/2/22.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BrandModel.h"
#import "CarBrandModel.h"

@interface ImageTxetBtn : UIButton

- (void)setImageTxetBackgroundImage:(UIImage *)image title:(NSString *)title forState:(UIControlState)state;

@property (strong, nonatomic) CarBrandModel *brand;

@end
