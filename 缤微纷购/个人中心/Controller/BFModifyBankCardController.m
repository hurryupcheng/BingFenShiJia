//
//  BFModifyBankCardController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFModifyBankCardController.h"
#import "BFModifyBankCardView.h"

@interface BFModifyBankCardController ()
/**自定义修改银行卡view*/
@property (nonatomic, strong) BFModifyBankCardView *modifyView;
@end

@implementation BFModifyBankCardController


- (BFModifyBankCardView *)modifyView {
    if (!_modifyView) {
        _modifyView = [[BFModifyBankCardView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_modifyView];
    }
    return _modifyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改银行卡";
    //添加自定义View
    [self modifyView];
}




@end
