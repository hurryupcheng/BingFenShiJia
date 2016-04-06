//
//  BFModifyBankCardView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define Height  BF_ScaleHeight(20)

#import "BFModifyBankCardView.h"
#import "BFBankButton.h"
#import "BFPickerView.h"
#import "BFBankModel.h"
@interface BFModifyBankCardView()<BFPickerViewDelegate>
@property (nonatomic, strong) BFPickerView *pickerView;
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
/**请求数据*/
@property (nonatomic, strong) NSMutableDictionary *parameter;
@end

@implementation BFModifyBankCardView

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
    self.provinceArray = [self.pickerDic allKeys];
}




- (void)setUpView {
    //银行网点
    UILabel *bankBranch = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(30), BF_ScaleHeight(5), BF_ScaleWidth(100), BF_ScaleHeight(15)) text:@"银行网点："];
    
    //银行
    UILabel *bank = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(30), CGRectGetMaxY(bankBranch.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), Height) text:@"银行："];
    [self addSubview:bank];
    
    //地区
    UILabel *area = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(30), CGRectGetMaxY(bank.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), Height) text:@"地区："];
    [self addSubview:area];
    
    //支行
    UILabel *branch = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(30), CGRectGetMaxY(area.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), Height) text:@"支行："];
    [self addSubview:branch];
    
    self.bankButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(bank.frame), bank.y,BF_ScaleWidth(130), Height) type:BFChooseButtonTypeBank];
    [self.bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.provinceButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(area.frame), area.y, BF_ScaleWidth(80), Height) type:BFChooseButtonTypeProvince];
    [self.provinceButton addTarget:self action:@selector(provinceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cityButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.provinceButton.frame)+BF_ScaleWidth(10), area.y, BF_ScaleWidth(80), Height) type:BFChooseButtonTypeCity];
    self.cityButton.hidden = YES;
    [self.cityButton addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.branchButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(branch.frame), branch.y, BF_ScaleWidth(200), Height) type:BFChooseButtonTypeBranch];
    [self.branchButton addTarget:self action:@selector(branchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    [button setBackgroundImage:[UIImage imageNamed:@"pickerView"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"pickerView_select"] forState:UIControlStateSelected];
    button.buttonTitle.text =@"--请选择--";
    button.buttonTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    button.buttonTitle.textColor = BFColor(0x020202);
    [self addSubview:button];
    
    return button;
}

//银行按钮点击
- (void)bankButtonClick:(BFBankButton *)sender {
    sender.selected = !sender.selected;
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
            weakSelf.cityArray = [[[weakSelf.pickerDic objectForKey:string] objectAtIndex:0] allKeys] ;
            weakSelf.cityButton.hidden = NO;
            [weakSelf getBranchInfo];
        }
    };
    [self addSubview:self.pickerView];
    
}

//按城市钮点击
- (void)cityButtonClick:(BFBankButton *)sender {
    sender.selected = !sender.selected;
    self.pickerView = [BFPickerView pickerView];
    self.pickerView.delegate = self;
    self.pickerView.dataArray = self.cityArray;
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
    self.pickerView = [BFPickerView pickerView];
    self.pickerView.delegate = self;
    if (self.bankID.length == 0 || self.provinceID.length == 0 || self.cityID.length == 0) {
        self.pickerView.dataArray = @[@"--请选择--", @"其他"];
        self.pickerView.block = ^(NSString *string) {
            sender.buttonTitle.text = string;
        };

    }else {
        self.pickerView.dataArray = self.branchArray;
        self.pickerView.block = ^(NSString *string) {
            sender.buttonTitle.text = string;
        };

    }

    [self addSubview:self.pickerView];
    
}

//获取支行信息
- (void)getBranchInfo {
     BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=branch"];
    self.parameter[@"uid"] = userInfo.ID;
    self.parameter[@"token"] = userInfo.token;
    self.parameter[@"bank"] = self.bankID;
    self.parameter[@"sheng"] = self.provinceID;
    self.parameter[@"shi"] = self.cityID;
    [BFHttpTool POST:url params:self.parameter success:^(id responseObject) {
        BFLog(@"%@,%@",responseObject, self.parameter);
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            return ;
        }else {
            NSArray *array = [BFBankModel parse:responseObject[@"bank"]];
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (BFBankModel *model in array) {
                [mutableArray addObject:model.name];
            }
            self.branchArray = [mutableArray copy];
            //BFLog(@"%@",self.branchArray);
        }

        
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
    
}

@end
