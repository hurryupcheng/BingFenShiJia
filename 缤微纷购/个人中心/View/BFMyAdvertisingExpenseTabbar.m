//
//  BFMyAdvertisingExpenseTabbar.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyAdvertisingExpenseTabbar.h"

@interface BFMyAdvertisingExpenseTabbar()
/**本月佣金*/
@property (nonatomic, strong) UILabel *commissionLabel;

@end

@implementation BFMyAdvertisingExpenseTabbar



- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowColor = BFColor(0x000000).CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        [self setUpTabbar];
    }
    return self;
}

- (void)setCommissionModel:(BFCommissionModel *)commissionModel {
    _commissionModel = commissionModel;
    if (commissionModel) {
        self.commissionLabel.text = [NSString stringWithFormat:@"本月总佣金：¥%@",commissionModel.proxy_order_money];
    }
}

- (void)setUpTabbar{

    
    self.commissionLabel = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(240), 46) font:BF_ScaleFont(16) textColor:BFColor(0x000000) text:@"本月总佣金：¥0.60"];
    [self addSubview:self.commissionLabel];
    
    UIButton *raiseCashButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(250), BF_ScaleHeight(5), BF_ScaleWidth(60), 46-BF_ScaleHeight(10)) title:@"如何体现" image:nil font:BF_ScaleFont(12) titleColor:BFColor(0xffffff)];
    raiseCashButton.layer.cornerRadius = 3;
    raiseCashButton.backgroundColor = BFColor(0x102D97);
    [raiseCashButton addTarget:self action:@selector(howToGetCash) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:raiseCashButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)howToGetCash {
    BFLog(@"如何提现");
}

@end
