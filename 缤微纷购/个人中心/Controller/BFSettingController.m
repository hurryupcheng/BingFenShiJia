//
//  BFSettingController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFSettingController.h"

@interface BFSettingController ()<UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BFSettingController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"设置";
    [self.view addSubview:self.tableView];
    //设置底部按钮视图
    [self setBottomView];
}

#pragma mark -- 退出按钮视图
- (void)setBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-BF_ScaleHeight(50)-64, ScreenWidth, BF_ScaleHeight(50))];
    bottomView.backgroundColor = BFColor(0xffffff);
    [self.view addSubview:bottomView];
    
    UIButton *exitButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(80), BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(160), BF_ScaleHeight(30)) title:@"退出登录" image:nil font:BF_ScaleFont(14) titleColor:BFColor(0xffffff)];
    exitButton.layer.cornerRadius = BF_ScaleHeight(15);
    exitButton.backgroundColor = BFColor(0xFD8727);
    [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:exitButton];
}

- (void)exit {
    [BFProgressHUD MBProgressFromWindowWithLabelText:@"退出登录" dispatch_get_main_queue:^{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserInfo"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];

    BFLog(@"点击退出");
}
#pragma mark --- datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 3;
    }else if (section == 2) {
        return 3;
    }else {
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    cell.detailTextLabel.textColor = BFColor(0x000073);
    cell.detailTextLabel.text = nil;
    if (indexPath.section == 0) {
 
        cell.textLabel.text = @"联系客服";
        cell.detailTextLabel.text = @"020-38875719";
        if (cell.detailTextLabel.text) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section == 1) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"修改密码";
                break;
            case 1:
                cell.textLabel.text = @"清空图片缓存";
                break;
            case 2:
                cell.textLabel.text = @"个人信息";
                break;
        }
    } else if (indexPath.section == 2) {
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"版本信息";
                cell.detailTextLabel.text = @"6.6.6";
                break;
            case 1:
                cell.textLabel.text = @"亲，给缤纷好评吧";
                break;
            case 2:
                cell.textLabel.text = @"分享App";
                break;
        }
        if (cell.detailTextLabel.text) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"关于我们";
                break;
            case 1:
                cell.textLabel.text = @"48小时退换货";
                break;
            case 2:
                cell.textLabel.text = @"常见问题";
                break;
            case 3:
                cell.textLabel.text = @"企业合作";
                break;
            case 4:
                cell.textLabel.text = @"配送说明";
                break;
            case 5:
                cell.textLabel.text = @"线下门店";
                break;
        }


    }
    return cell;
}


#pragma mark -- delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"售后服务";
    }else if (section == 1) {
        return @"个人设置";
    }else if (section == 2) {
        return @"关于APP";
    }else {
        return @"关于缤纷";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 220;
    }
    return 0;
}
@end
