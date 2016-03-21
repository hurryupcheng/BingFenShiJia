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
#import "BFLogisticsHeaderView.h"
#import "BFCustomerServiceView.h"
#import "BFLogisticsModel.h"

@interface BFLogisticsAndAfterSaleController ()<UITableViewDelegate, UITableViewDataSource, BFLogisticsHeaderViewDelegate, BFLogisticsCellDelegate, BFCustomerServiceViewDelegate>
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
        _headerView.delegate = self;
        [self.view addSubview:_headerView];
    }
    return _headerView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(30), ScreenWidth, ScreenHeight-66-BF_ScaleHeight(30)) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BFColor(0xF2F4F5);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgImageView.image = [UIImage imageNamed:@"after_sale_service"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流·售后";
    //添加tableView
    [self tableView];
    //添加顶部视图
    [self headerView];
    //添加导航按钮
    //[self setNavigationBar];
    //客服电话按钮
    [self setUpCustomerService];
    //获取数据
    [self getData];
}

#pragma mark --获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=logistics"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    BFLog(@"%@",parameter);
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        NSArray *array = [BFLogisticsModel parse:responseObject[@"order"]];
        [self.logisticsArray addObjectsFromArray:array];
        for (BFLogisticsModel *logisticsModel in array) {
            NSArray *array = [ProductList parse:logisticsModel.item];
            [self.productArray addObject:array];
        }
        BFLog(@"%@,,%@",responseObject, self.productArray);
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        BFLog(@"%@",error);
    }];
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
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFLogisticsCell *cell = [BFLogisticsCell cellWithTableView:tableView];
    //cell.model = self.logisticsArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark -- BFLogisticsCell代理
- (void)clickToOperateWithType:(BFLogisticsCellButtonType)type {
    switch (type) {
        case BFLogisticsCellButtonTypeApplyAfterSale:
            BFLog(@"申请售后");
            break;
        case BFLogisticsCellButtonTypeCheckLogistics:
            BFLog(@"查看物流");
            break;
        case BFLogisticsCellButtonTypeConfirmReceipt:
            BFLog(@"确认收货");
            break;

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BF_ScaleHeight(200);
}

#pragma mark -- 分区头视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    //return self.headerView;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return BF_ScaleHeight(30);
//}



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
