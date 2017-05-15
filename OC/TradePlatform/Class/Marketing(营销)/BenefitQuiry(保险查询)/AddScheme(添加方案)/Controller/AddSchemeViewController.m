//
//  AddSchemeViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddSchemeViewController.h"
// view
#import "AddSchemeView.h"
#import "SmallPrintView.h"
// 下级控制器
#import "SchemeListViewController.h"


@interface AddSchemeViewController ()<AddSchemeDelegate, SmallPrintDelegate>

/** 添加方案view */
@property (strong, nonatomic) AddSchemeView *addSchemeView;
/** 保额选择 */
@property (strong, nonatomic) SmallPrintView *smallPrintView;
/** 保存险种数据 */
@property (strong, nonatomic) SafeTypeModel *safeTypeModel;
/** 保存方案列表 */
@property (strong, nonatomic) NSMutableArray *schemeArray;


@end

@implementation AddSchemeViewController


#pragma mark - 懒加载
- (NSMutableArray *)schemeArray {
    if (!_schemeArray) {
        _schemeArray = [[NSMutableArray alloc] init];
    }
    return _schemeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self addSchemeLayoutNAV];
    // 布局视图
    [self addSchemeLayoutView];
    // 请求保险种类列表
    [self requestSafeTypeList];
}
#pragma mark - 网络请求
// 请求保险种类列表
- (void)requestSafeTypeList {
    [SafeTypeModel requestSafeTypeSuccess:^(SafeTypeModel *safeTypeModel) {
        /** 保存险种数据 */
        self.safeTypeModel = safeTypeModel;
        // 获取商业保险数据
        self.addSchemeView.safeTypeModel = safeTypeModel;
    }];
}

