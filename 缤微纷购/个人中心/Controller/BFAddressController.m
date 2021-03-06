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
//返回顶部按钮
@property (nonatomic, strong) UIButton *TopButton;
//偏移量
@property (nonatomic, assign) CGFloat contentOffSetY;
@end

@implementation BFAddressController




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
    //获取地址数据
    [self getData];
    //修改地址添加地址，删除地址后的通知
    [BFNotificationCenter addObserver:self selector:@selector(refreshAddress) name:@"refreshAddress" object:nil];
    
}
#pragma mark -- viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.tableView.y = -ScreenHeight;
//    }];
}

#pragma mark -- 通知刷新
- (void)refreshAddress {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=check_address"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        BFLog(@"---%@", responseObject);
        if (responseObject) {
            if ([responseObject[@"address"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [BFAddressModel parse:responseObject[@"address"]];
                if (array.count == 0) {
                    [self.addressArray removeAllObjects];
                    [BFProgressHUD MBProgressOnlyWithLabelText:@"亲,暂时还没有可用地址哦!"];
                    self.bgImageView.hidden = NO;
                }else {
                    [self.addressArray removeAllObjects];
                    self.bgImageView.hidden = YES;
                    [self.addressArray addObjectsFromArray:array];
                }
            }else {
                [self.addressArray removeAllObjects];
                [BFProgressHUD MBProgressOnlyWithLabelText:@"亲,暂时还没有可用地址哦!"];
                self.bgImageView.hidden = NO;
            }
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
        BFLog(@"%@", error);
    }];

}


- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
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
    [BFProgressHUD MBProgressWithLabelText:@"Loading..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"---%@", responseObject);
            if (responseObject) {
                if ([responseObject[@"address"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [BFAddressModel parse:responseObject[@"address"]];
                    if (array.count == 0) {
                        [BFProgressHUD MBProgressOnlyWithLabelText:@"亲,暂时还没有可用地址哦!"];
                        self.bgImageView.hidden = NO;
                    }else {
                        [self.addressArray removeAllObjects];
                        self.bgImageView.hidden = YES;
                        [self.addressArray addObjectsFromArray:array];
                    }
                }else {
                    [BFProgressHUD MBProgressOnlyWithLabelText:@"亲,暂时还没有可用地址哦!"];
                    self.bgImageView.hidden = NO;
                }
            }
            [hud hideAnimated:YES];
            [self.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = 0;
                self.bgImageView.y = 0;
            }];
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
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

#pragma mark --滑动删除地址
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取编辑模式
    UITableViewCellEditingStyle style = editingStyle;
    // 如果是删除模式,才往下进行
    if (style != UITableViewCellEditingStyleDelete) {
        return ;
    }
    // 先修改数据 模型,再更新(如果对象数组中删除了一些对象,则只能调用tableView的deleteRowsAtIndexPaths方法,否则报错)
    BFAddressModel *model = self.addressArray[indexPath.row];
    [self.addressArray removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self deleteAddress:model.ID];
}

- (void)deleteAddress:(NSString *)addressID {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=del_address"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"id"] = addressID;
    BFLog(@"%@,",parameter);
    [BFProgressHUD MBProgressWithLabelText:@"正在删除地址..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool POST:url params:parameter success:^(id responseObject) {
            BFLog(@"%@",responseObject);
            if ([responseObject[@"msg"] isEqualToString:@"删除成功"]) {
                [BFProgressHUD MBProgressFromView:self.view rightLabelText:@"删除成功"];
            }else {
                [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"删除失败,请重新操作"];
            }
            
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络问题"];
        }];

    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(105);
}

#pragma mark -- 添加返回顶部的按钮
- (UIButton *)TopButton{
    if (!_TopButton) {
        _TopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _TopButton.frame = CGRectMake(ScreenWidth - BF_ScaleWidth(60),ScreenHeight-BF_ScaleHeight(190), BF_ScaleWidth(50), BF_ScaleWidth(50));
        _TopButton.layer.cornerRadius = BF_ScaleWidth(25);
        _TopButton.layer.masksToBounds = YES;
        _TopButton.backgroundColor = BFColor(0x1dc3ff);
        [_TopButton setTitle:@"TOP" forState:UIControlStateNormal];
        [self.TopButton addTarget:self action:@selector(TopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TopButton;
}
- (void)TopButtonAction:(UIButton *)sender{
    
    //self.tableView.contentOffset = CGPointMake(0, 0);
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    [self.TopButton removeFromSuperview];
}
//开始拖动scrollV
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _contentOffSetY = scrollView.contentOffset.y;
}

//只要偏移量发生改变就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currcontentOffSetY = scrollView.contentOffset.y;
    if (_contentOffSetY > currcontentOffSetY && currcontentOffSetY > 0) {
        [self.view addSubview:self.TopButton];
        //        [self.view bringSubviewToFront:self.TopButton];
    }else{
        [self.TopButton removeFromSuperview];
    }
}


@end
