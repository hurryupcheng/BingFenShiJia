//
//  BFAddAddressView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define CellHeight  BF_ScaleHeight(44)
#define Margin  BF_ScaleHeight(10)
#import "BFAddAddressView.h"
#import "AddressPickView.h"
#import "HZQRegexTestter.h"

@interface BFAddAddressView()<UITextFieldDelegate>
/**收货人*/
@property (nonatomic, strong) UITextField *consignee;
/**详细地址*/
@property (nonatomic, strong) UITextField *detailAddress;
/**联系方式*/
@property (nonatomic, strong) UITextField *phone;
/**地址类型*/
@property (nonatomic, strong) UITextField *category;
/**分区*/
@property (nonatomic, strong) UILabel *selectArea;
/**开关*/
@property (nonatomic, strong) NSString *defaultNumber;
/**省*/
@property (nonatomic, strong) NSString *province;
/**市*/
@property (nonatomic, strong) NSString *city;
/**区*/
@property (nonatomic, strong) NSString *area;
@end

@implementation BFAddAddressView

+ (instancetype)creatView {
    BFAddAddressView *view = [[BFAddAddressView alloc] init];
    return view;
}

- (id) init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = BFColor(0xF2F4F5);
        [self setView];
    }
    return self;
}

- (void)setView {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(15), ScreenWidth, BF_ScaleHeight(264))];
    bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:bottomView];
    
    
    UILabel *consigneeLabel = [self setUpLabelWithTitle:@"收货人"];
    consigneeLabel.frame = CGRectMake(Margin, 0, BF_ScaleWidth(80), CellHeight);
    [bottomView addSubview:consigneeLabel];
    
    UIView *firstLine = [self setUpLine];
    firstLine.frame = CGRectMake(0, CGRectGetMaxY(consigneeLabel.frame)-0.5, ScreenWidth, 0.5);
    [bottomView addSubview:firstLine];
    
    UILabel *areaChooseLabel = [self setUpLabelWithTitle:@"区域选择"];
    areaChooseLabel.frame = CGRectMake(consigneeLabel.x, CGRectGetMaxY(consigneeLabel.frame), consigneeLabel.width, consigneeLabel.height);
    [bottomView addSubview:areaChooseLabel];
    
    UIView *secondLine = [self setUpLine];
    secondLine.frame = CGRectMake(0, CGRectGetMaxY(areaChooseLabel.frame)-0.5, ScreenWidth, 0.5);
    [bottomView addSubview:secondLine];
    
    UILabel *detailAddressLabel = [self setUpLabelWithTitle:@"详细地址"];
    detailAddressLabel.frame = CGRectMake(consigneeLabel.x, CGRectGetMaxY(areaChooseLabel.frame), consigneeLabel.width, consigneeLabel.height);
    [bottomView addSubview:detailAddressLabel];
    
    UIView *thirdLine = [self setUpLine];
    thirdLine.frame = CGRectMake(0, CGRectGetMaxY(detailAddressLabel.frame)-0.5, ScreenWidth, 0.5);
    [bottomView addSubview:thirdLine];
    
    UILabel *contactInformationLabel = [self setUpLabelWithTitle:@"联系方式"];
    contactInformationLabel.frame = CGRectMake(consigneeLabel.x, CGRectGetMaxY(detailAddressLabel.frame), consigneeLabel.width, consigneeLabel.height);
    [bottomView addSubview:contactInformationLabel];
    
    UIView *foruthLine = [self setUpLine];
    foruthLine.frame = CGRectMake(0, CGRectGetMaxY(contactInformationLabel.frame)-0.5, ScreenWidth, 0.5);
    [bottomView addSubview:foruthLine];
    
    UILabel *addressTypeLabel = [self setUpLabelWithTitle:@"地址类型"];
    addressTypeLabel.frame = CGRectMake(consigneeLabel.x, CGRectGetMaxY(contactInformationLabel.frame), consigneeLabel.width, consigneeLabel.height);
    [bottomView addSubview:addressTypeLabel];
    
    UIView *fifthLine = [self setUpLine];
    fifthLine.frame = CGRectMake(0, CGRectGetMaxY(addressTypeLabel.frame)-0.5, ScreenWidth, 0.5);
    [bottomView addSubview:fifthLine];
    
    UILabel *setDefaultAddressLabel = [self setUpLabelWithTitle:@"设置默认地址"];
    setDefaultAddressLabel.frame = CGRectMake(consigneeLabel.x, CGRectGetMaxY(addressTypeLabel.frame), consigneeLabel.width, consigneeLabel.height);
    [bottomView addSubview:setDefaultAddressLabel];
    
    UIView *sixthLine = [self setUpLine];
    sixthLine.frame = CGRectMake(0, CGRectGetMaxY(setDefaultAddressLabel.frame)-0.5, ScreenWidth, 0.5);
    [bottomView addSubview:sixthLine];
    
    
    UITextField *consignee = [[UITextField alloc] initWithFrame:CGRectMake(BF_ScaleWidth(160), 0, BF_ScaleWidth(150), CellHeight)];
    self.consignee = consignee;
    consignee.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    consignee.textAlignment = NSTextAlignmentRight;
    consignee.delegate = self;
    consignee.returnKeyType = UIReturnKeyDone;
    //consignee.backgroundColor = [UIColor greenColor];
    [bottomView addSubview:consignee];
    
    UILabel *selectArea = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(90), CGRectGetMaxY(consignee.frame), BF_ScaleWidth(220), CellHeight)];
    self.selectArea = selectArea;
    selectArea.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    selectArea.userInteractionEnabled = YES;
    selectArea.textAlignment = NSTextAlignmentRight;
    //selectArea.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToChooseArea)];
    [selectArea addGestureRecognizer:tap];
    [bottomView addSubview:selectArea];
    
    UITextField *detailAddress = [[UITextField alloc] initWithFrame:CGRectMake(BF_ScaleWidth(100), CGRectGetMaxY(selectArea.frame), BF_ScaleWidth(210), CellHeight)];
    self.detailAddress = detailAddress;
    detailAddress.delegate = self;
    detailAddress.returnKeyType = UIReturnKeyDone;
    detailAddress.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    detailAddress.textAlignment = NSTextAlignmentRight;
    //detailAddress.backgroundColor = [UIColor blueColor];
    [bottomView addSubview:detailAddress];
    
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(BF_ScaleWidth(100), CGRectGetMaxY(detailAddress.frame), BF_ScaleWidth(210), CellHeight)];
    self.phone = phone;
    phone.delegate = self;
    phone.returnKeyType = UIReturnKeyDone;
    phone.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    phone.textAlignment = NSTextAlignmentRight;
    //phone.backgroundColor = [UIColor greenColor];
    [bottomView addSubview:phone];
    
    UITextField *category = [[UITextField alloc] initWithFrame:CGRectMake(BF_ScaleWidth(100), CGRectGetMaxY(phone.frame), BF_ScaleWidth(210), CellHeight)];
    self.category = category;
    category.delegate = self;
    category.returnKeyType = UIReturnKeyDone;
    category.textAlignment = NSTextAlignmentRight;
    category.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    category.placeholder = @"家/公司/其他";
    //category.backgroundColor = [UIColor redColor];
    [bottomView addSubview:category];
    
    
    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(BF_ScaleWidth(310)-51, CGRectGetMaxY(category.frame)+(CellHeight-31)/2, 51, 31)];
    [switchButton setOn:NO];
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [bottomView addSubview:switchButton];
    
    UIButton *saveButton = [UIButton buttonWithType:0];
    saveButton.frame = CGRectMake(BF_ScaleWidth(80), CGRectGetMaxY(bottomView.frame)+BF_ScaleHeight(20), BF_ScaleWidth(160), BF_ScaleHeight(30));
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.backgroundColor = BFColor(0xFA8728);
    saveButton.layer.cornerRadius = BF_ScaleHeight(15);
    [saveButton addTarget:self action:@selector(cliclToSaveAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveButton];
}


