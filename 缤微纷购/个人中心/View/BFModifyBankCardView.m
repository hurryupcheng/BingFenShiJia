//
//  BFModifyBankCardView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFModifyBankCardView.h"
#import "BFBankButton.h"
#import "BFPickerView.h"
#import "BFBankModel.h"
@interface BFModifyBankCardView()<BFPickerViewDelegate>
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
/**省份数组*/
@property (nonatomic, strong) NSArray *provinceArray;
/**城市数组*/
@property (nonatomic, strong) NSArray *cityArray;
/**支行数组*/
@property (nonatomic, strong) NSArray *branchArray;
/**银行ID*/
@property (nonatomic, strong) NSString *bankID;
/**省份ID*/
@property (nonatomic, strong) NSString *provinceID;
/**城市ID*/
@property (nonatomic, strong) NSString *cityID;
@end

@implementation BFModifyBankCardView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xF4F4F4);
        self.backgroundColor = [UIColor whiteColor];
        [self getData];
        //创建
        [self setUpView];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, 800)];
        view.backgroundColor = [UIColor redColor];
        [self addSubview:view];
        self.cityButton.hidden = YES;
        BFLog(@"======%@,,%@,,%@",self.bankID,self.provinceID,self.cityID);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=username"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"responseObject%@,,,%@,,,%@",responseObject,userInfo.ID,userInfo.token);
        NSArray *bArray = responseObject[@"banner"];
        NSMutableArray *bmutalArray = [NSMutableArray array];
        for (NSDictionary *dic in bArray) {
            BFBankModel *bankModel = [BFBankModel parse:dic];
            [bmutalArray addObject:bankModel];
        }
        self.bankArray = [bmutalArray copy];
        
        NSArray *pArray = responseObject[@"sheng"];
        NSMutableArray *pmutalArray = [NSMutableArray array];
        for (NSDictionary *dic in pArray) {
            BFBankModel *bankModel = [BFBankModel parse:dic];
            [pmutalArray addObject:bankModel];
        }
        self.provinceArray = [pmutalArray copy];

        
        
    } failure:^(NSError *error) {
        BFLog(@"error%@",error);
    }];
    
}

- (void)setUpView {
    //银行网点
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    UILabel *bankBranch = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(30), BF_ScaleHeight(5), BF_ScaleWidth(100), BF_ScaleHeight(15)) text:@"银行网点："];
    
    //银行
    UILabel *bank = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(30), CGRectGetMaxY(bankBranch.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), BF_ScaleHeight(20)) text:@"银行："];
    bank.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    
    //地区
    UILabel *area = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(30), CGRectGetMaxY(bank.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), BF_ScaleHeight(20)) text:@"地区："];
    area.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    
    //支行
    UILabel *branch = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(30), CGRectGetMaxY(area.frame)+BF_ScaleHeight(10), BF_ScaleWidth(40), BF_ScaleHeight(20)) text:@"支行："];
    branch.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    
    self.bankButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(bank.frame), bank.y,BF_ScaleWidth(130), bank.height) type:BFChooseButtonTypeBank];
    self.bankButton.buttonTitle.text = userInfo.bank_name ? userInfo.bank_name : @"-- 请选择 -- ";
    
    self.provinceButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(area.frame), area.y, BF_ScaleWidth(80), bank.height) type:BFChooseButtonTypeProvince];
    
    self.cityButton = [self setUpButtonWithFrame:CGRectMake(CGRectGetMaxX(self.provinceButton.frame)+BF_ScaleWidth(10), area.y, BF_ScaleWidth(80), bank.height) type:BFChooseButtonTypeCity];
    
}

