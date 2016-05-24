//
//  BFCountView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFCountView.h"
#import "HZQRegexTestter.h"

@interface BFCountView()<UITextFieldDelegate>

@end

@implementation BFCountView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setModel:(BFProductDetialModel *)model {
    _model = model;
    if (model) {
        UIButton *decrease = [UIButton buttonWithType:0];
        decrease.frame = CGRectMake(0, 0, BF_ScaleWidth(30), BF_ScaleHeight(30));
        [decrease setImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
        [decrease setImage:[UIImage imageNamed:@"jian_hui"] forState:UIControlStateHighlighted];
        [decrease addTarget:self action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:decrease];
        
        UIButton *increase = [UIButton buttonWithType:0];
        increase.frame = CGRectMake(BF_ScaleWidth(60), 0, BF_ScaleWidth(30), BF_ScaleHeight(30));
        [increase addTarget:self action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
        [increase setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        [increase setImage:[UIImage imageNamed:@"jia_hui"] forState:UIControlStateHighlighted];
        [self addSubview:increase];
        
        self.countTX = [[UITextField alloc] initWithFrame:CGRectMake(BF_ScaleWidth(30), 0, BF_ScaleWidth(30), BF_ScaleHeight(30))];
        if ([model.first_stock isEqualToString:@"0"]) {
            self.countTX.text = @"0";
        }else {
            self.countTX.text = @"1";
        }
        self.countTX.returnKeyType = UIReturnKeyDone;
        self.countTX.delegate = self;
        self.countTX.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        self.countTX.textAlignment = NSTextAlignmentCenter;
        self.countTX.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //[self.countTX addTarget:self action:@selector(change:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.countTX];

    }
}

- (void)setView {
    
    }

//减
- (void)decrease {
    if (self.countTX.text.length == 0) {
        self.countTX.text = @"1";
    }
    NSInteger new = [self.countTX.text integerValue] - 1;
    if (new > 0) {
        self.countTX.text = [NSString stringWithFormat:@"%ld", (long)new];
    }else {
       [BFProgressHUD MBProgressOnlyWithLabelText:@"数量超出库存"];
    }
}

//加
- (void)increase {

    NSInteger new = [self.countTX.text integerValue] + 1;
    if (new > [self.model.first_stock integerValue]) {
        [BFProgressHUD MBProgressOnlyWithLabelText:@"数量超出库存"];
    }else {
        self.countTX.text = [NSString stringWithFormat:@"%ld", (long)new];
    }
    
    


}
//- (void)change:(UITextField *)textField {
//    if (![HZQRegexTestter validateIntegerNumber:self.countTX.text]) {
//        [BFProgressHUD MBProgressOnlyWithLabelText:@"请输入正确的数量"];
//        if ([self.model.first_stock integerValue] > 0) {
//            self.countTX.text = @"1";
//        }else {
//            self.countTX.text = @"0";
//        }
//    }
//}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger new = [self.countTX.text integerValue];
    BFStorage *stor = [[CXArchiveShopManager sharedInstance]screachDataSourceWithItem:self.model.ID];
    if (![HZQRegexTestter validateIntegerNumber:self.countTX.text]) {
        [BFProgressHUD MBProgressOnlyWithLabelText:@"请输入正确的数量"];
        self.countTX.text = @"1";
    }else {
        if ([self.model.first_stock integerValue] > 0) {
            if (new > [self.model.first_stock integerValue] - stor.numbers) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"数量超出库存"];
                self.countTX.text = [NSString stringWithFormat:@"%ld", [self.model.first_stock integerValue] - stor.numbers];
            }else if (new < 1) {
                [BFProgressHUD MBProgressOnlyWithLabelText:@"数量超出库存"];
                self.countTX.text = @"1";
            }
        }else {
            self.countTX.text = @"0";
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.countTX resignFirstResponder];
    return YES;
}



@end
