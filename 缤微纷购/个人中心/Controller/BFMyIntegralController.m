//
//  BFMyIntegralController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//  我的积分



#import "BFMyIntegralController.h"
#import "BFMyIntegralCell.h"
#import "BFMyIntegralHeaderView.h"
#import "BFScoreModel.h"


@interface BFMyIntegralController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**背景图*/
@property (nonatomic, strong) UIImageView *bgImageView;
/**积分数组*/
@property (nonatomic, strong) NSMutableArray *scoreArray;
/**头部视图*/
@property (nonatomic, strong) BFMyIntegralHeaderView *headerView;
@end

@implementation BFMyIntegralController

- (NSMutableArray *)scoreArray {
    if (!_scoreArray) {
        _scoreArray = [NSMutableArray array];
    }
    return _scoreArray;
}


- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _bgImageView.image = [UIImage imageNamed:@"bg.jpg"];
    }
    return _bgImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50-ScreenHeight, ScreenWidth, ScreenHeight-114) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (BFMyIntegralHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BFMyIntegralHeaderView alloc] initWithFrame:CGRectMake(0, -HeaderH, ScreenWidth, HeaderH)];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    //导航栏
    [self setNavigationBar];
    //添加背景图
    [self.view addSubview:self.bgImageView];
    //添加头部视图
    [self headerView];
    //添加tableView
    [self.view addSubview:self.tableView];
    //获取数据
    [self getData];
}


#pragma mark -- getData
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=score_list"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressFromView:self.navigationController.view WithLabelText:@"Loading" dispatch_get_global_queue:^{
        [BFProgressHUD doSomeWorkWithProgress:self.navigationController.view];
    } dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            BFLog(@"%@",responseObject);
            if (responseObject) {
                self.headerView.totalScore = responseObject[@"score"];
                userInfo.score = responseObject[@"score"];
                [BFUserDefaluts modifyUserInfo:userInfo];
                
                if ([responseObject[@"score_list"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [BFScoreModel parse:responseObject[@"score_list"]];
                    if (array.count != 0) {
                        [self.scoreArray addObjectsFromArray:array];
                    }else {
                        [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时没有可用积分哦!"];
                    }
                }else {
                    [BFProgressHUD MBProgressFromView:self.navigationController.view onlyWithLabelText:@"亲,暂时没有可用积分哦!"];
                }
                BFLog(@"%@,,%@,,%lu", responseObject,parameter,(unsigned long)self.scoreArray.count);
            }
            [self.tableView reloadData];
            [self animation];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
            BFLog(@"%@", error);
        }];
    }];
}
#pragma mark -- 动画效果
- (void)animation{
    [UIView animateWithDuration:0.5 animations:^{
        self.headerView.y = 0;
        self.tableView.y = 50;
    }];
}


#pragma mark -- 设置导航栏
- (void)setNavigationBar {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"积分规则"  style:UIBarButtonItemStylePlain target:self action:@selector(integralRule)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)integralRule {
    BFLog(@"积分规则");
}

#pragma mark --- datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scoreArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyIntegralCell *cell = [BFMyIntegralCell cellWithTableView:tableView];
    cell.model = self.scoreArray[indexPath.row];
    
    return cell;
}







//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return SectionHeaderH;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MyIntegralCellH;
}
@end
