//
//  BFLogisticsAndAfterSaleController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFLogisticsAndAfterSaleController.h"
#import "BFAfterSaleProgressController.h"
#import "BFLogisticsCell.h"
#import "BFOrderIDCell.h"
#import "BFLogisticsHeaderView.h"
#import "BFCustomerServiceView.h"
#import "BFLogisticsModel.h"
#import "BFBottomCell.h"
#import "BFCheckLogisticsController.h"
#import "MBProgressHUD.h"

@interface BFLogisticsAndAfterSaleController ()<UITableViewDelegate, UITableViewDataSource, BFLogisticsHeaderViewDelegate, BFBottomCellDelegate, BFCustomerServiceViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**无信息时的背景*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**分区头视图*/
@property (nonatomic, strong) BFLogisticsHeaderView *headerView;
/**客服按钮*/
@property (nonatomic, strong) UIButton *customerServiceButton;
/**订单数组*/
@property (nonatomic, strong) NSMutableArray *logisticsArray;
/**产品数组数组*/
@property (nonatomic, strong) NSMutableArray *productArray;

@end

@implementation BFLogisticsAndAfterSaleController

- (NSMutableArray *)productArray {
    if (!_productArray) {
        _productArray = [NSMutableArray array];
        
    }
    return _productArray;
}

- (NSMutableArray *)logisticsArray {
    if (!_logisticsArray) {
        _logisticsArray = [NSMutableArray array];
        
    }
    return _logisticsArray;
}

- (BFLogisticsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [BFLogisticsHeaderView createHeaderView];
        //_headerView.backgroundColor = [UIColor redColor];
        _headerView.delegate = self;
        [self.view addSubview:_headerView];
    }
    return _headerView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(30)-ScreenHeight, ScreenWidth, ScreenHeight-113-BF_ScaleHeight(30)) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgImageView.image = [UIImage imageNamed:@"logistics_bg"];
        _bgImageView.userInteractionEnabled = YES;
        //_bgImageView.hidden = YES;
        [self.view addSubview:_bgImageView];
        UIButton *button = [UIButton buttonWithType:0];
        button.frame = CGRectMake(BF_ScaleWidth(80), BF_ScaleHeight(300), BF_ScaleWidth(160), BF_ScaleHeight(50));
        [button setTitle:@"返回首页" forState:UIControlStateNormal];
        [button setTitleColor:BFColor(0x0F62BE) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(20)];
        [button addTarget:self action:@selector(clickToHome) forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:button];
    }
    return _bgImageView;
}

#pragma mark --viewDidLoad
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    //获取数据
    [self getData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //获取数据
//    [UIView animateWithDuration:0.5 animations:^{
//        self.tableView.y = BF_ScaleHeight(30)-ScreenHeight;
//    } completion:nil];
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BFColor(0xF4F4F4);
    self.title = @"物流·售后";
    //
    [self bgImageView];
    //添加tableView
    [self tableView];
    //添加顶部视图
    [self headerView];
    //添加导航按钮
    //[self setNavigationBar];
    //客服电话按钮
    [self setUpCustomerService];
    
    
}

#pragma mark --获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=logistics"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    BFLog(@"%@",parameter);
    
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if (responseObject) {
                if ([responseObject[@"msg"] isEqualToString:@"数据为空"] ) {
                    self.bgImageView.hidden = NO;
                    self.tableView.hidden = YES;
                }else {
                    self.bgImageView.hidden = YES;
                    self.tableView.hidden = NO;
                    [self.logisticsArray removeAllObjects];
                    NSArray *array = [BFLogisticsModel parse:responseObject[@"order"]];
                    [self.logisticsArray addObjectsFromArray:array];
                }
               
            }else {
                self.bgImageView.hidden = NO;
                self.tableView.hidden = YES;
            }
            BFLog(@"---%@,,",responseObject);
            [self.tableView reloadData];
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = BF_ScaleHeight(30);
            } completion:nil];
        } failure:^(NSError *error) {
            BFLog(@"%@",error);
        }];

    }];
}


#pragma mark --背景图按钮点击事件
- (void)clickToHome {
    BFLog(@"asdadasda");
    self.tabBarController.selectedIndex = 0;
}

#pragma mark --客服电话按钮
- (void)setUpCustomerService {
    UIButton *customerServiceButton = [UIButton buttonWithType:0];
    self.customerServiceButton = customerServiceButton;
    customerServiceButton.frame = CGRectMake(ScreenWidth, BF_ScaleHeight(390), BF_ScaleWidth(40), BF_ScaleWidth(40));
    [customerServiceButton setImage:[UIImage imageNamed:@"customer_service"] forState:UIControlStateNormal];
    customerServiceButton.hidden = YES;
    //customerServiceButton.backgroundColor = [UIColor redColor];
    [customerServiceButton addTarget:self action:@selector(clickToJumpToCustomerServiceInterface) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customerServiceButton];
}

