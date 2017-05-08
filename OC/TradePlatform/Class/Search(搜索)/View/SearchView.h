//
//  SearchView.h
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

// 自定义cell样式类型
typedef NS_ENUM(NSInteger, SearchViewTypeChoice) {
    /** nav上使用的尺寸 */
    NavigationLayout,
    /** 普通view尺寸 */
    OrdinaryViewLayout,
};


#import <UIKit/UIKit.h>

@interface SearchView : UIView

/** 搜索view */
@property (strong, nonatomic) UIView *searchView;
/** 搜索放大镜 */
@property (strong, nonatomic) UIImageView *searchMagnifierImage;
/** 搜索按钮 */
@property (strong, nonatomic) UIButton *searchBtn;
/** 搜索输入框 */
@property (strong, nonatomic) UITextField *searchTF;
/** 覆盖整个控件的按钮 */
@property (strong, nonatomic) UIButton *viewBtn;
/** 有没有搜索按钮 */
@property (assign, nonatomic) BOOL isSearch;
/** 有没有覆盖搜索框的按钮 */
@property (assign, nonatomic) BOOL isViewBtn;
/** 输入框长度铺满屏幕宽 */
@property (assign, nonatomic) BOOL isSearchWidth;
/** 输入框样式 */
@property (assign, nonatomic) SearchViewTypeChoice searchType;



@end
