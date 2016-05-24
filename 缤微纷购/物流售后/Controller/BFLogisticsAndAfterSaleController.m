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
#import "FXQViewController.h"

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
/**是不是第一次进入*/
@property (nonatomic, assign) BOOL isYirstTime;

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
        button.frame = CGRectMake(BF_ScaleWidth(80), BF_ScaleHeight(350), BF_ScaleWidth(160), BF_ScaleHeight(50));
        [button setTitle:@"返回首页" forState:UIControlStateNormal];
        [button setTitleColor:BFColor(0x0F62BE) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(20)];
        [button addTarget:self action:@selector(clickToHome) forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:button];
    }
    return _bgImageView;
}

//初始化让bool属性为真
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isYirstTime = YES;
    }
    return self;
}

#pragma mark --viewDidLoad
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    if (![BFUserDefaluts getUserInfo]) {
        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"未登录,请先登录"];
        self.bgImageView.hidden = NO;
        self.tableView.hidden = YES;
        self.isYirstTime = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.y = BF_ScaleHeight(30)-ScreenHeight;
        } completion:nil];
        
    }else {
        if (self.isYirstTime) {
            // 集成下拉刷新控件
            [self setupDownRefresh];
            //获取数据
            [self getData];
        }else {
            
        }
    }
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
    
    //获取数据
    //[self getData];
    
}

#pragma mark --集成下拉刷新
- (void)setupDownRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    //[self.tableView.mj_header beginRefreshing];
}


- (void)loadNewData {
    //音效
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=logistics"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    BFLog(@"%@",parameter);
    
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"数据为空"] ) {
                [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有更多可以查看的订单哦!"];
            }else {
                
                NSArray *array = [BFLogisticsModel parse:responseObject[@"order"]];
                [BFSoundEffect playSoundEffect:@"paopao.wav"];
                [self showNewStatusCount:array.count-self.logisticsArray.count];
                [self.logisticsArray removeAllObjects];
                [self.logisticsArray addObjectsFromArray:array];
                
//                if (array.count <= self.logisticsArray.count) {
//                    [BFProgressHUD MBProgressOnlyWithLabelText:@"亲,没有更多可以查看的订单哦!"];
//                }else {
//                    
//                }
            }
        }
        // BFLog(@"---%@,,",responseObject);
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络异常 请检测网络"];
        BFLog(@"%@",error);
    }];
}

- (void)showNewStatusCount:(NSUInteger)count
{
    // 刷新成功(清空图标数字)
    
    
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = BFColor(0xFD8B2F);
    label.width = ScreenWidth;
    label.height = 35;
    
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"亲,没有更多新的订单哦!";
    } else {
        label.text = [NSString stringWithFormat:@"共有%zd条新的订单", count];
    }
    label.textColor = BFColor(0xffffff);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    // 3.添加
    label.y = self.headerView.height - label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.view insertSubview:label belowSubview:self.headerView];
    
    // 4.动画
    // 先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0; // 延迟1s
        // UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
}


#pragma mark --获取数据
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=logistics"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    BFLog(@"%@",parameter);
    
    [BFProgressHUD MBProgressWithLabelText:@"Loading" dispatch_get_main_queue:^(MBProgressHUD *hud) {
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"---%@", responseObject);
            if (responseObject) {
                if ([responseObject[@"msg"] isEqualToString:@"数据为空"] ) {
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有可以查看的订单哦!"];
                    self.bgImageView.hidden = NO;
                    self.tableView.hidden = YES;
                }else {
                    if ([responseObject[@"order"] isKindOfClass:[NSArray class]]) {
                        NSArray *array = [BFLogisticsModel parse:responseObject[@"order"]];
                        if (array.count == 0) {
                            [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,没有可以查看的订单哦!"];
                            self.bgImageView.hidden = NO;
                            self.tableView.hidden = YES;
                        }else {
                            self.bgImageView.hidden = YES;
                            self.tableView.hidden = NO;
                            [self.logisticsArray removeAllObjects];
                            [self.logisticsArray addObjectsFromArray:array];
                        }
                    }
                    
                }
            }else {
                self.bgImageView.hidden = NO;
                self.tableView.hidden = YES;
            }
           // BFLog(@"---%@,,",responseObject);
            [hud hideAnimated:YES];
            [self.tableView reloadData];
            self.isYirstTime = NO;
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.y = BF_ScaleHeight(30);
            } completion:nil];
        } failure:^(NSError *error) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressFromWindowWithLabelText:@"网络异常 请检测网络"];
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
    customerServiceButton.frame = CGRectMake(BF_ScaleWidth(270), BF_ScaleHeight(350), BF_ScaleWidth(40), BF_ScaleWidth(40));
    [customerServiceButton setImage:[UIImage imageNamed:@"customer_service"] forState:UIControlStateNormal];
    //customerServiceButton.hidden = YES;
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
            UIAlertController *alertC = [UIAlertController alertWithControllerTitle:nil controllerMessage:nil preferredStyle:UIAlertControllerStyleActionSheet actionTitle:@"020-38875719" style:UIAlertActionStyleDefault handler:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://020-38875719"]]];
            }];
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
    for (BFProductModel *productModel in array) {
        productModel.OrderID = model.orderId;
    }
    
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        BFLogisticsCell *cell = [BFLogisticsCell cellWithTableView:tableView];
        cell.model = self.productArray[indexPath.row-1];
        
        return cell;
    }


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFLogisticsModel *model = self.logisticsArray[indexPath.section];
    NSArray *array = [BFProductModel parse:model.item];
    if (indexPath.row == 0) {
        return;
    }else if (indexPath.row == array.count+1) {
        return;
    }else {
        BFProductModel *producrtmodel = array[indexPath.row-1];
        BFLog(@"-----------------%@", producrtmodel.itemId);
        FXQViewController *fxVC =[[FXQViewController alloc] init];
        fxVC.ID = producrtmodel.itemId;
        [self.navigationController pushViewController:fxVC animated:YES];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}



