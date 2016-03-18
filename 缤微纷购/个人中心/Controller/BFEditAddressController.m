//
//  BFEditAddressController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFEditAddressController.h"
#import "BFEditAddressView.h"
@interface BFEditAddressController ()<BFEditAddressViewDelegate>
/**自定义的view*/
@property (nonatomic, strong) BFEditAddressView *editView;

@end

@implementation BFEditAddressController

- (BFEditAddressView *)editView {
    if (!_editView) {
        _editView = [BFEditAddressView creatView];
        _editView.delegate = self;
        _editView.model = self.model;
        [self.view addSubview:_editView];
    }
    return _editView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址";
    //添加自定义的view
    [self editView];
    //添加导航栏按钮
    [self setNavigationBar];
    BFLog(@"%@",self.model);
}
#pragma mark --BFEditAddressViewDelegate
- (void)clickToGoBackToAddressController{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --设置导航栏
- (void)setNavigationBar {
    UIButton *deleteButton = [UIButton buttonWithType:0];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:BFColor(0x00006F) forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    deleteButton.frame = CGRectMake(0, 0, BF_ScaleWidth(50), 30);
    [deleteButton addTarget:self action:@selector(clickToDeleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteButton];
    
}


- (void)clickToDeleteAddress:(UIButton *)sender {
    BFLog(@"点击");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除收货地址" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        BFLog(@"点击取消");
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BFLog(@"点击确定");
    }];
    
    [alertController addAction:cancle];
    [alertController addAction:sure];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark --BFAddAddressView代理
- (void)goBackToAddressView {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
