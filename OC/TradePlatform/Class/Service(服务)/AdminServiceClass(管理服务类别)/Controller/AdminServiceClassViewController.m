//
//  AdminServiceClassViewController.m
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AdminServiceClassViewController.h"
// view
#import "AdminServiceClassView.h"
// 网络请求
#import "AdminServiceClassNetwork.h"

@interface AdminServiceClassViewController ()<HaveChosenDelegate, NotChosenDelegate>

/** 管理服务类别View */
@property (strong, nonatomic) AdminServiceClassView *adminServiceClassView;

@end

@implementation AdminServiceClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self adminServiceClassLayoutNAV];
    // 布局视图
    [self adminServiceClassLayoutView];
}


#pragma mark - 删除管理服务类别
- (void)delAdminDelegate:(UIButton *)button {
    /** 未添加服务类别数据 */
    ServiceProviderModel *serviceClass = [self.haveChosenArray objectAtIndex:button.tag];
    [self.haveChosenArray removeObject:serviceClass];
    self.adminServiceClassView.haveChosenArray = self.haveChosenArray;
    /** 已添加服务类别数据 */
    [self.notChosenArray addObject:serviceClass];
    self.adminServiceClassView.notChosenArray = self.notChosenArray;
}

#pragma mark - 修改服务项目排序
- (void)editAdminSort:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    ServiceProviderModel *serviceClass = [self.haveChosenArray objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.haveChosenArray removeObject:serviceClass];
    //将数据插入到资源数组中的目标位置上
    [self.haveChosenArray insertObject:serviceClass atIndex:destinationIndexPath.item];
    // 刷新
    self.adminServiceClassView.haveChosenArray = self.haveChosenArray;
}



#pragma mark - 添加管理服务类别
- (void)addAdminDelegate:(NSInteger)cellItem {
    /** 未添加服务类别数据 */
    ServiceProviderModel *serviceClass = [self.notChosenArray objectAtIndex:cellItem];
    [self.notChosenArray removeObject:serviceClass];
    self.adminServiceClassView.notChosenArray = [NSMutableArray arrayWithArray:self.notChosenArray];
    /** 已添加服务类别数据 */
    [self.haveChosenArray addObject:serviceClass];
    self.adminServiceClassView.haveChosenArray = [NSMutableArray arrayWithArray:self.haveChosenArray];
}
// nav取消
- (void)adminServiceClassNavBarLeftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
// nav保存
- (void)adminServiceClassNavBarRightBtnAction {
    // 便利可用服务，拼接可用服务ID
    NSString *serviceListID = [[NSString alloc] init];
    for (int i = 0; i < self.haveChosenArray.count; i++) {
        ServiceProviderModel *serviceClass = [self.haveChosenArray objectAtIndex:i];
        if (serviceListID.length == 0) {
            serviceListID = [NSString stringWithFormat:@"%ld_%d", (long)serviceClass.goods_category_id, i];
        }else {
            serviceListID = [NSString stringWithFormat:@"%@,%ld_%d", serviceListID, (long)serviceClass.goods_category_id, i];
        }
    }
    /*/index.php?c=subbranch_goods_category&a=manage&v=1
     provider_id 	int 	是 	服务商id
     data 	string 	是 	服务类别数据，格式： 服务类别id_类别排序，多个用逗号分割    */
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    params[@"data"] = serviceListID; // 服务类别数据
    [AdminServiceClassNetwork editServiceClass:params success:^{
        if (_delegate && [_delegate respondsToSelector:@selector(confirmReviseDelegate:notChosenArray:)]) {
            [_delegate confirmReviseDelegate:self.haveChosenArray notChosenArray:self.notChosenArray];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 布局nav
- (void)adminServiceClassLayoutNAV {
    self.navigationItem.title = @"管理服务类别";
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(adminServiceClassNavBarLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(adminServiceClassNavBarRightBtnAction)];
}

#pragma mark - 布局视图
- (void)adminServiceClassLayoutView {
    /** 管理服务类别View */
    self.adminServiceClassView = [[AdminServiceClassView alloc] init];
    self.adminServiceClassView.haveChosenView.delegate = self;
    self.adminServiceClassView.notChosenView.delegate = self;
    /** 已添加服务类别数据 */
    self.adminServiceClassView.haveChosenArray = self.haveChosenArray;
    /** 未添加服务类别数据 */
    self.adminServiceClassView.notChosenArray = self.notChosenArray;
    [self.view addSubview:self.adminServiceClassView];
    [self.adminServiceClassView mas_makeConstraints:^(MASConstraintMaker *make) {
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
