//
//  BenefitQuiryView.m
//  TradePlatform
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitQuiryView.h"
#import "ZYKeyboardUtil.h"
// 省份简称键盘
#import "SelectProvinceView.h"
// 大写键盘
#import "CustomKeyboard.h"
// 下级控制器
#import "ImageCropViewController.h"
// view
#import "DrivingPermitView.h"
// model
#import "BenefitCarInfoModel.h"

@interface BenefitQuiryView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, PECropViewControllerDelegate>
/** 提交view */
@property (strong, nonatomic) UIView *submitView;
/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *benefitQuiryScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *benefitQuiryView;
/** 分割线 */
@property (strong, nonatomic) UIView *recordLineView;
/** 行驶证拍摄 */
@property (strong, nonatomic) UIView *cardShotView;
/** 车牌号view */
@property (strong, nonatomic) UIView *plnView;
@property (strong, nonatomic) UILabel *plnTitleLabel;
@property (strong, nonatomic) UIView *plnLineView;
/** 注册时间选择 */
@property (strong, nonatomic) UIButton *registerTimeBtn;
/** 省份简称键盘 */
@property (strong, nonatomic) SelectProvinceView *selectProvince;
/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation BenefitQuiryView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self benefitQuiryLayoutView];
        // 操作键盘弹出
        self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
        @weakify(self)
        [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
            @strongify(self)
            [keyboardUtil adaptiveViewHandleWithAdaptiveView:self, nil];
        }];
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

#pragma mark - 按钮点击方法
// 拍摄按钮点击
- (void)shotBtnAction:(UIButton *)button {
    // 图片选择
    [AlertAction callCameraAlertActionStyleActionSheetBtn:button ViewController:[self viewController] CameraBlock:^(UIImagePickerController *picker) {
        // 设置代理
        picker.delegate = self;
    } albumBlock:^(UIImagePickerController *picker) {
        // 设置代理
        picker.delegate = self;
    } cancelBlock:nil];
}
// 行驶证按钮
- (void)drivingPermitBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 品牌车型 */
        case CarBrandBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_car_brand"];
            [drivingPermitView show];
            break;
        }
            /** 车架号 */
        case VinBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_vin"];
            [drivingPermitView show];
            break;
        }
            /** 发动机号 */
        case EngineBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_engine"];
            [drivingPermitView show];
            break;
        }
            /** 初次登记时间 */
        case CheckTimeBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_check_time"];
            [drivingPermitView show];
            break;
        }
            /** 所有人 */
        case HoldManBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_hold_man"];
            [drivingPermitView show];
            break;
        }
        default:
            break;
    }
}
// 登记时间                                                 
- (void)registerTimeBtnAvtion:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        self.registerTimeView.viceTextFiled.text = timestamp;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
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
#pragma mark - 拍照，图片选择代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [[UIImage alloc] init];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
    } else {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    @weakify(self)
    [[self viewController].navigationController dismissViewControllerAnimated:YES completion:^{
        @strongify(self)
        ImageCropViewController *imageCropVC = [[ImageCropViewController alloc] init];
        imageCropVC.delegate = self;
        imageCropVC.image = image;
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        CGFloat length = MIN(width, height);
        imageCropVC.imageCropRect = CGRectMake((width - length) / 2, (height - length) / 2, length, length);
        imageCropVC.toolbarHidden = YES;
        [[self viewController].navigationController pushViewController:imageCropVC animated:YES];
    }];
}
#pragma mark - 取消图片挑选
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[self viewController].navigationController dismissViewControllerAnimated:YES completion:^{ }];
}
#pragma mark - 图片裁剪代理方法
// 确认裁剪
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    [controller.navigationController popViewControllerAnimated:YES];
    
    [BenefitCarInfoModel uploadDrivingLicenseImageRequestDrivingLicenseInfoImage:croppedImage success:^(NSMutableDictionary *drivingLicenseInfo) {
        /** 车牌号 */
        NSString *pln = drivingLicenseInfo[@"号牌号码"];
        self.plnTF.text = [pln substringFromIndex:1];
        self.caftaBtn.titleLabel.text = [pln substringToIndex:1];
        /** 品牌车型 */
        self.carBrandView.viceTextFiled.text = drivingLicenseInfo[@"品牌型号"];
        /** 车架号 */
        self.vinView.viceTextFiled.text = drivingLicenseInfo[@"车辆识别代号"];
        /** 发动机号 */
        self.engineView.viceTextFiled.text = drivingLicenseInfo[@"发动机号码"];
        /** 注册时间 */
        self.registerTimeView.viceTextFiled.text = drivingLicenseInfo[@"注册日期"];
        /** 所有人 */
        self.holdManView.viceTextFiled.text = drivingLicenseInfo[@"所有人"];
    }];
    // 把选择的图片赋值给头像
    /** 行驶证图片 */
    self.cardImg.image = croppedImage;
    // 显示行驶证图片
    [self.cardImg setHidden:NO];
    // 隐藏行驶证选择
    [self.cardShotView setHidden:YES];
    /** 车牌号view */
    @weakify(self)
    [self.plnView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.inquiryRecordBtn.mas_bottom).offset(190.5);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_equalTo(@48);
    }];
}
// 取消裁剪
- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [controller.navigationController popViewControllerAnimated:YES];
}