#pragma mark -- BFLogisticsCell代理
- (void)clickToOperateWithCell:(BFBottomCell *)cell model:(BFLogisticsModel *)model Type:(BFLogisticsCellButtonType)type{
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
        case BFLogisticsCellButtonTypeConfirmReceipt:{
            UIAlertController *alertC = [UIAlertController alertWithControllerTitle:@"确认收货" controllerMessage:@"确定收货吗" preferredStyle:UIAlertControllerStyleAlert actionTitle:@"确定" style:UIAlertActionStyleDefault handler:^{
                //确认收货
                [self confirmOrderWithModel:model AndCell:cell];
            }];
            [self presentViewController:alertC animated:YES completion:nil];
            BFLog(@"确认收货");
            break;
        }

    }
}



#pragma mark -- 确认收货
- (void)confirmOrderWithModel:(BFLogisticsModel *)model AndCell:(BFBottomCell *)cell{
   [BFProgressHUD MBProgressWithLabelText:@"正在收货,请稍等片刻..." dispatch_get_main_queue:^(MBProgressHUD *hud) {
        if (![model.status isEqualToString:@"3"]) {
            [hud hideAnimated:YES];
            [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"订单还未发货"];
        }else {
            BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
            NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=confirmOrder"];
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            parameter[@"uid"] = userInfo.ID;
            parameter[@"token"] = userInfo.token;
            parameter[@"orderId"] = model.orderId;
            parameter[@"status"] = model.status;
            [BFHttpTool POST:url params:parameter success:^(id responseObject) {
                BFLog(@"--%@----%@", responseObject, parameter);
                if ([responseObject[@"msg"] isEqualToString:@"确认收货成功"]) {
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view rightLabelText:@"确认收货成功"];
                        //收货成功改变状态
                    model.status = @"4";
                    cell.model = model;
                    [self.tableView reloadData];
                    
                }else if([responseObject[@"msg"] isEqualToString:@"确认收货失败"]){
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"确认收货失败"];
                }else if([responseObject[@"msg"] isEqualToString:@"该订单不存在"]){
                    [hud hideAnimated:YES];
                    [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"该订单不存在"];
                }else {
                    
                }
            } failure:^(NSError *error) {
                [hud hideAnimated:YES];
                [BFProgressHUD MBProgressFromView:self.navigationController.view andLabelText:@"网络问题"];
                BFLog(@"--%@", error);
            }];
        }
    }];
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



//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    self.customerServiceButton.hidden = NO;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.customerServiceButton.x = BF_ScaleWidth(270);
//    } completion:nil];
//}
//
//
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.customerServiceButton.x = ScreenWidth;
//    } completion:^(BOOL finished) {
//        self.customerServiceButton.hidden = YES;
//    }];
//    
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.customerServiceButton.x = ScreenWidth;
//    } completion:^(BOOL finished) {
//        self.customerServiceButton.hidden = YES;
//    }];
//
//}




#pragma mark -- 48小时售后点击
- (void)clickToSeeConmmonProblem {
    
}

@end
