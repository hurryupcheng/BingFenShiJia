//
//  BFMyClientController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyClientController.h"
#import "BFBottomHeaderCell.h"
#import "BFUpYearAndMonthCell.h"
#import "BFDateModel.h"
#import "BFAdvertisingExpenseInformationCell.h"

@interface BFMyClientController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate, BFBottomHeaderCellDelegate>

/**底部tableView*/
@property (nonatomic, strong) UITableView *bottomTableView;
/**上面tableView*/
@property (nonatomic, strong) UITableView *upTableView;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
/**底部头cell*/
@property (nonatomic, strong) BFBottomHeaderCell *headerCell;
/**_upTableView的cell*/
@property (nonatomic, strong) BFUpYearAndMonthCell *dateCell;
/**年月数组*/
@property (nonatomic, strong) NSMutableArray *dateArray;
@end

@implementation BFMyClientController

- (NSMutableArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

- (UITableView *)bottomTableView {
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-116) style:UITableViewStylePlain];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        [self.view addSubview:_bottomTableView];
       
        
    }
    return _bottomTableView;
}

- (UITableView *)upTableView {
    if (!_upTableView) {
        _upTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 94, ScreenWidth, ScreenHeight-160) style:UITableViewStylePlain];
        _upTableView.delegate = self;
        _upTableView.dataSource = self;
        [self.view addSubview:_upTableView];
        _upTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _upTableView;
}

- (BFSegmentView *)segment {
    if (!_segment) {
        _segment = [BFSegmentView segmentView];
        _segment.delegate = self;
        _segment.titleArray = @[@"已关注", @"未关注", @"直推人数", @"团队人数"];
    }
    return _segment;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的客户";
    self.view.backgroundColor = BFColor(0xffffff);
    //添加分段控制器
    [self.view addSubview:self.segment];
    //添加底部tableView
    [self bottomTableView];
    //添加上面tableView
    [self upTableView];
    //获取数据
    [self getData];
    
}

#pragma mark --获取数据
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark -- getData
- (void)getData {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=year_month"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    [BFProgressHUD MBProgressFromView:self.view LabelText:@"正在请求..." dispatch_get_main_queue:^{
        [BFHttpTool GET:url params:parameter success:^(id responseObject) {
            if (responseObject) {
                NSArray *array = [BFDateModel parse:responseObject];
                [self.dateArray addObjectsFromArray:array];
                BFLog(@"%lu",(unsigned long)self.dateArray.count);
            }
            [self.upTableView reloadData];
            BFLog(@"%@",responseObject);
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            
            [self tableView:self.upTableView didSelectRowAtIndexPath:path];
            [self tableView:self.upTableView didSelectRowAtIndexPath:path];
            [self animation];
        } failure:^(NSError *error) {
            [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
            BFLog(@"%@", error);
        }];
    }];
}

- (void)animation {
    
}

#pragma mark --BFSegmentView代理方法
- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            BFLog(@"点击已关注");
            break;
        case 1:
            BFLog(@"点击未关注");
            break;
        case 2:
            BFLog(@"点击直推人数");
            break;
        case 3:
            BFLog(@"点击团队人数");
            break;
    }
}

#pragma mark --tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.upTableView) {
        return self.dateArray.count;
    }else {
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.upTableView) {
        BFUpYearAndMonthCell *cell = [BFUpYearAndMonthCell cellWithTableView:tableView];
        cell.model = self.dateArray[indexPath.row];
        self.dateCell = cell;
        return cell;
    }else {
        if (indexPath.row == 0) {
            BFBottomHeaderCell *cell = [BFBottomHeaderCell cellWithTabelView:tableView];
            self.headerCell = cell;
            cell.delegate = self;
            return cell;
        }else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
            }
            cell.textLabel.text = @"1213213";
            return cell;
            
            
        }
        
        
    }
}

#pragma mark --BFBottomHeaderCellDelegate方法
- (void)clickToChangeStatus:(UIButton *)button {
    if (button.selected == YES) {
        self.upTableView.hidden = YES;
    }else {
        self.upTableView.hidden = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        BFDateModel *model = self.dateArray[indexPath.row];
        self.headerCell.timeLabel.text = [NSString stringWithFormat:@"%ld年%@月",(long)model.year, model.month];
        [self getMyClientData:model];
        [self.headerCell click];
        self.upTableView.hidden = YES;
        [self.bottomTableView reloadData];
        
    }else {
        if (indexPath.row == 0) {
            self.upTableView.hidden = NO;
        }
        
    }
}

- (void)getMyClientData:(BFDateModel *)model {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=month_commission"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    parameter[@"year"] = @(model.year);
    parameter[@"month"] = model.month;
   
    [BFHttpTool GET:url params:parameter success:^(id responseObject) {
    
        
        BFLog(@"%@",responseObject);
       [self.upTableView reloadData];
        [self animation];
    } failure:^(NSError *error) {
        [BFProgressHUD MBProgressFromView:self.view andLabelText:@"网络异常"];
        BFLog(@"%@", error);
    }];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.upTableView) {
        return BF_ScaleHeight(44);
    }else {
        if (indexPath.row == 0) {
            return BF_ScaleHeight(44);
        }else if (indexPath.row == 1){
            return 30;
        }
    }
}

@end
