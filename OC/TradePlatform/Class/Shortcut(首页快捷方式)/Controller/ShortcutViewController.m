//
//  ShortcutViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShortcutViewController.h"
#import "ShortcutView.h"
// 下级控制器
#import "CustomOpenCardViewController.h"
#import "AddCommodityViewController.h"
#import "AddUserViewController.h"

@interface ShortcutViewController ()

/** 首页快捷方式view */
@property (strong, nonatomic) ShortcutView *shortcutView;

@end

@implementation ShortcutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self shortcutLayoutNAV];
    // 布局视图
    [self shortcutLayoutView];
    // 网络请求
    [self shortcutRepuestData];
}
#pragma mark - 网络请求
- (void)shortcutRepuestData {
    
}
#pragma mark - 按钮点击方法
// nav右边按钮
- (void)shortcutRightBarBtnAction {
    
    
}
// nav右边按钮
- (void)shortcutLeftBtnAction {
    
}
- (void)shortcutBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 新增服务 */
        case SpeedAddScrviewBtnAction: {
            AddCommodityViewController *addCommodityVC = [[AddCommodityViewController alloc] init];
            [_shortcutNav pushViewController:addCommodityVC animated:YES];
            break;
        }
            /** 新增客户 */
        case SpeedAddUserBtnAction: {
            AddUserViewController *addUserVC = [[AddUserViewController alloc] init];
            [_shortcutNav pushViewController:addUserVC animated:YES];
            break;
        }
            /** 开卡 */
        case SpeedOpenCardBtnAction: {
            CustomOpenCardViewController *customOpenCardVC = [[CustomOpenCardViewController alloc] init];
            [_shortcutNav pushViewController:customOpenCardVC animated:YES];
            break;
        }
        default:
            break;
    }
    if (_ShortcutBtnActionBlock) {
        _ShortcutBtnActionBlock();
    }
}

#pragma mark - 界面赋值
- (void)shortcutAssignment {
    
}
#pragma mark - 布局nav
- (void)shortcutLayoutNAV {
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(shortcutLeftBtnAction)];
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(shortcutRightBarBtnAction)];
}
#pragma mark - 布局视图
- (void)shortcutLayoutView {
    /** 首页快捷方式view */
    self.shortcutView = [[ShortcutView alloc] init];
    /** 新增服务 */
    [self.shortcutView.speedAddScrview.usedCellBtn addTarget:self action:@selector(shortcutBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 新增客户 */
    [self.shortcutView.speedAddUser.usedCellBtn addTarget:self action:@selector(shortcutBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 开卡 */
    [self.shortcutView.speedOpenCard.usedCellBtn addTarget:self action:@selector(shortcutBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shortcutView];
    @weakify(self)
    [self.shortcutView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