#pragma mark - 按钮点击方法
// nav左边按钮
- (void)addSchemeleftBarBtnAction {
    // 判断方案列表中是否有数据
    if (self.schemeArray.count != 0) {
        [AlertAction determineStayLeft:self title:@"提示" message:@"还有未提交的保险方案，确认退出吗？" determineBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark - 选择保险类别按钮点击
- (void)addSchemeDidSelect:(BenefitModel *)benefitModel indexPath:(NSIndexPath *)indexPath cell:(AddSchemeCell *)cell {
    // 创建保额选择view
    self.smallPrintView = [[SmallPrintView alloc] init];
    // 判断有没有保额选择，如果没有，添加投保选择
    if (benefitModel.coverage.count == 0) {
        // 添加不投保
        [benefitModel.coverage insertObject:@"不投保" atIndex:0];
        // 添加投保
        [benefitModel.coverage insertObject:@"投保" atIndex:0];
    }
    // 判断是否有"不投保"，如果没有，添加@"不投保"
    if (![benefitModel.coverage containsObject:@"不投保"]) {
        // 添加不投保
        [benefitModel.coverage insertObject:@"不投保" atIndex:0];
    }
    /** 保险模型 */
    self.smallPrintView.benefitModel = benefitModel;
    // 遵守代理
    self.smallPrintView.delegate = self;
    [self.smallPrintView show];
}
// 确认添加btn
- (void)confirmAddBtnAction:(UIButton *)button {
    // 拼接选中险种名称，返回险种名称
    NSString *schemeName = [self spliceSelectionSafeTypeName:self.safeTypeModel];
    // 判断险种名称是否为空
    if (schemeName.length == 0) {
        [MBProgressHUD showError:@"请选择购买险种"];
        return;
    }
    // 遍历方案数组，判断是否有相同方案
    for (SafeTypeModel *safeTypeModel in self.schemeArray) {
        if ([safeTypeModel.scheme_name isEqualToString:schemeName]) {
            // 跳转到方案列表页面
            SchemeListViewController *schemeListVC = [[SchemeListViewController alloc] init];
            /** 车辆信息模型 */
            schemeListVC.carModel = self.carModel;
            /** 保存方案列表 */
            schemeListVC.schemeArray = self.schemeArray;
            /** 添加方案 */
            schemeListVC.addSchemeBlock = ^{
                // 请求保险种类列表
                [self requestSafeTypeList];
            };
            /** 编辑方案 */
            schemeListVC.editSchemeBlock = ^(SafeTypeModel *safeTypeModel) {
                /** 保存险种数据 */
                self.safeTypeModel = safeTypeModel;
                // 获取商业保险数据
                self.addSchemeView.safeTypeModel = safeTypeModel;
            };
            [self.navigationController pushViewController:schemeListVC animated:YES];
            return;
        }
    }
    // 添加方案
    [self.schemeArray addObject:self.safeTypeModel];
    // 跳转到方案列表页面
    SchemeListViewController *schemeListVC = [[SchemeListViewController alloc] init];
    /** 车辆信息模型 */
    schemeListVC.carModel = self.carModel;
    /** 保存方案列表 */
    schemeListVC.schemeArray = self.schemeArray;
    /** 添加方案 */
    schemeListVC.addSchemeBlock = ^{
        // 请求保险种类列表
        [self requestSafeTypeList];
    };
    /** 编辑方案 */
    schemeListVC.editSchemeBlock = ^(SafeTypeModel *safeTypeModel) {
        /** 保存险种数据 */
        self.safeTypeModel = safeTypeModel;
        // 获取商业保险数据
        self.addSchemeView.safeTypeModel = safeTypeModel;
    };
    [self.navigationController pushViewController:schemeListVC animated:YES];
}

#pragma mark - 保额选择代理
- (void)smallPrintDidSelectIsCover:(NSInteger)isCover coverage:(double)coverage {
    [self.addSchemeView.tradeBenefitTable reloadData];
}
/** 取消 */
- (void)cancelBtnDelegate:(UIButton *)button {
    [self.smallPrintView dismiss];
    [self.addSchemeView.tradeBenefitTable reloadData];
}
/** 确定 */
- (void)confirmBtnDelegate:(UIButton *)button {
    [self.smallPrintView dismiss];
    [self.addSchemeView.tradeBenefitTable reloadData];
}



#pragma mark - 界面赋值
- (void)addSchemeAssignment {
    
    
}


#pragma mark - 布局nav
- (void)addSchemeLayoutNAV {
    self.navigationItem.title = @"添加方案";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSchemeRightBarBtnAction)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(addSchemeleftBarBtnAction)];

}

#pragma mark - 布局视图
- (void)addSchemeLayoutView {
    /** 添加方案view */
    self.addSchemeView = [[AddSchemeView alloc] init];
    /** 确认添加btn */
    [self.addSchemeView.confirmAddBtn addTarget:self action:@selector(confirmAddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.addSchemeView.delegate = self;
    [self.view addSubview:self.addSchemeView];
    @weakify(self)
    [self.addSchemeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - 封装方法
// 拼接选中险种名称，返回方案名称
- (NSString *)spliceSelectionSafeTypeName:(SafeTypeModel *)safeTypeModel {
    // 初始化一个字符串，用来拼接保险方案名称
    NSString *schemeName = [[NSString alloc] init];
    // 初始化一个字符串，用来拼接保险方案ID
    NSString *schemeID = [[NSString alloc] init];
    // 保存方案名称(带属性)
    NSMutableArray *mAttStriArray = [[NSMutableArray alloc] init];
    /** 保存险种数据 */
    NSArray *unscientificArray = safeTypeModel.jqx;
    // 遍历交强险
    for (BenefitModel *benefitModel in unscientificArray) {
        // 判断是否选中
        if (benefitModel.is_cover == 1) {
            // 判断保险方案名称字符串是否有值
            if (schemeName.length == 0) {
                // 拼接方案名称
                schemeName = [NSString stringWithFormat:@"%@", benefitModel.name];
                // 拼接方案ID
                schemeID = [NSString stringWithFormat:@"%ld_0_%0.2f", (long)benefitModel.insurance_category_id, benefitModel.coverageDouble];
            }else {
                // 拼接方案名称
                schemeName = [NSString stringWithFormat:@"%@/%@", schemeName, benefitModel.name];
                // 拼接方案ID
                schemeID = [NSString stringWithFormat:@"%@,%ld_0_%0.2f", schemeID, (long)benefitModel.insurance_category_id, benefitModel.coverageDouble];
            }
        }
    }
    // 遍历商业保险模型拼接商品保险方案
    for (BenefitModel *benefitModel in safeTypeModel.syx) {
        // 判断是否投保
        if (benefitModel.is_cover == 0) { // 没有投保
            
        }else if (benefitModel.is_cover == 1) {  // 投保
            // 判断是否有保额，拼接方案名称
            if (benefitModel.is_coverage == 0) { // 没有保额
                if (schemeName.length == 0) {
                    schemeName = [NSString stringWithFormat:@"%@", benefitModel.name];
                }else {
                    schemeName = [NSString stringWithFormat:@"%@/%@", schemeName, benefitModel.name];
                }
            }else if (benefitModel.is_coverage == 1) { // 有保额
                if (schemeName.length == 0) {
                    schemeName = [NSString stringWithFormat:@"%@(%0.2f万)", benefitModel.name, benefitModel.coverageDouble];
                    // 保存保额
                    [mAttStriArray addObject:[NSString stringWithFormat:@"%.2f万", benefitModel.coverageDouble]];
                }else {
                    schemeName = [NSString stringWithFormat:@"%@/%@(%0.2f万)", schemeName, benefitModel.name, benefitModel.
                                  coverageDouble];
                    // 保存保额
                    [mAttStriArray addObject:[NSString stringWithFormat:@"%.2f万", benefitModel.coverageDouble]];
                }
            }
            // 拼接方案ID
            if (schemeID.length == 0) {
                schemeID = [NSString stringWithFormat:@"%ld_0_%0.2f", (long)benefitModel.insurance_category_id, benefitModel.coverageDouble];
            }else {
                schemeID = [NSString stringWithFormat:@"%@,%ld_0_%0.2f", schemeID, (long)benefitModel.insurance_category_id, benefitModel.coverageDouble];
            }
        }else if (benefitModel.is_cover == 2) {  // 投保，加不计免赔
            // 判断是否有保额，拼接方案名称
            if (benefitModel.is_coverage == 0) { // 没有保额
                if (schemeName.length == 0) {
                    schemeName = [NSString stringWithFormat:@"%@", benefitModel.name];
                }else {
                    schemeName = [NSString stringWithFormat:@"%@/%@(不计免赔)", schemeName, benefitModel.name];
                }
            }else if (benefitModel.is_coverage == 1) { // 有保额
                if (schemeName.length == 0) {
                    schemeName = [NSString stringWithFormat:@"%@(%0.2f万)", benefitModel.name, benefitModel.coverageDouble];
                    // 保存保额
                    [mAttStriArray addObject:[NSString stringWithFormat:@"%.2f万", benefitModel.coverageDouble]];
                }else {
                    schemeName = [NSString stringWithFormat:@"%@/%@(%0.2f万)(不计免赔)", schemeName, benefitModel.name, benefitModel.coverageDouble];
                    // 保存保额
                    [mAttStriArray addObject:[NSString stringWithFormat:@"%.2f万", benefitModel.coverageDouble]];
                }
            }
            // 拼接方案ID
            if (schemeID.length == 0) {
                schemeID = [NSString stringWithFormat:@"%ld_1_%0.2f", (long)benefitModel.insurance_category_id, benefitModel.coverageDouble];
            }else {
                schemeID = [NSString stringWithFormat:@"%@,%ld_1_%0.2f", schemeID, (long)benefitModel.insurance_category_id, benefitModel.coverageDouble];
            }
        }
    }
    // 生成属性字符串
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:schemeName];
    // 遍历保额
    for (NSString *coverage in mAttStriArray) {
        // 创建对象.
        NSRange range = [schemeName rangeOfString:coverage];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    }
    // 保存方案名称(带属性)
    safeTypeModel.scheme_name_attri = mAttStri;
    // 保存方案名称
    safeTypeModel.scheme_name = schemeName;
    // 保存方案ID
    safeTypeModel.scheme_id = schemeID;
    return schemeName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
