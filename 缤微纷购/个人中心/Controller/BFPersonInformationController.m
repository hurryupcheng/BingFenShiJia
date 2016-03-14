//
//  BFPersonInformationController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPersonInformationController.h"

@interface BFPersonInformationController ()<UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BFPersonInformationController

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
    self.title = @"个人信息";
    [self.view addSubview:self.tableView];
}


#pragma mark -- datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 3;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    
    cell.accessoryView.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    cell.detailTextLabel.textColor = BFColor(0x959698);
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"  头像";
                UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
                headImageView.backgroundColor = [UIColor redColor];
                headImageView.frame = CGRectMake(ScreenWidth-BF_ScaleHeight(70), BF_ScaleHeight(10), BF_ScaleHeight(40), BF_ScaleHeight(40));
                headImageView.contentMode = UIViewContentModeScaleAspectFill;
                [cell addSubview:headImageView];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                BFLog(@"%@",NSStringFromCGRect(headImageView.frame));
                break;
            }
            case 1:
                cell.textLabel.text = @"  推荐人";
                cell.detailTextLabel.text = userInfo.p_username;
                break;
            case 2:
                cell.textLabel.text = @"  昵称";
                cell.detailTextLabel.text = userInfo.nickname;
                break;
        }
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"  广告主";
        cell.accessoryView = [[UISwitch alloc] init];
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"  地址管理";
                UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
                headImageView.backgroundColor = [UIColor redColor];
                headImageView.frame = CGRectMake(ScreenWidth-BF_ScaleHeight(45), BF_ScaleHeight(10), BF_ScaleHeight(15), BF_ScaleHeight(24));
                headImageView.contentMode = UIViewContentModeScaleAspectFit;
                [cell addSubview:headImageView];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                break;
            }
            case 1:
                cell.textLabel.text = @"  我的名片";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;                break;
            case 2:
                cell.textLabel.text = @"  绑定手机";
                cell.detailTextLabel.text = @"  未绑定";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
        }
    }else {
        cell.textLabel.text = @"  余额";
        UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(90), 0, BF_ScaleWidth(200), 44)];
        balanceLabel.textColor = BFColor(0xFD8727);
        balanceLabel.text = @"¥00.00";
        [cell addSubview:balanceLabel];
        
    }
    return cell;
}


#pragma mark -- delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return BF_ScaleHeight(60);
        }
    }
    return BF_ScaleHeight(44);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}








- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(60))];
        //footerView.backgroundColor = [UIColor redColor];
        UIButton *exitButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(90), BF_ScaleHeight(15), BF_ScaleWidth(140), BF_ScaleHeight(40)) title:@"退出登录" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
        exitButton.backgroundColor = BFColor(0xFD8727);
        [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:exitButton];
        return footerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return BF_ScaleHeight(90);
    }
    return 0;
}
//推出登录
- (void)exit {
    
    [BFProgressHUD MBProgressFromWindowWithLabelText:@"退出登录" dispatch_get_main_queue:^{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserInfo"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

@end
