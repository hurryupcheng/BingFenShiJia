//
//  BFSettingController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define kUMKey  @"56e3cf9fe0f55a2fe50023fb"
#import "UMSocial.h"
#import "BFSettingController.h"
#import "BFShareView.h"
@interface BFSettingController ()<UITableViewDelegate, UITableViewDataSource, BFShareViewDelegate>
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (indexPath.row == 2) {
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            BFShareView *share = [BFShareView shareView];
            share.delegate = self;
            [window addSubview:share];
        }
    }
}

- (void)bfShareView:(BFShareView *)shareView type:(BFShareButtonType)type {
    switch (type) {
            
            
            
            
        case BFShareButtonTypeMoments:
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController: self completion:^(UMSocialResponseEntity *response){
                if(response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            BFLog(@"朋友圈分享");
        break;
            case BFShareButtonTypeWechatFriends:

            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            BFLog(@"微信好友");
            break;
            case BFShareButtonTypeSinaBlog:

            [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"SinaBlog"] socialUIDelegate:self];        //设置分享内容和回调对象
            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
            BFLog(@"新浪微博分享");
            break;
        case BFShareButtonTypeQQFriends:
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享文字" image:nil location:nil urlResource:nil presentedController: self completion:^(UMSocialResponseEntity *response){
                if(response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            BFLog(@"QQ好友分享");
            break;
        case BFShareButtonTypeQQZone:
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"分享文字" image:nil location:nil urlResource:nil presentedController: self completion:^(UMSocialResponseEntity *response){
                if(response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            BFLog(@"QQ空间分享");
            break;

    }
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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

- (void)viewWillAppear:(BOOL)animated{
self.tabBarController.tabBar.hidden = YES;
}
@end
