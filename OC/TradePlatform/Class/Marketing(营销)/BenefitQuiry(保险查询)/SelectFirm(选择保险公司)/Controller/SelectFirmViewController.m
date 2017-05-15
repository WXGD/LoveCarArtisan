//
//  SelectFirmViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SelectFirmViewController.h"
// view
#import "SelectFirmCell.h"
// 上级控制器
#import "BenefitQuiryViewController.h"
#import "InquiryRecordViewController.h"

@interface SelectFirmViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 确定view */
@property (strong, nonatomic) UIView *confirmView;
/** 确定btn */
@property (strong, nonatomic) UIButton *confirmBtn;
/** 保险公司列表table */
@property (strong, nonatomic) UITableView *firmListTable;
/** 保险公司列表array */
@property (strong, nonatomic) NSMutableArray *firmListArray;
/** 保存选择的保险公司 */
@property (strong, nonatomic) NSMutableArray *selFirmArray;

@end

@implementation SelectFirmViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self selectFirmLayoutNAV];
    // 布局视图
    [self selectFirmLayoutView];
    // 请求保险公司数据
    [self requestBenefitFirmData];
}
#pragma mark - 网络请求
// 请求保险公司数据
- (void)requestBenefitFirmData {
    [BenefitFirmModel requestBenefitFirmSuccess:^(NSMutableArray *benefitFirmArray) {
        self.firmListArray = benefitFirmArray;
        [self.firmListTable reloadData];
    }];
}

#pragma mark - 按钮点击方法
// nav右边按钮
- (void)selectFirmRightBarBtnAction {
    
}

// 确定按钮
- (void)confirmBtnAction:(UIButton *)button {
    // 初始化保险公司ID字符串，用来拼接保险公司ID
    NSString *benefitFirmID = [[NSString alloc] init];
    for (BenefitFirmModel *benefitFirmModel in self.selFirmArray) {
        if (benefitFirmID.length == 0) {
            benefitFirmID = [NSString stringWithFormat:@"%ld", (long)benefitFirmModel.insurance_company_id];
        }else {
            benefitFirmID = [NSString stringWithFormat:@"%@,%ld", benefitFirmID, (long)benefitFirmModel.insurance_company_id];
        }
    }
    PDLog(@"保险公司ID===%@", benefitFirmID);
    // 判断保险公司I是否为空
    if (benefitFirmID.length == 0) {
        [MBProgressHUD showError:@"请选择保险公司"];
        return;
    }
    PDLog(@"保险方案ID===%@", _safeSchemeID);
    /*/index.php?c=insurance_query&a=add&v=2
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     car_plate_no 	string 	是 	车牌号
     license_brand_model 	string 	是 	车牌型号
     engine_num 	string 	是 	发动机号
     vin 	string 	是 	车架号
     register_time 	string 	是 	注册日期
     license_img 	file 	否 	上传图片的名称
     name 	string 	是 	所有人名称
     insurances_data 	string 	是 	险种信息，数据格式： 方案序号_车险id_是否免赔_保额，多个用逗号分割 eg: 1_1_1_20,1_2_0_0
     companys_data 	string 	是 	保险公司信息，数据格式：公司id集合，(多个用逗号分割）    */
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    parame[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    parame[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
    parame[@"car_plate_no"] = self.carModel.car_plate_no; // 车牌号
    parame[@"license_brand_model"] = self.carModel.car_brand_name; // 车牌型号
    parame[@"engine_num"] = self.carModel.engine; // 发动机号
    parame[@"vin"] = self.carModel.vin; // 车架号
    parame[@"register_time"] = self.carModel.register_time; // 注册日期
    parame[@"name"] = self.carModel.hold_man; // 所有人名称
    parame[@"insurances_data"] = self.safeSchemeID; // 险种信息
    parame[@"companys_data"] = benefitFirmID; // 保险公司信息
    [BenefitFirmModel addBenefitInquiryParame:parame modifyImage:self.carModel.license_img success:^{
        [AlertAction determineStayLeft:self title:@"提示" admit:@"是" noadmit:@"否" message:@"提交成功，10分钟后出查询结果\n是否继续添加查询" admitBlock:^{
            // 返回到车险询价界面
            [CustomObject returnAppointController:[BenefitQuiryViewController class] currentVC:self];
        } noadmitBlock:^{
            InquiryRecordViewController *inquiryRecordVC = [[InquiryRecordViewController alloc] init];
            [self.navigationController pushViewController:inquiryRecordVC animated:YES];
            NSMutableArray *navViews = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            NSMutableArray *navVCs = [[NSMutableArray alloc] init];
            [navVCs addObject:navViews[0]];
            [navVCs addObject:navViews[1]];
            [navVCs addObject:navViews[2]];
            [navVCs addObject:[navViews lastObject]];
            [self.navigationController setViewControllers:navVCs animated:YES];
        }];
    }];
}

#pragma mark - 选择保险类别按钮点击
- (void)selectFirmDidSelect {
    
}


#pragma mark - 界面赋值
- (void)selectFirmAssignment {
    
    
}


#pragma mark - 布局nav
- (void)selectFirmLayoutNAV {
    self.navigationItem.title = @"选择保险公司";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加方案" style:UIBarButtonItemStylePlain target:self action:@selector(selectFirmRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(selectFirmRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)selectFirmLayoutView {
    /** 确定view */
    self.confirmView = [[UIView alloc] init];
    self.confirmView.backgroundColor = WhiteColor;
    [self.view addSubview:self.confirmView];
    /** 确定btn */
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.backgroundColor = ThemeColor;
    self.confirmBtn.layer.cornerRadius = 2;
    self.confirmBtn.clipsToBounds = YES;
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = SixteenTypeface;
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 2;
    [self.confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmView addSubview:self.confirmBtn];
    /** 保险公司列表table */
    self.firmListTable = [[UITableView alloc] init];
    self.firmListTable.delegate = self;
    self.firmListTable.dataSource = self;
    self.firmListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.firmListTable.backgroundColor = CLEARCOLOR;
    self.firmListTable.rowHeight = 72;
    [self.view addSubview:self.firmListTable];
    // 头部试图
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    /** 预计页面提示 */
    UILabel *expectSign = [[UILabel alloc] initWithFrame:CGRectMake(20, 16, 200, 20)];
    expectSign.text = @"预计10分钟后出结果";
    expectSign.textColor = ThemeColor;
    expectSign.font = ThirteenTypeface;
    [tableHeaderView addSubview:expectSign];
    self.firmListTable.tableHeaderView = tableHeaderView;
    // 初始化保存选择的保险公司
    self.selFirmArray = [[NSMutableArray alloc] init];
}


#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.firmListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"selectFirmCell";
    SelectFirmCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SelectFirmCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.firmModel = [self.firmListArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BenefitFirmModel *firmModel = [self.firmListArray objectAtIndex:indexPath.row];
    firmModel.checkMark = !firmModel.checkMark;
    [self.firmListTable reloadData];
    [self.selFirmArray addObject:firmModel];
}


#pragma mark - viewFrame
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    @weakify(self)
    /** 确定view */
    [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 确定btn */
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.confirmView.mas_top).offset(5);
        make.left.equalTo(self.confirmView.mas_left).offset(16);
        make.bottom.equalTo(self.confirmView.mas_bottom).offset(-5);
        make.right.equalTo(self.confirmView.mas_right).offset(-16);
    }];
    /** 保险公司列表table */
    [self.firmListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.confirmView.mas_top).offset(-0.5);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
