//
//  CardTypeChoiceViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardTypeChoiceViewController.h"
#import "CardTypeChoiceCell.h"

@interface CardTypeChoiceViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 会员卡选择view */
@property (strong, nonatomic) UITableView *cardTypeChoiceTable;
/** 会员卡选择类型数据 */
@property (strong, nonatomic) NSMutableArray *cardTypeChoiceArray;

@end

@implementation CardTypeChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self userCardLayoutNAV];
    // 布局视图
    [self userCardLayoutView];
    // 请求会员卡类型选择
    [self requestCardTypeChoice];
}
#pragma mark - 网络请求
// 请求会员卡类型选择
- (void)requestCardTypeChoice {
    // 下拉刷新
    @weakify(self)
    self.cardTypeChoiceTable.mj_header = [GifHeaderRefresh headerWithRefreshingBlock:^{
        @strongify(self)
        /* /index.php?c=provider_card&a=list&v=1
         provider_id 	int 	是 	服务商id     */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        [CardTypeModel requestCardTypeListDataParams:params tableView:self.cardTypeChoiceTable success:^(NSMutableArray *cardTypeArray) {
            // 移除无数据视图
            [self removeNoDataView];
            // 判断是否有数据
            if (cardTypeArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage, UIView *noDataView) {
                    [noDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.cardTypeChoiceTable.mas_centerX);
                        make.centerY.equalTo(self.cardTypeChoiceTable.mas_centerY);
                        make.top.equalTo(noImage.mas_top);
                        make.bottom.equalTo(noLabel.mas_bottom).offset(30);
                        make.width.mas_equalTo(ScreenW);
                    }];
                }];
            }else {
                // 遍历数据，找出默认选中
                for (CardTypeModel *cardTypeModel in cardTypeArray) {
                    cardTypeModel.checkMark = NO;
                    if (cardTypeModel.provider_card_id == self.cardInfoModel.provider_card_id) {
                        cardTypeModel.checkMark = YES;
                    }
                }
                self.cardTypeChoiceArray = cardTypeArray;
                [self.cardTypeChoiceTable reloadData];
            }
        }];
    }];
    // 马上刷新
    [self.cardTypeChoiceTable.mj_header beginRefreshing];
}



#pragma mark - 会员卡选择页功能选择按钮
/** 选择卡按钮 */
 - (void)choiceCardBtnAction:(UIButton *)button {
     // 获取选中卡
     CardTypeModel *cardTypeModel = [self.cardTypeChoiceArray objectAtIndex:button.tag];
     // 判断如果是之前选中的卡，那么久取消选择
     if (cardTypeModel.provider_card_id == self.cardInfoModel.provider_card_id) {
         cardTypeModel = nil;
     }
     if (_CardTypeChoiceBlock) {
         _CardTypeChoiceBlock(cardTypeModel);
     }
     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 布局nav
- (void)userCardLayoutNAV {
    self.navigationItem.title = @"选择卡";
    // 右边
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(userCardRightBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(userCardRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)userCardLayoutView {
    /** 会员卡选择view */
    self.cardTypeChoiceTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.cardTypeChoiceTable.delegate = self;
    self.cardTypeChoiceTable.dataSource = self;
    self.cardTypeChoiceTable.backgroundColor = CLEARCOLOR;
    self.cardTypeChoiceTable.rowHeight = 123;
    self.cardTypeChoiceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.cardTypeChoiceTable];
    // tableview高度随数据高度变化而变化
    [self.cardTypeChoiceTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    @weakify(self)
    [self.cardTypeChoiceTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cardTypeChoiceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cardTypeCell";
    CardTypeChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CardTypeChoiceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.cardInfoModel = [self.cardTypeChoiceArray objectAtIndex:indexPath.row];
    /** 选择卡按钮 */
    cell.choiceCardBtn.tag = indexPath.row;
    [cell.choiceCardBtn addTarget:self action:@selector(choiceCardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取选中卡
    CardTypeModel *cardTypeModel = [self.cardTypeChoiceArray objectAtIndex:indexPath.row];
    // 判断如果是之前选中的卡，那么久取消选择
    if (cardTypeModel.provider_card_id == self.cardInfoModel.provider_card_id) {
        cardTypeModel = nil;
    }
    if (_CardTypeChoiceBlock) {
        _CardTypeChoiceBlock(cardTypeModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