- (void)clickToJumpToCustomerServiceInterface {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    BFCustomerServiceView *customerServiceView = [BFCustomerServiceView createCustomerServiceView];
    customerServiceView.delegate = self;
    [window addSubview:customerServiceView];
    
}

#pragma mark --BFCustomerServiceViewDelegate {
- (void)clickToChooseCustomerServiceWithType:(BFCustomerServiceViewButtonType)type {
    switch (type) {
        case BFCustomerServiceViewButtonTypeTelephone:{
            BFLog(@"点击电话客服");
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //添加取消按钮
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击");
            }];
            //添加电话按钮
            UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"020-38875719" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://020-38875719"]]];
            }];
            [alertC addAction:cancleAction];
            [alertC addAction:phoneAction];
            [self presentViewController:alertC animated:YES completion:nil];
            
            break;
        }
        case BFCustomerServiceViewButtonTypeWechat:
            BFLog(@"点击微信客服");
            [BFProgressHUD MBProgressFromView:self.view onlyWithLabelText:@"暂不支持，尽请期待"];
            break;
            
    }
}

#pragma mark --添加导航按钮
- (void)setNavigationBar {
    UIButton *afterSaleProgress = [UIButton buttonWithType:0];
    afterSaleProgress.frame = CGRectMake(0, 0, BF_ScaleWidth(60), BF_ScaleHeight(44));
    [afterSaleProgress setTitle:@"售后进度" forState:UIControlStateNormal];
    [afterSaleProgress setTitleColor:BFColor(0x000F8F) forState:UIControlStateNormal];
    //afterSaleProgress.backgroundColor = [UIColor greenColor];
    afterSaleProgress.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    [afterSaleProgress addTarget:self action:@selector(clickToGoToAfterSaleProgressInterFace) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:afterSaleProgress];
    self.navigationItem.rightBarButtonItems = @[rightItem];
}

- (void)clickToGoToAfterSaleProgressInterFace {
    BFAfterSaleProgressController *afterSaleProgressVC = [BFAfterSaleProgressController new];
    [self.navigationController pushViewController:afterSaleProgressVC animated:YES];
}


#pragma mark --tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.logisticsArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
        [self.productArray removeAllObjects];
        BFLogisticsModel *model = self.logisticsArray[section];
        NSArray *array = [BFProductModel parse:model.item];
        [self.productArray addObjectsFromArray:array];
        //BFLog(@"%lu,,%lu",(unsigned long)self.productArray.count,self.logisticsArray.count);
        return self.productArray.count+2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.productArray removeAllObjects];
    BFLogisticsModel *model = self.logisticsArray[indexPath.section];
    NSArray *array = [BFProductModel parse:model.item];
    [self.productArray addObjectsFromArray:array];

    if (indexPath.row == 0) {
        BFOrderIDCell *cell = [BFOrderIDCell cellWithTableView:tableView];
        cell.model = self.logisticsArray[indexPath.section];
        return cell;
    }else if (indexPath.row == self.productArray.count+1) {
        
        BFBottomCell *cell = [BFBottomCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.model = self.logisticsArray[indexPath.section];
        return cell;
    }else {
        BFLogisticsCell *cell = [BFLogisticsCell cellWithTableView:tableView];
        cell.model = self.productArray[indexPath.row-1];
        return cell;
    }


}

#pragma mark -- BFLogisticsCell代理
- (void)clickToOperateWithModel:(BFLogisticsModel *)model Type:(BFLogisticsCellButtonType)type {
    switch (type) {
        case BFLogisticsCellButtonTypeApplyAfterSale:
            BFLog(@"申请售后");
            break;
        case BFLogisticsCellButtonTypeCheckLogistics:{
            BFLog(@"查看物流");
            BFCheckLogisticsController *vc = [BFCheckLogisticsController new];
            vc.freecode = model.freecode;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case BFLogisticsCellButtonTypeConfirmReceipt:
            BFLog(@"确认收货");
            break;

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return BF_ScaleHeight(25);
    }else if (indexPath.row == self.productArray.count+1) {
        return BF_ScaleHeight(70);
    }else {
        return BF_ScaleHeight(95);
    }
    
}





#pragma mark -- 分区头视图


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

        return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.customerServiceButton.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.customerServiceButton.x = BF_ScaleWidth(270);
    } completion:nil];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.customerServiceButton.x = ScreenWidth;
    } completion:^(BOOL finished) {
        self.customerServiceButton.hidden = YES;
    }];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.customerServiceButton.x = ScreenWidth;
    } completion:^(BOOL finished) {
        self.customerServiceButton.hidden = YES;
    }];

}




//分区头视图代理
- (void)clickToSeeConmmonProblem {
    
}

@end