- (void)click:(BFBankButton *)sender {
    sender.selected = !sender.selected;
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    BFPickerView *bankPicker = [BFPickerView pickerView];
    bankPicker.delegate = self;
    switch (sender.tag) {
        case BFChooseButtonTypeBank:{
            bankPicker.dataArray = self.bankArray;
            bankPicker.block = ^(NSString *string) {
                BFLog(@"BFChooseButtonTypeProvince%@",string);
                sender.buttonTitle.text = string;
                NSString *userID = nil;
                for (BFBankModel *model in self.bankArray) {
                    if ([model.name isEqualToString:string]) {
                        self.bankID = model.ID;
                    }
                }
                BFLog(@"BFChooseButtonTypeProvince%@,,%@",string,self.bankID);
                sender.selected = NO;
            };
            break;
        }
        case BFChooseButtonTypeProvince:{
            bankPicker.dataArray = self.provinceArray;
            bankPicker.block = ^(NSString *string) {
                sender.buttonTitle.text = string;
                NSString *userID = nil;
                for (BFBankModel *model in self.provinceArray) {
                    if ([model.name isEqualToString:string]) {
                        self.provinceID = model.ID;
                    }
                }
                self.cityButton.hidden = YES;
                
                
                NSString *cityUrl = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=shi"];
                NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
                parameter[@"uid"] = userInfo.ID;
                parameter[@"token"] = userInfo.token;
                parameter[@"sheng_id"] = self.provinceID;
                [BFHttpTool GET:cityUrl params:parameter success:^(id responseObject) {
                    BFLog(@"cityUrl%@",responseObject);
                    NSArray *cArray = responseObject[@"shi"];
                    NSMutableArray *cMutable = [NSMutableArray array];
                    if (![cArray isKindOfClass:[NSNull class]]) {
                        for (NSDictionary *dic in cArray) {
                            BFBankModel *cityModel = [BFBankModel parse:dic];
                            [cMutable addObject:cityModel];
                        }
                        self.cityArray = [cMutable copy];
                    }
                    
                } failure:^(NSError *error) {
                    BFLog(@"error%@",error);
                }];
                
                BFLog(@"BFChooseButtonTypeProvince%@,,%@",string,self.provinceID);
                sender.selected = NO;            };
            break;
        }
        case BFChooseButtonTypeCity:{
            bankPicker.dataArray = self.cityArray;
            bankPicker.block = ^(NSString *string) {
                BFLog(@"BFChooseButtonTypeCity%@",string);
                sender.buttonTitle.text = string;
                NSString *userID = nil;
                for (BFBankModel *model in self.cityArray) {
                    if ([model.name isEqualToString:string]) {
                        self.cityID = model.ID;
                    }
                }
                BFLog(@"BFChooseButtonTypeCity%@,,%@",string,self.cityID);
                sender.selected = NO;
            };
            break;
        }

    }
    
    BFLog(@"------>%@,,%@,,%@",self.bankID,self.provinceID,self.cityID);
    [self addSubview:bankPicker];
    NSString *branchUrl = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=branch"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"sheng_id"] = self.bankID;
    parameter[@"shi_id"] = self.provinceID;
    parameter[@"bank_id"] = self.cityID;
    [BFHttpTool GET:branchUrl params:parameter success:^(id responseObject) {
        BFLog(@"branchUrl%@",responseObject);
       
    } failure:^(NSError *error) {
        BFLog(@"error%@",error);
    }];

    
  
}

- (void)changeButtonStatus {
    self.bankButton.selected = NO;
    self.provinceButton.selected = NO;
}
//创建label
- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [UILabel labelWithFrame:frame font:BF_ScaleFont(14) textColor:BFColor(0xB3B3B3) text:text];
    [self addSubview:label];
    return label;
}
//创建button
- (BFBankButton *)setUpButtonWithFrame:(CGRect)frame type:(BFChooseButtonType)type{
    
    BFBankButton *button = [[BFBankButton alloc] initWithFrame:frame];
    // self.bankButton.backgroundColor = [UIColor redColor];
    button.tag = type;
    [button setBackgroundImage:[UIImage imageNamed:@"pickerView"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"pickerView_select"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

@end
