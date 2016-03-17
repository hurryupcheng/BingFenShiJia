//
//  BFAddAddressController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAddAddressController.h"
#import "BFAddAddressView.h"
@interface BFAddAddressController ()
/**自定义的view*/
@property (nonatomic, strong) BFAddAddressView *addView;
@end

@implementation BFAddAddressController


- (BFAddAddressView *)addView {
    if (!_addView) {
        _addView = [BFAddAddressView creatView];
        [self.view addSubview:_addView];
    }
    return _addView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建地址";
    //添加自定义的view
    [self addView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
