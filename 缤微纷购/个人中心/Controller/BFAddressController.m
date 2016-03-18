//
//  BFAddressController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/17.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFAddressController.h"
#import "BFAddressCell.h"
#import "BFAddAddressController.h"
#import "BFAddressModel.h"
#import "BFEditAddressController.h"
#import "BFPersonInformationController.h"
@interface BFAddressController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, BFAddressCellDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**地址可变数组*/
@property (nonatomic, strong) NSMutableArray *addressArray;
/**提示button*/
@property (nonatomic, strong) UIButton *remindButton;

@end

@implementation BFAddressController

- (UIButton *)remindButton {
    if (!_remindButton) {
        _remindButton = [UIButton buttonWithType:0];
        _remindButton.frame = CGRectMake(BF_ScaleWidth(60), BF_ScaleHeight(200), BF_ScaleWidth(200), BF_ScaleHeight(40));
        _remindButton.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        [_remindButton setTitle:@"还未添加地址，点击添加" forState:UIControlStateNormal];
        [_remindButton setTitleColor:BFColor(0x4582f2) forState:UIControlStateNormal];
        [_remindButton addTarget:self action:@selector(clickToAddAddress) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_remindButton];
    }
    return _remindButton;
}


- (NSMutableArray *)addressArray {
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BFColor(0xffffff);
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
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
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        [self.addressArray removeAllObjects];
        NSArray *array = [BFAddressModel parse:responseObject[@"address"]];
        [self.addressArray addObjectsFromArray:array];
        if (self.addressArray.count == 0) {
            self.remindButton.hidden = NO;
        }else {
            self.remindButton.hidden = YES;
        }
        [self.tableView reloadData];
        BFLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
        BFLog(@"%@", error);
    }];
}

- (void)clickToAddAddress {
    BFAddAddressController *addVC = [BFAddAddressController new];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressArray.count;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFAddressCell *cell = [BFAddressCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.model = self.addressArray[indexPath.row];
    return cell;
}
//BFAddressCellDelegate
- (void)chooseToUseTheAddress:(BFAddressCell *)cell {
    NSArray *vcsArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcsArray.count;
    UIViewController *lastVC = vcsArray[vcCount-2];
    if (![lastVC isKindOfClass:[BFPersonInformationController class]]) {
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
