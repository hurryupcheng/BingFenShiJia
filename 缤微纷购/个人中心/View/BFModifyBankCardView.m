//
//  BFModifyBankCardView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define Height  BF_ScaleHeight(20)

#define LabelH      BF_ScaleHeight(15)
#define TextFieldH  BF_ScaleHeight(30)
#define MarginW     BF_ScaleWidth(15)
#define MarginH     BF_ScaleHeight(10)

#import "BFModifyBankCardView.h"
#import "BFBankButton.h"
#import "BFPickerView.h"
#import "BFBankModel.h"
#import "HZQRegexTestter.h"

@interface BFModifyBankCardView()<BFPickerViewDelegate, UITextFieldDelegate>@property (nonatomic, strong) BFPickerView *pickerView;
/**银行button*/
@property (nonatomic, strong) BFBankButton *bankButton;
/**省份button*/
@property (nonatomic, strong) BFBankButton *provinceButton;
/**城市button*/
@property (nonatomic, strong) BFBankButton *cityButton;
/**支行button*/
@property (nonatomic, strong) BFBankButton *branchButton;
/**银行数组*/
@property (nonatomic, strong) NSArray *bankArray;
/**plist文件字典*/
@property(nonatomic,strong)NSDictionary *pickerDic;
/**省份数组*/
@property(nonatomic,strong)NSArray *provinceArray;
/**城市数组*/
@property(nonatomic,strong)NSArray *cityArray;
/**支行数组*/
@property (nonatomic, strong) NSArray *branchArray;
/**银行*/
@property (nonatomic, strong) NSString *bankID;
/**省份*/
@property (nonatomic, strong) NSString *provinceID;
/**城市*/
@property (nonatomic, strong) NSString *cityID;
/**支行id*/
@property (nonatomic, strong) NSString *branchID;
/**请求数据*/
@property (nonatomic, strong) NSMutableDictionary *parameter;

@property (nonatomic, strong) UITextField *branchTF;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) BFBankModel *model;

@property (nonatomic, strong) BFUserInfo *userInfo;

@property (nonatomic, strong) NSString *bank_branch;

//@property (nonatomic, strong) BFBankModel *bankInfo;
///**保存城市数组*/
//@property (nonatomic, strong) NSString *cityPath;
///**保存支行数组*/
//@property (nonatomic, strong) NSString *branchPath;
@end

@implementation BFModifyBankCardView



- (BFUserInfo *)userInfo {
    if (!_userInfo) {
        _userInfo = [BFUserDefaluts getUserInfo];
    }
    return _userInfo;
}

- (NSMutableDictionary *)parameter {
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionary];
    }
    return _parameter;
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xF4F4F4);
        //
        [self getPickerData];
        //创建
        [self setUpView];
    }
    return self;
}

#pragma mark - get data
- (void)getPickerData
{
    NSString *provincePath = [[NSBundle mainBundle] pathForResource:@"Province" ofType:@"plist"];
    NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"bankAddress" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:cityPath];
    self.provinceArray = [[NSArray alloc] initWithContentsOfFile:provincePath];
    
    
    //进入页面获取城市数组
    if (self.userInfo.sheng.length != 0) {
        BFLog(@"-----省份=%@", self.userInfo.sheng);
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSString *object in self.provinceArray) {
            if ([object isEqualToString:self.userInfo.sheng]) {
                NSArray *array = [[[self.pickerDic objectForKey:self.userInfo.sheng] objectAtIndex:0] allKeys] ;
                [mutableArray addObjectsFromArray:array];
            }
        }
        [mutableArray insertObject:@"--请选择--" atIndex:0];

        self.cityArray = [mutableArray copy];
    }
   
    //进入页面获取支行数组
    if (self.userInfo.card_address.length != 0) {
        NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=branch"];
        self.parameter[@"uid"] = self.userInfo.ID;
        self.parameter[@"token"] = self.userInfo.token;
        self.parameter[@"bank"] = self.userInfo.bank_name;
        self.parameter[@"sheng"] = self.userInfo.sheng;
        self.parameter[@"shi"] = self.userInfo.shi;
        [BFHttpTool POST:url params:self.parameter success:^(id responseObject) {
            BFLog(@"%@,%@",responseObject, self.parameter);
            if ([responseObject[@"status"] isEqualToString:@"0"]) {
                return ;
            }else {
                self.branchArray = nil;
                self.model = [BFBankModel parse:responseObject];
                NSArray *array = [BFBranchList parse:self.model.bank];
                NSMutableArray *mutableArray = [NSMutableArray array];
                for (BFBranchList *list in array) {
                    [mutableArray addObject:list.name];
                }
                [mutableArray insertObject:@"--请选择--" atIndex:0];
                self.branchArray = [mutableArray copy];
            }
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];
    }else {
        self.branchArray = @[@"--请选择--", @"其他"];
    }  
}




