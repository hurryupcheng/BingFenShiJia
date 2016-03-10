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
@interface BFModifyBankCardView()
/**银行button*/
@property (nonatomic, strong) BFBankButton *bankButton;
/**省份button*/
@property (nonatomic, strong) BFBankButton *provinceButton;
/**城市button*/
@property (nonatomic, strong) BFBankButton *cityButton;
/**支行button*/
@property (nonatomic, strong) BFBankButton *branchButton;
@end

@implementation BFModifyBankCardView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xF4F4F4);
        //创建
        [self setUpView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setUpView {
    //银行网点
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
    
    self.bankButton = [[BFBankButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bank.frame), bank.x,BF_ScaleWidth(100), bank.height)];
   // self.bankButton.backgroundColor = [UIColor redColor];
    [self.bankButton setBackgroundImage:[UIImage imageNamed:@"pickerView"] forState:UIControlStateNormal];
    [self.bankButton setBackgroundImage:[UIImage imageNamed:@"pickerView_select"] forState:UIControlStateSelected];
    if (self.bankButton.selected == NO) {
        self.bankButton.buttonTitle.text = @"--请选择--";
        
    }else {
        self.bankButton.buttonTitle.text = @"--haha--";
        
    }
    
    [self.bankButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.bankButton];
    
}

- (void)click:(BFBankButton *)sender {
    sender.selected = !sender.selected;
    BFPickerView *bankPicker = [BFPickerView pickerView];
    bankPicker.dataArray = @[@"123",@"123",@"123",@"123",@"123"];
    [self addSubview:bankPicker];
    bankPicker.block = ^(NSString *string) {
        sender.buttonTitle.text = string;
        sender.selected = NO;
    };

    BFLog(@"123");
}


- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [UILabel labelWithFrame:frame font:BF_ScaleFont(14) textColor:BFColor(0xB3B3B3) text:text];
    [self addSubview:label];
    return label;
}

@end
