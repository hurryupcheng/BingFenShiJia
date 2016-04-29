//
//  BFAddressController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFZFViewController.h"
#import "BFAddressController.h"
#import "BFAddressCell.h"
#import "BFAddAddressController.h"
#import "BFAddressModel.h"
#import "BFEditAddressController.h"
#import "BFPersonInformationController.h"
@interface BFAddressController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, BFAddressCellDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**无地址时的背景*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**地址可变数组*/
@property (nonatomic, strong) NSMutableArray *addressArray;
/**提示button*/
@property (nonatomic, strong) UIButton *remindButton;
/**cell*/
@property (nonatomic, strong) BFAddressCell *cell;
@end

@implementation BFAddressController

//- (UIButton *)remindButton {
//    if (!_remindButton) {
//        _remindButton = [UIButton buttonWithType:0];
//        _remindButton.frame = CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(200), BF_ScaleWidth(200), BF_ScaleHeight(40));
//        _remindButton.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
//        [_remindButton setTitle:@"还未添加地址，点击添加" forState:UIControlStateNormal];
//        [_remindButton setTitleColor:BFColor(0x4582f2) forState:UIControlStateNormal];
//        [_remindButton addTarget:self action:@selector(clickToAddAddress) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_remindButton];
//    }
//    return _remindButton;
//}


- (NSMutableArray *)addressArray {
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xffffff);
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenHeight, ScreenHeight)];
        _bgImageView.image = [UIImage imageNamed:@"address_bg"];
        _bgImageView.userInteractionEnabled = YES;
        //_bgImageView.hidden = YES;
        [self.view addSubview:_bgImageView];
        UIButton *button = [UIButton buttonWithType:0];
        button.frame = CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(200), BF_ScaleWidth(200), BF_ScaleHeight(40));
        [button setTitle:@"还未添加地址，点击添加" forState:UIControlStateNormal];
        [button setTitleColor:BFColor(0x00008C) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
        [button addTarget:self action:@selector(clickToAddAddress) forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:button];
    }
    return _bgImageView;
}



#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xffffff);
    self.title = @"收货地址";
    //添加背景
    //[self bgImageView];
    //添加导航栏
    [self setNavigationBar];
    //添加tableView
    [self tableView];
    
}
#pragma mark -- viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //获取地址数据
    [self getData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.y = -ScreenHeight;
    }];
}

#pragma mark -- 添加导航栏
- (void)setNavigationBar{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickToAddAddress)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark -- 添加导航栏
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=check_address"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"---%@", responseObject);
            if (responseObject) {
                [self.addressArray removeAllObjects];
               
                    NSArray *array = [BFAddressModel parse:responseObject[@"address"]];
                    [self.addressArray addObjectsFromArray:array];
                    if (self.addressArray.count == 0) {
                        self.bgImageView.hidden = NO;
                    }else {
                        self.bgImageView.hidden = YES;
                    }

                
            }else {
                self.bgImageView.hidden = NO;
            }
            [self.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = 0;
                self.bgImageView.y = 0;
            }];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
            BFLog(@"%@", error);
        }];

    }];
}
//添加地址
- (void)clickToAddAddress {
    [UIView animateWithDuration:0.5 animations:^{
        self.bgImageView.y = -ScreenHeight;
    }];
    BFAddAddressController *addVC = [BFAddAddressController new];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressArray.count;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    BFAddressCell *cell = [BFAddressCell cellWithTableView:tableView];
    self.cell = cell;
    cell.delegate = self;
    cell.model = self.addressArray[indexPath.row];
    NSArray *vcsArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcsArray.count;
    UIViewController *lastVC = vcsArray[vcCount-2];
    BFLog(@"-----%@",vcsArray);
    if ([lastVC isKindOfClass:[BFZFViewController class]]) {
        cell.selectButton.hidden = NO;
    }else {
        cell.selectButton.hidden = YES;
    }
    return cell;
}
//BFAddressCellDelegate
- (void)chooseToUseTheAddress:(BFAddressCell *)cell button:(UIButton *)button{
    NSArray *vcsArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcsArray.count;
    UIViewController *lastVC = vcsArray[vcCount-2];
    if ([lastVC isKindOfClass:[BFZFViewController class]]) {
        _block(cell.model);
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        
    }
    
    BFLog(@"%@",vcsArray);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFLog(@"点击了");
    BFAddressModel *model = self.addressArray[indexPath.row];
    BFEditAddressController *editVC = [BFEditAddressController new];
    editVC.model = model;
    [self.navigationController pushViewController:editVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(105);
}

@end
