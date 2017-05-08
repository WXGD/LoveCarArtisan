//
//  AddCommodityViewController.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCommodityViewController.h"
// view
#import "AddCommodityView.h"
#import "AlertListAction.h"
#import "CashierServiceChoiceView.h"
// 网络请求
#import "AddCommodityNetwork.h"
// 单利
#import "ServiceCategoryHandle.h"

@interface AddCommodityViewController ()<CashierServiceChoiceDelegate>

/** 新增商品view */
@property (strong, nonatomic) AddCommodityView *addCommodityView;
/** 默认选择商品类型 */
@property (strong, nonatomic) ServiceProviderModel *defaultServiceClass;
/** 商品类型列表数据 */
@property (strong, nonatomic) NSMutableArray *serviceClassListArray;
/** 商品类型弹框 */
@property (strong, nonatomic) AlertListAction *serviceClassBoxView;

@end

@implementation AddCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self addServiceLayoutView];
    // 布局nav
    [self addServiceLayoutNAV];
    // 网络请求
    [self addServiceRepustData];
}
#pragma mark - 网络请求
- (void)addServiceRepustData {
    // 保存商品类型列表数据
    self.serviceClassListArray = [ServiceCategoryHandle sharedInstance].serviceCategoryArray;
    // 获取默认选中的商品
    self.defaultServiceClass = [self.serviceClassListArray firstObject];
    // 界面赋值
    [self addServiceAssignment];
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (self.serviceClassListArray.count == 0) {
        [ServiceCategoryHandle sharedInstance].requestCategorySuccessBlock = ^ () {
            // 保存商品类型列表数据
            self.serviceClassListArray = [ServiceCategoryHandle sharedInstance].serviceCategoryArray;
            // 获取默认选中的商品
            self.defaultServiceClass = [self.serviceClassListArray firstObject];
            // 界面赋值
            [self addServiceAssignment];
        };
    }
    
//    /*/index.php?c=goods_category&a=list&v=1
//     provider_id 	int 	是 	服务商id
//     start 	int 	否 	记录开始位置,默认为0
//     pageSize 	int 	否 	每页显示条数，默认为0 (代表全部)     */
//    // 网络请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商编号
//    [ServiceProviderModel requesServiceListDataParams:params success:^(NSMutableArray *serviceList) {
//        // 保存商品类型列表数据
//        self.serviceClassListArray = serviceList;
//        // 获取默认选中的商品
//        self.defaultServiceClass = [serviceList firstObject];
//        // 界面赋值
//        [self addServiceAssignment];
//    }];
}
#pragma mark - 按钮点击方法
//  账户页面按钮点击方法
- (void)addServiceBtnAction:(UIButton *)button {
    switch (button.tag) {
            /** 商品类别 */
        case CommodityCategoriesBottonAction: {
            // 遍历所有服务，找到当前选中的服务
            for (ServiceProviderModel *service in self.serviceClassListArray) {
                service.checkMark = NO;
                if (service.goods_category_id == self.defaultServiceClass.goods_category_id) {
                    service.checkMark = YES;
                }
            }
            // 弹出
            CashierServiceChoiceView *classChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            classChoiceBoxView.choiceArray = self.serviceClassListArray;
            classChoiceBoxView.serviceChoice = ServiceTypeChoiceBtnAction;
            classChoiceBoxView.delegate = self;
            [classChoiceBoxView show];
            break;
        }
        default:
            break;
    }
}
// nav右边按钮点击
- (void)addServiceRightBarButtonItmeAction {
    // 判断是否有原价，如果没有默认在销售价上加5
    if (!self.addCommodityView.commodityOriginalPrice.viceTextFiled.text || self.addCommodityView.commodityOriginalPrice.viceTextFiled.text.length == 0) {
        //                self.addCommodityView.commodityOriginalPrice.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", [self.addCommodityView.commodityPresentPrice.viceTextFiled.text floatValue] + 5.0];
        self.addCommodityView.commodityOriginalPrice.viceTextFiled.text = self.addCommodityView.commodityPresentPrice.viceTextFiled.text;
    }
    // 判断原价是否小于销售价
    if ([self.addCommodityView.commodityOriginalPrice.viceTextFiled.text floatValue] < [self.addCommodityView.commodityPresentPrice.viceTextFiled.text floatValue]) {
        [MBProgressHUD showError:@"原价不能小于售价"];
        return;
    }
    /*/index.php?c=goods&a=add&v=1
     provider_id 	int 	是 	商品商id
     goods_category_id 	int 	是 	商品类别id
     goods_name 	string 	是 	商品名称
     price 	string 	是 	原价
     sale_price 	string 	是 	售价
     staff_user_id 	int 	是 	登录者id(登录后返回的staff_user_id)   */
    // 网络请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provider_id"] = self.merchantInfo.provider_id; // 商品商编号
    params[@"goods_category_id"] = [NSString stringWithFormat:@"%ld", self.defaultServiceClass.goods_category_id]; // 商品项目编号
    params[@"goods_name"] = self.addCommodityView.commodityName.viceTextFiled.text; // 商品名称
    params[@"price"] = self.addCommodityView.commodityOriginalPrice.viceTextFiled.text; // 原价
    params[@"sale_price"] = self.addCommodityView.commodityPresentPrice.viceTextFiled.text; // 售价
    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id(登录后返回的user_id)
    [AddCommodityNetwork addCommodityParams:params success:^{
        if (_addCommoditySuccessBlock) {
            _addCommoditySuccessBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - 类型选择弹框点击
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    // 获取默认选中的商品类型
    self.defaultServiceClass = [choiceArray objectAtIndex:indexPath.row];
    // 界面赋值
    [self addServiceAssignment];
}

#pragma mark - 界面赋值
- (void)addServiceAssignment {
    /** 商品类别 */
    self.addCommodityView.commodityCategories.describeLabel.text = self.defaultServiceClass.name;
}
#pragma mark - 布局nav
- (void)addServiceLayoutNAV {
    self.navigationItem.title = @"添加服务";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(addServiceRightBarButtonItmeAction)];
    // 根据账户输入框，修改保存按钮是否可点击属性
    RAC(self.navigationItem.rightBarButtonItem, enabled) =
    [self.addCommodityView.aggregationInfo map:^id(NSNumber *aggregationInfoTF){
        return@([aggregationInfoTF boolValue]);
    }];
}
#pragma mark - 布局视图
- (void)addServiceLayoutView {
    /** 新增商品view */
    self.addCommodityView = [[AddCommodityView alloc] init];
    /** 商品类别 */
    [self.addCommodityView.commodityCategories.usedCellBtn addTarget:self action:@selector(addServiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addCommodityView];
    @weakify(self)
    [self.addCommodityView mas_makeConstraints:^(MASConstraintMaker *make) {
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