- (void)clickToChooseArea {
    [self endEditing:YES];
    BFLog(@"点击选择城市");
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        self.selectArea.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        self.province = province;
        self.city = city;
        self.area = town;
        
    };

}

- (void)cliclToSaveAddress:(UIButton *)sender {
    [self endEditing:YES];
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=user_address"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"sheng"] = self.province;
    parameter[@"shi"] = self.city;
    parameter[@"qu"] = self.area;
    parameter[@"adress"] = self.detailAddress.text;
    parameter[@"tel"] = self.phone.text;
    parameter[@"nice_name"] = self.consignee.text;
    parameter[@"default"] = self.defaultNumber;
    if ([self.category.text isEqualToString:@"公司"]) {
        parameter[@"type"] = @"1";
    }else if ([self.category.text isEqualToString:@"家"]) {
        parameter[@"type"] = @"0";
    }else  {
        parameter[@"type"] = @"2";
    }
    BFLog(@"%@,",parameter);
    if (self.consignee.text.length == 0 || self.selectArea.text.length == 0 || self.detailAddress.text.length == 0 || self.phone.text.length == 0 ) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请完善资料"];
    }else if (![HZQRegexTestter validateRealName:self.consignee.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入真名"];
    }else if (![HZQRegexTestter validatePhone:self.phone.text]) {
        [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"请输入正确的手机号"];
    }else {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"添加成功"]) {
                [BFProgressHUD MBProgressFromView:self LabelText:@"添加地址成功,正在跳转" dispatch_get_main_queue:^{
                    if (self.delegate && [self.delegate respondsToSelector:@selector(goBackToAddressView)]) {
                        [self.delegate goBackToAddressView];
                    }
                }];
            }else {
                [BFProgressHUD MBProgressFromView:self onlyWithLabelText:@"添加失败"];
            }
            BFLog(@"%@",responseObject);
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self andLabelText:@"网络问题"];
            BFLog(@"%@",error);
        }];
    }
    
   
}

- (void)switchAction:(UISwitch *)sender {
    [self endEditing:YES];
    if (sender.isOn) {
        self.defaultNumber = @"1";
        BFLog(@"是的");
    }else {
        self.defaultNumber = @"0";
        BFLog(@"不是");
    }
}

- (UILabel *)setUpLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = BFColor(0x363839);
    //label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    return label;
}
- (UIView *)setUpLine {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BFColor(0xE0E1E1);
    return line;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.consignee resignFirstResponder];
    [self.detailAddress resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.category resignFirstResponder];
    return YES;
}



@end
