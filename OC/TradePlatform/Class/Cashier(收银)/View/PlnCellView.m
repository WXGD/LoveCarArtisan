//
//  PlnCellView.m
//  TradePlatform
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PlnCellView.h"
// 省份简称键盘
#import "SelectProvinceView.h"
// 大写键盘
#import "CustomKeyboard.h"

@implementation CaftaBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self caftaBtnLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)caftaBtnLayoutView {
    /** 标题文字 */
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = ThemeColor;
    self.titleLabel.font = FourteenTypeface;
    [self addSubview:self.titleLabel];
    /** 标记图片 */
    self.signImage = [[UIImageView alloc] init];
    self.signImage.image = [UIImage imageNamed:@"order_down_arrow"];
    [self addSubview:self.signImage];
    /** 按钮 */
    self.caftaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.caftaBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 标题文字 */
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(@14.5);
    }];
    /** 标记图片 */
    [self.signImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.width.equalTo(self.signImage.mas_height);
    }];
    /** 按钮 */
    [self.caftaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** self */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.signImage.mas_right);
    }];
}

@end



@interface PlnCellView ()

/** 省份简称键盘 */
@property (strong, nonatomic) SelectProvinceView *selectProvince;
/** 选择车辆图片 */
@property (strong, nonatomic) UIImageView *choiceCarImage;
/** 车牌号标题 */
@property (strong, nonatomic) UILabel *plnTitle;
/** 分割线 */
@property (strong, nonatomic) UIView *plnLine;

@end

@implementation PlnCellView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self plnCellLayoutView];
        // 省份简称通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(provinceBtnAction:) name:@"ProvinceBtnNotification" object:nil];
        // 大写键盘删除按钮
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customKeyboardDelete:) name:@"customKeyboardDelete" object:nil];
        // 大写键盘添加文字
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customKeyboardAddContent:) name:@"customKeyboardAddContent" object:nil];
        // 大写键盘下一步
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customKeyboardNextStep:) name:@"customKeyboardNextStep" object:nil];
    }
    return self;
}


#pragma mark - 键盘通知
// 省份简称按钮点击
- (void)caftaBtnAction:(UIButton *)button {
    [self endEditing:YES];
    self.selectProvince = [[SelectProvinceView alloc] init];
    [self.selectProvince show];
}
// 省份简称键盘点击
- (void)provinceBtnAction:(NSNotification *)province {
    [self.selectProvince dismiss];
    self.caftaBtn.titleLabel.text = province.userInfo[@"province"];
}
// 大写键盘通知
// 删除按钮
- (void)customKeyboardDelete:(NSNotification *)notification {
    [self.plnTF deleteBackward];
}
// 文本选中
- (void)customKeyboardAddContent:(NSNotification *)notification {
    [self.plnTF insertText:notification.userInfo[@"choiceBtnContent"]];
}
// 下一步
- (void)customKeyboardNextStep:(NSNotification *)notification {
    [self.superview endEditing:YES];
}



#pragma mark - view布局
- (void)plnCellLayoutView {
    /** 分割线 */
    self.plnLine = [[UIView alloc] init];
    self.plnLine.backgroundColor = DividingLine;
    [self addSubview:self.plnLine];
    /** 车牌号标题 */
    self.plnTitle = [[UILabel alloc] init];
    self.plnTitle.text = @"车牌号";
    self.plnTitle.font = FourteenTypeface;
    self.plnTitle.textColor = GrayH1;
    [self addSubview:self.plnTitle];
    /** 城市简称按钮 */
    self.caftaBtn = [[CaftaBtn alloc] init];
    self.caftaBtn.titleLabel.text = @"豫";
    [self.caftaBtn.caftaBtn addTarget:self action:@selector(caftaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.caftaBtn];
    /** 车牌号输入框 */
    self.plnTF = [[UITextField alloc] init];
    self.plnTF.placeholder = @"请输入车牌号";
    self.plnTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.plnTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.plnTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.plnTF.font = FourteenTypeface;
    self.plnTF.textColor = Black;
    [self addSubview:self.plnTF];
    // 自定义大写键盘
    CustomKeyboard *maskContent = [CustomKeyboard loadBlueViewFromXIB];
    // 注册使用大写键盘
    self.plnTF.inputView = maskContent;
    /** 选择车辆图片 */
    self.choiceCarImage = [[UIImageView alloc] init];
    self.choiceCarImage.image = [UIImage imageNamed:@"cashier_user_car"];
    [self.choiceCarImage setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.choiceCarImage setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.choiceCarImage];
    /** 选择车辆按钮 */
    self.choiceCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.choiceCarBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 分割线 */
    [self.plnLine mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    /** 车牌号标题 */
    [self.plnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(16);
    }];
    /** 城市简称按钮 */
    [self.caftaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(115);
    }];
    /** 选择车辆图片 */
    [self.choiceCarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-16);
    }];
    /** 选择车辆按钮 */
    [self.choiceCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.choiceCarImage.mas_left).offset(-16);
    }];
    /** 车牌号输入框 */
    [self.plnTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.caftaBtn.mas_right).offset(16);
        make.right.equalTo(self.choiceCarBtn.mas_left).offset(-16);
    }];
}

@end




