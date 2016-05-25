//
//  BFAddAddressController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAddAddressController.h"
#import "BFAddAddressView.h"

@interface BFAddAddressController ()<BFAddAddressViewDelegate>
/**自定义的view*/
@property (nonatomic, strong) BFAddAddressView *addView;
@end

@implementation BFAddAddressController


- (BFAddAddressView *)addView {
    if (!_addView) {
        _addView = [BFAddAddressView creatView];
        _addView.delegate = self;
        [self.view addSubview:_addView];
    }
    return _addView;
}
#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建地址";
    //添加自定义的view
    [self addView];
}
#pragma mark --BFAddAddressView代理
- (void)goBackToAddressView {
    [BFNotificationCenter postNotificationName:@"refreshAddress" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
