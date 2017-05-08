//
//  JHPieItemsView.h
//  JHCALayer
//
//  Created by cjatech-简豪 on 16/4/28.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHPieItemsView : UIView

/**
 *  Each initialization method of pie chart
 *  @paramet frame:frame
 *  @paramet beginAngle:Starting angle of cake block
 *  @paramet endAngle：End angle of cake block
 *  @paramet fillColor：Fill color for this cake block
 */
- (JHPieItemsView *)initWithFrame:(CGRect)frame
                    andBeginAngle:(CGFloat)beginAngle
                      andEndAngle:(CGFloat)endAngle
                     andFillColor:(UIColor *)fillColor;
@end
