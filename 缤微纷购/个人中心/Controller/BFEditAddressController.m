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

}
#pragma mark --BFEditAddressViewDelegate
- (void)clickToSaveAddress{
    [BFNotificationCenter postNotificationName:@"refreshAddress" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickToDeleteAddress {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除收货地址" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        BFLog(@"点击取消");
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BFProgressHUD MBProgressWithLabelText:@"正在删除地址..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
            BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
            NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=del_address"];
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            parameter[@"uid"] = userInfo.ID;
            parameter[@"token"] = userInfo.token;
            parameter[@"id"] = self.model.ID;
            BFLog(@"%@,",parameter);
            [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                BFLog(@"%@",responseObject);
                if ([responseObject[@"msg"] isEqualToString:@"删除成功"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.view LabelText:@"删除成功,正在跳转..." dispatch_get_main_queue:^{
                        [BFNotificationCenter postNotificationName:@"refreshAddress" object:nil];

                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"删除失败,请重新操作"];
                }
                
            } failure:^(NSError *error) {
                BFLog(@"%@",error);
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
            }];

        }];
        
    }];
    
    [alertController addAction:cancle];
    [alertController addAction:sure];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
