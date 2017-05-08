//
//  CardApplyViewController.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardApplyViewController.h"
#import "CardInfoChangeNetwork.h"

@interface CardApplyViewController () <CardApplyDelegate>

/** 当前服务 */
@property (strong, nonatomic) ServiceProviderModel *serviceType;
/** 适用范围ID */
@property (copy, nonatomic) NSString *applyID;

@end

@implementation CardApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self cardApplyLayoutNAV];
    // 布局视图
    [self cardApplyLayoutView];
    // 网络请求
    [self requestCardApply];
}
#pragma mark - 网络请求
- (void)requestCardApply {
    if (self.wholeCommodityArray) {
        // 判断之前是否保存的有选中商品
        if (self.chooseCommodityArray) {
            self.cardApplyView.chooseCommodityArray = self.chooseCommodityArray;
        }
        if (self.chooseServiceArray) {
            self.cardApplyView.chooseServiceArray = self.chooseServiceArray;
        }
        // 获取服务类型
        self.cardApplyView.serviceArray = self.wholeCommodityArray;
        // 获取当前服务
        self.serviceType = [self.cardApplyView.serviceArray firstObject];
        [self.cardApplyView.serviceTable reloadData];
        // 默认选中
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.cardApplyView.serviceTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
        // 请求服务商品
        [self servicedidSelectIndexPath:indexPath];
    }else {
        // 请求商品类型
        /*/index.php?c=goods_category&a=detail&v=1
         provider_id 	int 	是 	服务商id      */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        [ServiceProviderModel requestServiceCommodityParams:params success:^(NSMutableArray *serviceCommodityArray) {
            // 获取服务类型
            self.cardApplyView.serviceArray = serviceCommodityArray;
            // 获取当前服务
            self.serviceType = [self.cardApplyView.serviceArray firstObject];
            [self.cardApplyView.serviceTable reloadData];
            if (serviceCommodityArray.count > 0) {
                // 默认选中
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.cardApplyView.serviceTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
                // 请求服务商品
                [self servicedidSelectIndexPath:indexPath];
            }else {
                [MBProgressHUD showError:@"请先添加服务商品"];
            }
        }];
    }
}
#pragma mark - 按钮点击方法
- (void)cardApplyBtnAction:(UIButton *)button {
}
// nav右边按钮
- (void)cardApplyNavBarLeftBtnAction {
    // 判断是哪个界面使用的卡适用范围界面
    switch (self.cardApplyUseType) {
            /** 新增卡使用 */
        case AddCardUseType:{
            if (_confirmApply) {
                _confirmApply(self.cardApplyView.serviceArray, self.cardApplyView.chooseCommodityArray, self.cardApplyView.chooseServiceArray);
            }
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
            /** 修改卡信息使用 */
        case ChangeCardInfoUseType:{
            // 保存选中的商品，保存选中的服务为空时
            if (self.cardApplyView.chooseCommodityArray.count == 0 && self.cardApplyView.chooseServiceArray.count == 0) {
                self.applyID = @"";
            }else {
                // 初始化两个字符串
                NSString *apply = [[NSString alloc] init];
                self.applyID = [[NSString alloc] init];
                for (ServiceProviderModel *service  in self.cardApplyView.chooseServiceArray) {
                    apply = [apply stringByAppendingFormat:@"%@,", service.name];
                    self.applyID = [self.applyID stringByAppendingFormat:@"goods_category_id=%ld,", (long)service.goods_category_id];
                }
                for (CommodityShowStyleModel *commodity in self.cardApplyView.chooseCommodityArray) {
                    apply = [apply stringByAppendingFormat:@"%@,", commodity.name];
                    self.applyID = [self.applyID stringByAppendingFormat:@"goods_id=%ld,", (long)commodity.goods_id];
                }
                apply = [apply substringToIndex:[apply length]-1];
                self.applyID = [self.applyID substringToIndex:[self.applyID length]-1];
            }
            /*/index.php?c=provider_card&a=edit&v=1
             provider_card_id 	int 	是 	服务商卡id
             data 	string 	否 	编辑除了可适用的服务以外的数据必传（格式: 数据库字段名=值，字段名参考备注）
             rules 	string 	否 	编辑适用的服务必传, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)  */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardInfoModel.provider_card_id]; // 商品id
            params[@"rules"] = self.applyID; // 原价
            [CardInfoChangeNetwork cardInfoChange:params success:^{
                if (_confirmApply) {
                    _confirmApply(self.cardApplyView.serviceArray, self.cardApplyView.chooseCommodityArray, self.cardApplyView.chooseServiceArray);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 自定义开卡，修改卡信息使用 */
        case CustomOpenCardChangeCardInfoUseType:{
            if (_confirmApply) {
                _confirmApply(self.cardApplyView.serviceArray, self.cardApplyView.chooseCommodityArray, self.cardApplyView.chooseServiceArray);
            }
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 卡适用范围点击代理
// 选择服务项目
- (void)servicedidSelectIndexPath:(NSIndexPath *)indexPath {
    ServiceProviderModel *serviceType = [self.cardApplyView.serviceArray objectAtIndex:indexPath.row];
    self.cardApplyView.commodityScrvieStr = serviceType;
    // 获取当前服务
    self.serviceType = [self.cardApplyView.serviceArray objectAtIndex:indexPath.row];
    // 获取商品数据
    self.cardApplyView.commodityArray = self.serviceType.goods;
    [self.cardApplyView.commodityTable reloadData];
}

#pragma mark - 界面赋值
- (void)cardApplyAssignment {
    
}
#pragma mark - 布局nav
- (void)cardApplyLayoutNAV {
    self.navigationItem.title = @"可用服务";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(cardApplyNavBarLeftBtnAction)];
}
#pragma mark - 布局视图
- (void)cardApplyLayoutView {
    @weakify(self)
    /** 会员卡适用范围View */
    self.cardApplyView = [[CardApplyView alloc] init];
    self.cardApplyView.delegate = self;
    [self.view addSubview:self.cardApplyView];
    [self.cardApplyView mas_makeConstraints:^(MASConstraintMaker *make) {
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
