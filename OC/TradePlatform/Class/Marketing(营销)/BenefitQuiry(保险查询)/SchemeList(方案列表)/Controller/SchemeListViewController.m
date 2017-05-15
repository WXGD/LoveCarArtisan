//
//  SchemeListViewController.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SchemeListViewController.h"
// view
#import "SchemeListCell.h"
// 下级控制器
#import "SelectFirmViewController.h"

@interface SchemeListViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 下一步view */
@property (strong, nonatomic) UIView *nextStepView;
/** 下一步btn */
@property (strong, nonatomic) UIButton *nextStepBtn;
/** 方案列表table */
@property (strong, nonatomic) UITableView *schemeListTable;

@end

@implementation SchemeListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self schemeListLayoutNAV];
    // 布局视图
    [self schemeListLayoutView];
}
#pragma mark - 网络请求


#pragma mark - 按钮点击方法
// nav右边按钮，添加方案
- (void)schemeListRightBarBtnAction {
    if (_addSchemeBlock) {
        _addSchemeBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 下一步
- (void)nextStepBtnAction:(UIButton *)button {
    // 初始化字符串，用来保存方案ID
    NSString *schemeID = [[NSString alloc] init];
    // 遍历列表数组
    for (int i = 0; i < self.schemeArray.count; i++) {
        SafeTypeModel *safeTypeModel = [self.schemeArray objectAtIndex:i];
        NSArray *schemeIDArray = [safeTypeModel.scheme_id componentsSeparatedByString:@","];
        for (NSString *safeID in schemeIDArray) {
            if (schemeID.length == 0) {
                schemeID = [NSString stringWithFormat:@"%d_%@", i+1, safeID];
            }else {
                schemeID = [NSString stringWithFormat:@"%@,%d_%@", schemeID, i+1, safeID];
            }
        }
    }
    SelectFirmViewController *selectFirmVC = [[SelectFirmViewController alloc] init];
    selectFirmVC.safeSchemeID = schemeID;
    selectFirmVC.carModel = self.carModel;
    [self.navigationController pushViewController:selectFirmVC animated:YES];
}

#pragma mark - 选择保险类别按钮点击
- (void)schemeListDidSelect {
    
}


#pragma mark - 界面赋值
- (void)schemeListAssignment {
    
    
}


#pragma mark - 布局nav
- (void)schemeListLayoutNAV {
    self.navigationItem.title = @"投保方案";
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加方案" style:UIBarButtonItemStylePlain target:self action:@selector(schemeListRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加方案" style:UIBarButtonItemStylePlain target:self action:@selector(schemeListRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(schemeListRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)schemeListLayoutView {
    /** 下一步view */
    self.nextStepView = [[UIView alloc] init];
    self.nextStepView.backgroundColor = WhiteColor;
    [self.view addSubview:self.nextStepView];
    /** 下一步btn */
    self.nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextStepBtn.backgroundColor = ThemeColor;
    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextStepBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.nextStepBtn.titleLabel.font = SixteenTypeface;
    self.nextStepBtn.layer.masksToBounds = YES;
    self.nextStepBtn.layer.cornerRadius = 2;
    [self.nextStepBtn addTarget:self action:@selector(nextStepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextStepView addSubview:self.nextStepBtn];
    /** 方案列表table */
    self.schemeListTable = [[UITableView alloc] init];
    self.schemeListTable.delegate = self;
    self.schemeListTable.dataSource = self;
    self.schemeListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.schemeListTable.backgroundColor = CLEARCOLOR;
    [self.view addSubview:self.schemeListTable];
}


#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.schemeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"schemeListCell";
    SchemeListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SchemeListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    /** 方案标题view */
    cell.schemeTitleView.cellLabel.text = [NSString stringWithFormat:@"方案%ld", (long)indexPath.row + 1];
    /** 方案内容Label */
    SafeTypeModel *safeTypeModel = [self.schemeArray objectAtIndex:indexPath.row];
    cell.schemeCententLabel.attributedText = safeTypeModel.scheme_name_attri;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeTypeModel *safeTypeModel = [self.schemeArray objectAtIndex:indexPath.row];
    if (_editSchemeBlock) {
        _editSchemeBlock(safeTypeModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SafeTypeModel *safeTypeModel = [self.schemeArray objectAtIndex:indexPath.row];
    return 94 + [CustomString heightForString:safeTypeModel.scheme_name textFont:TwelveTypeface textWidth:ScreenW - 32];
}

#pragma mark - viewFrame
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    @weakify(self)
    /** 下一步view */
    [self.nextStepView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 下一步btn */
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.nextStepView.mas_top).offset(5);
        make.left.equalTo(self.nextStepView.mas_left).offset(16);
        make.bottom.equalTo(self.nextStepView.mas_bottom).offset(-5);
        make.right.equalTo(self.nextStepView.mas_right).offset(-16);
    }];
    /** 方案列表table */
    [self.schemeListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.nextStepView.mas_top).offset(-0.5);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