#pragma mark - view布局
- (void)benefitQuiryLayoutView {
    /** 提交view */
    self.submitView = [[UIView alloc] init];
    self.submitView.backgroundColor = WhiteColor;
    [self addSubview:self.submitView];
    /** 提交查询btn */
    self.submitQueryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitQueryBtn.backgroundColor = ThemeColor;
    self.submitQueryBtn.layer.cornerRadius = 2;
    self.submitQueryBtn.clipsToBounds = YES;
    [self.submitQueryBtn setTitle:@"确认查询" forState:UIControlStateNormal];
    [self.submitQueryBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.submitQueryBtn.titleLabel.font = SixteenTypeface;
    self.submitQueryBtn.layer.masksToBounds = YES;
    self.submitQueryBtn.layer.cornerRadius = 2;
    self.submitQueryBtn.tag = SubmitQueryBtnAction;
    [self.submitView addSubview:self.submitQueryBtn];
    /** 背景scrollview */
    self.benefitQuiryScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.benefitQuiryScrollView];
    /** 填充scrollview的view */
    self.benefitQuiryView = [[UIView alloc] init];
    [self.benefitQuiryScrollView addSubview:self.benefitQuiryView];
    UITapGestureRecognizer *benefitQuiryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(benefitQuiryTapAction)];
    [self.benefitQuiryView addGestureRecognizer:benefitQuiryTap];
    /** 询价记录 */
    self.inquiryRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.inquiryRecordBtn.backgroundColor = WhiteColor;
    [self.inquiryRecordBtn setImage:[UIImage imageNamed:@"benefit_inquiry_record"] forState:UIControlStateNormal];
    [self.inquiryRecordBtn setTitle:@"询价记录" forState:UIControlStateNormal];
    [self.inquiryRecordBtn setTitleColor:Black forState:UIControlStateNormal];
    self.inquiryRecordBtn.titleLabel.font = FourteenTypeface;
    self.inquiryRecordBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.inquiryRecordBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.inquiryRecordBtn.tag = InquiryRecordBtnAction;
    [self.benefitQuiryView addSubview:self.inquiryRecordBtn];
    /** 分割线 */
    self.recordLineView = [[UIView alloc] init];
    self.recordLineView.backgroundColor = DividingLine;
    [self.benefitQuiryView addSubview:self.recordLineView];
    /** 出险记录 */
    self.dangerRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dangerRecordBtn.backgroundColor = WhiteColor;
    [self.dangerRecordBtn setImage:[UIImage imageNamed:@"benefit_danger_record"] forState:UIControlStateNormal];
    [self.dangerRecordBtn setTitle:@"出险记录" forState:UIControlStateNormal];
    [self.dangerRecordBtn setTitleColor:Black forState:UIControlStateNormal];
    self.dangerRecordBtn.titleLabel.font = FourteenTypeface;
    self.dangerRecordBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.dangerRecordBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.dangerRecordBtn.tag = DangerRecordBtnAction;
    [self.benefitQuiryView addSubview:self.dangerRecordBtn];
    /** 行驶证拍摄 */
    self.cardShotView = [[UIView alloc] init];
    self.cardShotView.backgroundColor = WhiteColor;
    [self.benefitQuiryView addSubview:self.cardShotView];
    /** 拍摄 */
    self.shotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shotBtn.backgroundColor = HEXSTR_RGB(@"fafafa");
    self.shotBtn.titleLabel.textColor = Black;
    [self.shotBtn setTitle:@"拍摄行驶证正面快速查询" forState:UIControlStateNormal];
    [self.shotBtn setTitleColor:Black forState:UIControlStateNormal];
    self.shotBtn.titleLabel.font = FourteenTypeface;
    [self.shotBtn setImage:[UIImage imageNamed:@"benefit_shot"] forState:UIControlStateNormal];
    self.shotBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.shotBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.shotBtn.titleLabel.font = SixteenTypeface;
    self.shotBtn.layer.masksToBounds = YES;
    self.shotBtn.layer.cornerRadius = 2;
    self.shotBtn.layer.borderWidth = 1;
    self.shotBtn.layer.borderColor = HEXSTR_RGB(@"efeff4").CGColor;
    self.shotBtn.tag = ShotBtnAction;
    [self.shotBtn addTarget:self action:@selector(shotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cardShotView addSubview:self.shotBtn];
    /** 行驶证图片 */
    self.cardImg = [[UIImageView alloc] init];
    self.cardImg.userInteractionEnabled = YES;
    [self.benefitQuiryView addSubview:self.cardImg];
    /** 更换图片 */
    self.changeImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeImgBtn.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self.changeImgBtn setTitle:@"更换图片" forState:UIControlStateNormal];
    [self.changeImgBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.changeImgBtn.titleLabel.font = FourteenTypeface;
    self.changeImgBtn.layer.masksToBounds = YES;
    self.changeImgBtn.layer.cornerRadius = 2;
    [self.changeImgBtn addTarget:self action:@selector(shotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cardImg addSubview:self.changeImgBtn];
    // 隐藏行驶证图片
    [self.cardImg setHidden:YES];
    /** 车牌号view */
    self.plnView = [[UIView alloc] init];
    self.plnView.backgroundColor = WhiteColor;
    [self.benefitQuiryView addSubview:self.plnView];
    
    self.plnLineView = [[UIView alloc] init];
    self.plnLineView.backgroundColor = DividingLine;
    [self.plnView addSubview:self.plnLineView];
    
    self.plnTitleLabel = [[UILabel alloc] init];
    self.plnTitleLabel.text = @"车牌号";
    self.plnTitleLabel.font = FourteenTypeface;
    self.plnTitleLabel.textColor = GrayH1;
    [self.plnView addSubview:self.plnTitleLabel];
    
    self.caftaBtn = [[CaftaBtn alloc] init];
    self.caftaBtn.titleLabel.text = @"豫";
    self.caftaBtn.tag = CaftaBtnAction;
    [self.caftaBtn.caftaBtn addTarget:self action:@selector(caftaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.plnView addSubview:self.caftaBtn];
    
    self.plnTF = [[UITextField alloc] init];
    self.plnTF.placeholder = @"请输入车牌号";
    self.plnTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.plnTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.plnTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.plnTF.font = FourteenTypeface;
    self.plnTF.textColor = Black;
    [self.plnView addSubview:self.plnTF];
    // 自定义大写键盘
    CustomKeyboard *maskContent = [CustomKeyboard loadBlueViewFromXIB];
    // 注册使用大写键盘
    self.plnTF.inputView = maskContent;
    
    self.plnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.plnBtn setImage:[UIImage imageNamed:@"custom_open_card_scan"] forState:UIControlStateNormal];
    self.plnBtn.tag = PlnBtnAction;
    [self.plnView addSubview:self.plnBtn];
    /** 品牌车型 */
    self.carBrandView = [[UsedCellView alloc] init];
    self.carBrandView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.carBrandView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.carBrandView.cellLabel.text = @"品牌车型";
    self.carBrandView.cellLabel.font = FifteenTypeface;
    self.carBrandView.cellLabel.textColor = GrayH1;
    self.carBrandView.viceTextFiled.placeholder = @"请输入品牌车型";
    self.carBrandView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.carBrandView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.carBrandView.viceTextFiled.textColor = Black;
    self.carBrandView.viceTextFiled.font = FourteenTypeface;
    self.carBrandView.isCellImage = YES;
    self.carBrandView.isCellBtn = YES;
    self.carBrandView.arrowImage.tag = CarBrandBtnAction;
    [self.carBrandView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.benefitQuiryView addSubview:self.carBrandView];
    /** 车架号 */
    self.vinView = [[UsedCellView alloc] init];
    self.vinView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.vinView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.vinView.cellLabel.text = @"车架号";
    self.vinView.cellLabel.font = FifteenTypeface;
    self.vinView.cellLabel.textColor = GrayH1;
    self.vinView.viceTextFiled.placeholder = @"请输入车架号";
    self.vinView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.vinView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.vinView.viceTextFiled.textColor = Black;
    self.vinView.viceTextFiled.font = FourteenTypeface;
    self.vinView.isCellImage = YES;
    self.vinView.isCellBtn = YES;
    self.vinView.arrowImage.tag = VinBtnAction;
    [self.vinView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.benefitQuiryView addSubview:self.vinView];
    /** 发动机号 */
    self.engineView = [[UsedCellView alloc] init];
    self.engineView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.engineView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.engineView.cellLabel.text = @"发动机号";
    self.engineView.cellLabel.font = FifteenTypeface;
    self.engineView.cellLabel.textColor = GrayH1;
    self.engineView.viceTextFiled.placeholder = @"请输入发动机号";
    self.engineView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.engineView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.engineView.viceTextFiled.textColor = Black;
    self.engineView.viceTextFiled.font = FourteenTypeface;
    self.engineView.isCellImage = YES;
    self.engineView.isCellBtn = YES;
    self.engineView.arrowImage.tag = EngineBtnAction;
    [self.engineView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.benefitQuiryView addSubview:self.engineView];
    /** 注册时间 */
    self.registerTimeView = [[UsedCellView alloc] init];
    self.registerTimeView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.registerTimeView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.registerTimeView.cellLabel.text = @"注册时间";
    self.registerTimeView.cellLabel.font = FourteenTypeface;
    self.registerTimeView.cellLabel.textColor = GrayH1;
    [self.registerTimeView.viceTextFiled setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.registerTimeView.viceTextFiled setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.registerTimeView.viceTextFiled.placeholder = @"请选择初次登记时间";
    self.registerTimeView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.registerTimeView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.registerTimeView.viceTextFiled.font = FourteenTypeface;
    self.registerTimeView.viceTextFiled.textColor = Black;
    self.registerTimeView.isCellImage = YES;
    self.registerTimeView.isCellBtn = YES;
    self.registerTimeView.arrowImage.tag = CheckTimeBtnAction;
    [self.registerTimeView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.benefitQuiryView addSubview:self.registerTimeView];
    // 获取当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    self.registerTimeView.viceTextFiled.text = dateTime;
    /** 注册时间选择 */
    self.registerTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerTimeBtn addTarget:self action:@selector(registerTimeBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerTimeView addSubview:self.registerTimeBtn];
    /** 所有人 */
    self.holdManView = [[UsedCellView alloc] init];
    self.holdManView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.holdManView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.holdManView.cellLabel.text = @"所有人";
    self.holdManView.cellLabel.font = FifteenTypeface;
    self.holdManView.cellLabel.textColor = GrayH1;
    self.holdManView.viceTextFiled.placeholder = @"请输入车辆所有人姓名";
    self.holdManView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.holdManView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.holdManView.viceTextFiled.textColor = Black;
    self.holdManView.viceTextFiled.font = FourteenTypeface;
    self.holdManView.isCellImage = YES;
    self.holdManView.isCellBtn = YES;
    self.holdManView.arrowImage.tag = HoldManBtnAction;
    [self.holdManView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.benefitQuiryView addSubview:self.holdManView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 提交view */
    [self.submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 提交查询btn */
    [self.submitQueryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.submitView.mas_top).offset(5);
        make.left.equalTo(self.submitView.mas_left).offset(16);
        make.bottom.equalTo(self.submitView.mas_bottom).offset(-5);
        make.right.equalTo(self.submitView.mas_right).offset(-16);
    }];
    /** 背景scrollview */
    [self.benefitQuiryScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.submitView.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.benefitQuiryView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benefitQuiryScrollView.mas_top);
        make.left.equalTo(self.benefitQuiryScrollView.mas_left);
        make.bottom.equalTo(self.benefitQuiryScrollView.mas_bottom);
        make.right.equalTo(self.benefitQuiryScrollView.mas_right);
        make.width.equalTo(self.benefitQuiryScrollView.mas_width);
        make.bottom.equalTo(self.holdManView.mas_bottom).offset(10);
    }];
    /** 询价记录 */
    [self.inquiryRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benefitQuiryView.mas_top);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_centerX);
        make.height.mas_offset(@50);
    }];
    /** 分割线 */
    [self.recordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.inquiryRecordBtn.mas_centerY);
        make.right.equalTo(self.inquiryRecordBtn.mas_right);
        make.width.mas_offset(@0.5);
        make.height.mas_offset(@25);
    }];
    /** 出险记录 */
    [self.dangerRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.inquiryRecordBtn.mas_top);
        make.left.equalTo(self.inquiryRecordBtn.mas_right);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.equalTo(self.inquiryRecordBtn.mas_height);
    }];
    /** 行驶证拍摄 */
    [self.cardShotView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.inquiryRecordBtn.mas_bottom).offset(10);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_offset(@60);
    }];
    /** 拍摄 */
    [self.shotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardShotView.mas_top).offset(10);
        make.bottom.equalTo(self.cardShotView.mas_bottom).offset(-10);
        make.left.equalTo(self.cardShotView.mas_left).offset(16);
        make.right.equalTo(self.cardShotView.mas_right).offset(-16);
    }];
    /** 行驶证图片 */
    [self.cardImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.inquiryRecordBtn.mas_bottom).offset(10);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_offset(@180);
    }];
    /** 更换图片 */
    [self.changeImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardImg.mas_top).offset(10);
        make.right.equalTo(self.cardImg.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
    /** 车牌号view */
    [self.plnView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.inquiryRecordBtn.mas_bottom).offset(70.5);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    [self.plnLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.plnView.mas_left).offset(16);
        make.right.equalTo(self.plnView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    [self.plnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnView.mas_centerY);
        make.left.equalTo(self.plnView.mas_left).offset(16);
    }];
    [self.caftaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_top);
        make.bottom.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.plnView.mas_left).offset(115);
    }];
    [self.plnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_top);
        make.bottom.equalTo(self.plnView.mas_bottom);
        make.right.equalTo(self.plnView.mas_right).offset(-16);
    }];
    [self.plnTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.plnView.mas_bottom);
        make.top.equalTo(self.plnView.mas_top);
        make.left.equalTo(self.caftaBtn.mas_right).offset(16);
        make.right.equalTo(self.plnBtn.mas_left).offset(10);
    }];
    /** 品牌车型 */
    [self.carBrandView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 车架号 */
    [self.vinView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBrandView.mas_bottom);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    [self.vinView.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@44);
    }];
    /** 发动机号 */
    [self.engineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.vinView.mas_bottom);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 注册时间 */
    [self.registerTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.engineView.mas_bottom);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 注册时间选择 */
    [self.registerTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.registerTimeView.mas_top);
        make.left.equalTo(self.registerTimeView.mas_left);
        make.bottom.equalTo(self.registerTimeView.mas_bottom);
        make.right.equalTo(self.registerTimeView.mas_right).offset(-80);
    }];
    /** 所有人 */
    [self.holdManView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.registerTimeView.mas_bottom);
        make.left.equalTo(self.benefitQuiryView.mas_left);
        make.right.equalTo(self.benefitQuiryView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    [self.holdManView.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@44);
    }];
}


#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
- (void)benefitQuiryTapAction {
    [self endEditing:YES];
}

@end
