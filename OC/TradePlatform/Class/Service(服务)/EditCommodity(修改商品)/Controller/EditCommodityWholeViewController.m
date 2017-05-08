//
//  EditCommodityWholeViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCommodityWholeViewController.h"
// view
#import "EditCommodityWholeView.h"
// 网络请求
#import "EditCommodityNetwork.h"

@interface EditCommodityWholeViewController ()

/** 修改商品全部信息view */
@property (strong, nonatomic) EditCommodityWholeView *editCommodityWholeView;

@end

@implementation EditCommodityWholeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self editCommodityWholeLayoutView];
    // 布局nav
    [self editCommodityWholeLayoutNAV];
    // 界面赋值
    [self editCommodityWholeAssignment];
}

#pragma mark - 按钮点击方法
// nav右边按钮点击
- (void)editCommodityWholeRightBarButtonItmeAction {
    // 判断是否有原价，如果没有默认在等于销售价
    if (!self.editCommodityWholeView.editCommodityOriginalPrice.viceTextFiled.text || self.editCommodityWholeView.editCommodityOriginalPrice.viceTextFiled.text.length == 0) {
        self.editCommodityWholeView.editCommodityOriginalPrice.viceTextFiled.text = self.editCommodityWholeView.editCommodityPresentPrice.viceTextFiled.text;
    }
    // 判断原价是否小于销售价
    if ([self.editCommodityWholeView.editCommodityOriginalPrice.viceTextFiled.text doubleValue] < [self.editCommodityWholeView.editCommodityPresentPrice.viceTextFiled.text doubleValue]) {
        [MBProgressHUD showError:@"原价不能小于售价"];
        return;
    }
    // 判断是输入框内容和原内容是否一致
    if ([self.editCommodityWholeView.editCommodityName.viceTextFiled.text isEqualToString:self.commodityShowModel.name] && [self.editCommodityWholeView.editCommodityOriginalPrice.viceTextFiled.text doubleValue] == self.commodityShowModel.price && [self.editCommodityWholeView.editCommodityPresentPrice.viceTextFiled.text doubleValue] == self.commodityShowModel.sale_price) {
        [MBProgressHUD showError:@"没有任何修改"];
        return;
    }
    // 判断是姓名输入框内容是否为空
    if (self.editCommodityWholeView.editCommodityName.viceTextFiled.text.length == 0) {
        [MBProgressHUD showError:@"商品名称不能为空"];
        return;
    }
    // 判断是销售价输入框内容是否为空
    if (self.editCommodityWholeView.editCommodityPresentPrice.viceTextFiled.text.length == 0) {
        [MBProgressHUD showError:@"商品售价不能为空"];
        return;
    }
    /*/index.php?c=goods&a=edit&v=1
     goods_id 	int 	是 	商品id
     price 	string 	是 	原价
     sale_price 	string 	是 	售价
     goods_name 	string 	是 	商品名称
     staff_user_id string 	是 	登陆者ID */
    // 网络请求参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"goods_id"] = [NSString stringWithFormat:@"%ld", self.commodityShowModel.goods_id]; // 商品id
    params[@"price"] = self.editCommodityWholeView.editCommodityOriginalPrice.viceTextFiled.text; // 原价
    params[@"sale_price"] = self.editCommodityWholeView.editCommodityPresentPrice.viceTextFiled.text; // 售价
    params[@"goods_name"] = self.editCommodityWholeView.editCommodityName.viceTextFiled.text; // 商品名称
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者ID
    [EditCommodityNetwork editCommodity:params success:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}




#pragma mark - 界面赋值
- (void)editCommodityWholeAssignment {
    /** 商品名称 */
   self.editCommodityWholeView.editCommodityName.viceTextFiled.text = self.commodityShowModel.name;
    /** 商品原价 */
    self.editCommodityWholeView.editCommodityOriginalPrice.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.price];
    /** 商品销售价 */
    self.editCommodityWholeView.editCommodityPresentPrice.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.sale_price];
}
#pragma mark - 布局nav
- (void)editCommodityWholeLayoutNAV {
    self.navigationItem.title = @"编辑服务";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(editCommodityWholeRightBarButtonItmeAction)];
//    // 根据账户输入框，修改保存按钮是否可点击属性
//    RAC(self.navigationItem.rightBarButtonItem, enabled) =
//    [self.editCommodityWholeView.editAggregationInfo map:^id(NSNumber *aggregationInfoTF){
//        return@([aggregationInfoTF boolValue]);
//    }];
}
#pragma mark - 布局视图
- (void)editCommodityWholeLayoutView {
    /** 新增商品view */
    self.editCommodityWholeView = [[EditCommodityWholeView alloc] init];
    [self.view addSubview:self.editCommodityWholeView];
    @weakify(self)
    [self.editCommodityWholeView mas_makeConstraints:^(MASConstraintMaker *make) {
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
