//
//  CardCategoryViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardCategoryViewController.h"
#import "GJBaseTabelView.h"
// 修改卡类型网络请求
#import "CardInfoChangeNetwork.h"

@interface CardCategoryViewController ()<GJTableViewDelegate>

/** 会员卡类型 */
@property (strong, nonatomic) GJBaseTabelView *cardCategoryTable;
@property (strong, nonatomic) CardCategoryDataSource *cardCategoryDataSource;

@end

@implementation CardCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self cardCategoryLayoutNAV];
    // 布局视图
    [self cardCategoryLayoutView];
    // 网络请求
    [self cardCategoryRequest];
}
#pragma mark - 网络请求
- (void)cardCategoryRequest {
    // 便利数据，找到当前选中的卡类型
    for (CardCategoryModel *cardCategory in self.cardCategoryArray) {
        cardCategory.checkMark = NO;
        if ([cardCategory.name isEqualToString:self.cardCategoryName]) {
            cardCategory.checkMark = YES;
        }
    }
    self.cardCategoryDataSource.rowArray = self.cardCategoryArray;
    [self.cardCategoryTable reloadData];
}
#pragma mark - 按钮点击方法
- (void)tableView:(UITableView *)tableView rowDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    // 获取选中卡类别
    CardCategoryModel *cardCategoryModel = self.cardCategoryDataSource.rowArray[indexPath.row];
    // 判断是否有修改，
    if ([cardCategoryModel.name isEqualToString:self.cardCategoryName]) {
        return;
    }
    switch (self.cardCategoryType) {
            /** 修改卡类别 */
        case ChangeCardCategoryAssignment: {
            /*/index.php?c=provider_card&a=edit&v=1
             provider_card_id 	int 	是 	服务商卡id
             data 	string 	否 	编辑除了可适用的服务以外的数据必传（格式: 数据库字段名=值，字段名参考备注）
             rules 	string 	否 	编辑适用的服务必传, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)  */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardInfoModel.provider_card_id]; // 商品id
            params[@"data"] = [NSString stringWithFormat:@"card_category_id=%ld", cardCategoryModel.card_category_id]; // 卡类型
            [CardInfoChangeNetwork cardInfoChange:params success:^{
                if (_CardTypeChioceBlock) {
                    _CardTypeChioceBlock(cardCategoryModel);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 不修改卡类别 */
        case NOChangeCardCategoryAssignment: {
            if (_CardTypeChioceBlock) {
                _CardTypeChioceBlock(cardCategoryModel);
            }
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 布局nav
- (void)cardCategoryLayoutNAV {
    self.navigationItem.title = @"类型";
    // 左边
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"旧版订单"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsOrderRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)cardCategoryLayoutView {
    @weakify(self)
    /** 会员卡 */
    self.cardCategoryTable = [[GJBaseTabelView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 300) style:UITableViewStylePlain];
    self.cardCategoryDataSource = [[CardCategoryDataSource alloc] init];
    self.cardCategoryTable.GJDataSource = self.cardCategoryDataSource;
    self.cardCategoryTable.GJDelegate = self;
    self.cardCategoryTable.backgroundColor = CLEARCOLOR;
    self.cardCategoryTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.cardCategoryTable.separatorColor = DividingLine;
    [self.view addSubview:self.cardCategoryTable];
    [self.cardCategoryTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    // tableview高度随数据高度变化而变化
    [self.cardCategoryTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