- (void)setUpView {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    //银行网点
    UILabel *bankBranch = [self setUpLabelWithFrame:CGRectMake(MarginW, BF_ScaleHeight(5), BF_ScaleWidth(100), BF_ScaleHeight(15)) text:@"银行网点："];
    bankBranch.textColor = BFColor(0x9D9D9D);
    bankBranch.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(15)];
    [self addSubview:bankBranch];
    
    //银行
    UILabel *bank = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(bankBranch.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), Height) text:@"银行："];
    [self addSubview:bank];
    
    //地区
    UILabel *area = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(bank.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), Height) text:@"地区："];
    [self addSubview:area];
    
    //支行
    UILabel *branch = [self setUpLabelWithFrame:CGRectMake(MarginW, CGRectGetMaxY(area.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), Height) text:@"支行："];
    [self addSubview:branch];
    
    self.bankButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(bank.frame), bank.y,BF_ScaleWidth(110), Height) type:BFChooseButtonTypeBank];
    self.bankButton.buttonTitle.text = self.userInfo.bank_name.length != 0 ? self.userInfo.bank_name : @"--请选择--";
    [self.bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.provinceButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(area.frame), area.y, BF_ScaleWidth(80), Height) type:BFChooseButtonTypeProvince];
    self.provinceButton.buttonTitle.text = self.userInfo.sheng ? self.userInfo.sheng : @"--请选择--";
    [self.provinceButton addTarget:self action:@selector(provinceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cityButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.provinceButton.frame)+BF_ScaleWidth(10), area.y, BF_ScaleWidth(80), Height) type:BFChooseButtonTypeCity];
    if (self.userInfo.shi) {
        self.cityButton.buttonTitle.text = self.userInfo.shi ? self.userInfo.shi : @"--请选择--";
        self.cityButton.hidden = NO;
    }else {
        self.cityButton.buttonTitle.text = @"--请选择--";
        self.cityButton.hidden = YES;
    }
    
    [self.cityButton addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.branchButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(branch.frame), branch.y, BF_ScaleWidth(200), Height) type:BFChooseButtonTypeBranch];
    
    CGRect frame = CGRectZero;
    BFLog(@"********%@",self.userInfo.bank_branch);
    if ([userInfo.bank_branch isEqualToString:@"999999"]) {
        self.branchButton.buttonTitle.text = @"其他";
        frame = CGRectMake(MarginW, CGRectGetMaxY(self.branchButton.frame)+BF_ScaleHeight(10), BF_ScaleWidth(290), BF_ScaleHeight(30));
    }else {
        self.branchButton.buttonTitle.text = self.userInfo.card_address.length != 0 ? self.userInfo.card_address : @"--请选择--";
        frame = CGRectMake(MarginW, CGRectGetMaxY(self.branchButton.frame)+BF_ScaleHeight(10), BF_ScaleWidth(290), BF_ScaleHeight(0));
    }
    [self.branchButton addTarget:self action:@selector(branchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    

    self.branchTF = [UITextField textFieldWithFrame:frame placeholder:@"请输入银行支行"];
    self.branchTF.text = userInfo.card_address;
    self.branchTF.delegate = self;
    self.branchTF.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.branchTF];
    
    CGRect branchFrame = CGRectZero;
    if ([userInfo.bank_branch isEqualToString:@"999999"]) {
        branchFrame = CGRectMake(0, CGRectGetMaxY(self.branchTF.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(260));
    }else {
        branchFrame = CGRectMake(0, CGRectGetMaxY(self.branchButton.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(260));
    }
    self.detailInfo = [[BFModifyBankDetailInfoView alloc] initWithFrame:branchFrame];
    //self.detailInfo.backgroundColor = [UIColor redColor];
    [self addSubview:self.detailInfo];
    
    self.sureButton = [UIButton buttonWithType:0];
    
    self.sureButton.backgroundColor = BFColor(0xFC940A);
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    self.sureButton.layer.cornerRadius = 5;
    [self.sureButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sureButton];
    
    [super layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.sureButton.frame = CGRectMake(MarginW, CGRectGetMaxY(self.detailInfo.frame), BF_ScaleWidth(290), BF_ScaleHeight(30));

}

/**pickerview代理，改变按钮状态*/
- (void)changeButtonStatus {
    self.bankButton.selected = NO;
    self.provinceButton.selected = NO;
    self.cityButton.selected = NO;
    self.branchButton.selected = NO;
}
//创建label
- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [UILabel labelWithFrame:frame font:BF_ScaleFont(12) textColor:BFColor(0xB3B3B3) text:text];
    return label;
}
//创建button
- (BFBankButton *)setUpButtonWithFrame:(CGRect)frame type:(BFChooseButtonType)type{
    
    BFBankButton *button = [[BFBankButton alloc] initWithFrame:frame];
    // self.bankButton.backgroundColor = [UIColor redColor];
    button.tag = type;
    
    // 指定为拉伸模式，伸缩后重新赋值
    UIImage *image = [UIImage imageNamed:@"pickerView"];
    UIImage *selectImage = [UIImage imageNamed:@"pickerView_select"];
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    selectImage = [selectImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:selectImage forState:UIControlStateSelected];
    button.buttonTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    button.buttonTitle.textColor = BFColor(0x020202);
    [self addSubview:button];
    
    return button;
}

//银行按钮点击
- (void)bankButtonClick:(BFBankButton *)sender {
    sender.selected = !sender.selected;
    [self endEditing:YES];
    self.pickerView = [BFPickerView pickerView];
    self.pickerView.delegate = self;
    self.pickerView.dataArray = @[@"--请选择--", @"中国工商银行", @"中国建设银行", @"交通银行", @"中国农业银行", @"上海浦东发展银行", @"兴业银行", @"中国银行", @"招商银行", @"中信银行"];
    __block typeof(self) weakSelf = self;
    self.pickerView.block = ^(NSString *string) {
        weakSelf.branchButton.buttonTitle.text = @"--请选择--";
        sender.buttonTitle.text = string;
        weakSelf.bankID = string;
        [weakSelf getBranchInfo];
    };
    [self addSubview:self.pickerView];
    
}

//省份按钮点击
- (void)provinceButtonClick:(BFBankButton *)sender {
    sender.selected = !sender.selected;
    [self endEditing:YES];
    self.pickerView = [BFPickerView pickerView];
    self.pickerView.delegate = self;
    self.pickerView.dataArray = self.provinceArray;
    __block typeof(self) weakSelf = self;
    self.pickerView.block = ^(NSString *string) {
        sender.buttonTitle.text = string;
        weakSelf.provinceID = string;
        weakSelf.cityButton.buttonTitle.text = @"--请选择--";
        weakSelf.branchButton.buttonTitle.text = @"--请选择--";
        if (![sender.buttonTitle.text isEqualToString:@"--请选择--"]) {
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSString *object in weakSelf.provinceArray) {
                if (object == string) {
                    NSArray *array = [[[weakSelf.pickerDic objectForKey:string] objectAtIndex:0] allKeys] ;
                    [mutableArray addObjectsFromArray:array];
                }
            }
            [mutableArray insertObject:@"--请选择--" atIndex:0];
            weakSelf.cityArray = [mutableArray copy];
            weakSelf.cityButton.hidden = NO;
            [weakSelf getBranchInfo];
        }else {
            weakSelf.cityButton.hidden = YES;
        }
    };
    [self addSubview:self.pickerView];
    
}

//按城市钮点击
- (void)cityButtonClick:(BFBankButton *)sender {
    sender.selected = !sender.selected;
    [self endEditing:YES];
    self.pickerView = [BFPickerView pickerView];
    self.pickerView.delegate = self;

    self.pickerView.dataArray = self.cityArray;
    //[NSKeyedArchiver archiveRootObject:self.cityArray toFile:self.cityPath];
    __block typeof(self) weakSelf = self;
    self.pickerView.block = ^(NSString *string) {
        weakSelf.branchButton.buttonTitle.text = @"--请选择--";
        sender.buttonTitle.text = string;
        weakSelf.cityID = string;
        [weakSelf getBranchInfo];
    };
    [self addSubview:self.pickerView];
    
}

//支行按钮
- (void)branchButtonClick:(BFBankButton *)sender {
    sender.selected = !sender.selected;
    [self endEditing:YES];
    self.pickerView = [BFPickerView pickerView];
    self.pickerView.delegate = self;
    BFBankModel *bankInfo = [BFUserDefaluts getBankInfo];
    if (self.bankButton.buttonTitle.text.length == 0 || self.provinceButton.buttonTitle.text.length == 0 || self.cityButton.buttonTitle.text.length == 0) {
        self.pickerView.dataArray = @[@"--请选择--", @"其他"];
        __block typeof(self) weakSelf = self;
        self.pickerView.block = ^(NSString *string) {
            sender.buttonTitle.text = string;
            if ([string isEqualToString:@"其他"]) {
                bankInfo.bank_branch = @"999999";
                [BFUserDefaluts modifyBankInfo:bankInfo];
                weakSelf.branchTF.height = BF_ScaleHeight(30);
                weakSelf.detailInfo.frame = CGRectMake(0, CGRectGetMaxY(self.branchTF.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(260));
            }else {
                //[BFUserDefaluts modifyBankInfo:bankInfo];
                weakSelf.branchTF.height = BF_ScaleHeight(0);
                weakSelf.detailInfo.frame = CGRectMake(0, CGRectGetMaxY(self.branchButton.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(260));
                BFLog(@"----%f",CGRectGetMaxY(weakSelf.branchTF.frame));
            }
        };

    }else {
        self.pickerView.dataArray = self.branchArray;
        __block typeof(self) weakSelf = self;
        self.pickerView.block = ^(NSString *string) {
            sender.buttonTitle.text = string;
            NSArray *array = [BFBranchList parse:weakSelf.model.bank];
            for (BFBranchList *list in array) {
                if ([list.name isEqualToString:string]) {
                    weakSelf.branchID = list.ID;
                    BFLog(@"####%@,,,,,%@",list.ID, weakSelf.branchID);
                    //[BFUserDefaluts modifyBankInfo:bankInfo];
                }
            }
            if ([string isEqualToString:@"其他"]) {
                bankInfo.bank_branch = @"999999";
                [BFUserDefaluts modifyBankInfo:bankInfo];
                weakSelf.branchTF.height = BF_ScaleHeight(30);
                weakSelf.branchTF.text = nil;
                weakSelf.detailInfo.frame = CGRectMake(0, CGRectGetMaxY(self.branchTF.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(260));
                //BFLog(@"----%f",CGRectGetMaxY(weakSelf.branchTF.frame));
            }else {
                [BFUserDefaluts modifyBankInfo:bankInfo];
                weakSelf.branchTF.height = BF_ScaleHeight(0);
                weakSelf.detailInfo.frame = CGRectMake(0, CGRectGetMaxY(self.branchButton.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(260));
                //BFLog(@"----%f",CGRectGetMaxY(weakSelf.branchTF.frame));
            }
        };

    }
    [self addSubview:self.pickerView];
    
}

//获取支行信息
- (void)getBranchInfo {
    BFBankModel *bankInfo = [BFUserDefaluts getBankInfo];
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=branch"];
    self.parameter[@"uid"] = self.userInfo.ID;
    self.parameter[@"token"] = self.userInfo.token;
    self.parameter[@"bank"] = self.bankButton.buttonTitle.text;
    self.parameter[@"sheng"] = self.provinceButton.buttonTitle.text;
    self.parameter[@"shi"] = self.cityButton.buttonTitle.text;;
    [BFHttpTool POST:url params:self.parameter success:^(id responseObject) {
        BFLog(@"%@,%@",responseObject, self.parameter);
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            return ;
        }else {
            self.branchArray = nil;
            self.model = [BFBankModel parse:responseObject];
            bankInfo.shi_id = self.model.shi_id;
            bankInfo.bank_id = self.model.bank_id;
            [BFUserDefaluts modifyBankInfo:bankInfo];
            BFLog(@"-----%@,,,,,%@", bankInfo.bank_id, bankInfo.shi_id);
            [BFUserDefaluts modifyBankInfo:self.model];
            NSArray *array = [BFBranchList parse:self.model.bank];
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (BFBranchList *list in array) {
                [mutableArray addObject:list.name];
            }
            [mutableArray insertObject:@"--请选择--" atIndex:0];
            self.branchArray = [mutableArray copy];
        }

        
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
    
}

//确定按钮
- (void)click:(UIButton *)sender {
    [self endEditing:YES];
    
    BFBankModel *bankInfo = [BFUserDefaluts getBankInfo];
    
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=up_username"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = self.userInfo.ID;
    parameter[@"token"] = self.userInfo.token;
    parameter[@"bank_name"] = self.bankButton.buttonTitle.text;
    parameter[@"card_id"] = self.detailInfo.cardNumberTX.text;
    parameter[@"true_name"] = self.detailInfo.nameTX.text;
    if ([self.branchButton.buttonTitle.text isEqualToString:@"其他"]) {
        parameter[@"card_address"] = self.branchTF.text;
    }else {
        parameter[@"card_address"] = self.branchButton.buttonTitle.text;
    }
    parameter[@"bank_id"] = bankInfo.bank_id ? bankInfo.bank_id : self.userInfo.bank_id;
    parameter[@"bank_city"] = bankInfo.shi_id ? bankInfo.shi_id : self.userInfo.bank_city;
    parameter[@"bank_branch"] = self.branchID;
    
    BFLog(@"======%@,,,,,%@,,,,,", bankInfo.bank_branch, self.userInfo.bank_branch);
    if ([self.branchButton.buttonTitle.text isEqualToString:@"--请选择--"] || [self.bankButton.buttonTitle.text isEqualToString:@"--请选择--"] || [self.provinceButton.buttonTitle.text isEqualToString:@"--请选择--"] || [self.cityButton.buttonTitle.text isEqualToString:@"--请选择--"] || self.detailInfo.cardNumberTX.text.length == 0 || self.detailInfo.nameTX.text.length == 0) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请完善信息"];
    }else if(![HZQRegexTestter validateBankCardNumber:self.detailInfo.cardNumberTX.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的银行卡号"];
    }else if(![HZQRegexTestter validateRealName:self.detailInfo.nameTX.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的开户人名字"];
    }else if([self.branchButton.buttonTitle.text isEqualToString:@"其他"]){
        if (self.branchTF.text.length == 0) {
            [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请完善信息"];
        }else {
            if (![HZQRegexTestter validateChineseCharacter:self.branchTF.text]) {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确支行名称"];
            }else {
                [self modifyInfo:url parameter:parameter];
            }
        }
    }else {
        [self modifyInfo:url parameter:parameter];
    }
    
}

- (void)modifyInfo:(NSString *)url parameter:(NSMutableDictionary *)parameter {
    [BFProgressHUD MBProgressWithLabelText:@"正在修改银行信息" dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"%@,%@",responseObject,parameter);
            if (![responseObject[@"msg"] isEqualToString:@"修改成功"]) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self wrongLabelText:@"银行信息修改失败"];
            }else {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self LabelText:@"银行信息修改成功,正在跳转..." dispatch_get_main_queue:^{
                    if (self.delegate && [self.delegate respondsToSelector:@selector(modifyBankInfomation)]) {
                        
                        
                        self.userInfo.bank_name = self.bankButton.buttonTitle.text;
                        self.userInfo.sheng = self.provinceButton.buttonTitle.text;
                        self.userInfo.shi = self.cityButton.buttonTitle.text;
                        self.userInfo.card_address = [self.branchButton.buttonTitle.text isEqualToString:@"其他"] ? self.branchTF.text : self.branchButton.buttonTitle.text;
                        self.userInfo.card_id = self.detailInfo.cardNumberTX.text;
                        self.userInfo.true_name = self.detailInfo.nameTX.text;
                        self.userInfo.bank_branch = parameter[@"bank_branch"];
                        [BFUserDefaluts modifyUserInfo:self.userInfo];
                        [self.delegate modifyBankInfomation];
                    }
                }];
            }
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressOnlyWithLabelText:@"网络异常"];
            BFLog(@"%@",error);
        }];
    }];
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.branchTF resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
