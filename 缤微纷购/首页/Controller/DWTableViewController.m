//
//  DWTableViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "DWTableViewController.h"
#import "BFHotCityCell.h"
#import "BFCurrentLocationCell.h"
#import <CoreLocation/CoreLocation.h>

@interface DWTableViewController ()<UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate, SettingLocationDelegate, ChooseHotCityDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**热门城市cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/**定位管理*/
@property (nonatomic, strong) CLLocationManager * manager;
/**城市*/
@property (nonatomic, strong) NSString * currentCity;

@property (nonatomic,retain)NSMutableArray *dataArray;

@property (nonatomic,retain)NSDictionary *areaDic;
@property (nonatomic,retain)NSArray *province;
@property (nonatomic,retain)NSArray *city;
@property (nonatomic,retain)NSArray *district;

@end

@implementation DWTableViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"城市列表";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:BF_ScaleFont(18)],NSForegroundColorAttributeName:BFColor(0x0E61C0)}];
    //添加tableView
    [self tableView];
    //添加返回按钮
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backToHome) image:@"back" highImage:@"back"];
    self.navigationItem.leftBarButtonItem = back;
    //如果定位状态改变，接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoReload) name:@"reloadData" object:nil];
    
    
}


- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
}

- (void)backToHome {
    BFLog(@"---------%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"]);
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"] == nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请选择所在城市" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
   
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)gotoReload {
   
    [self.tableView reloadData];
    
    
}

- (void)getDate:(NSInteger)num{

    NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
    _areaDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSArray *components = [_areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    _dataArray = [NSMutableArray array];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[_areaDic objectForKey:index] allKeys];
        [_dataArray addObject:[tmp objectAtIndex:0]];
    }
    
    _province = [[NSArray alloc] initWithArray:_dataArray];
    
    NSString *index = [sortedArray objectAtIndex:num];
    NSString *selected = [_province objectAtIndex:num];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[_areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    _city = [[NSArray alloc]initWithArray:[cityDic allKeys]];
    
    
    NSString *selectedCity = [_city objectAtIndex:0];
    _district = [[NSArray alloc]initWithArray:[cityDic objectForKey: selectedCity]];
    
    NSLog(@"%@",_dataArray);
    NSLog(@"%@",index);
    NSLog(@">>>>>%@",selected);
    NSLog(@"......%@",cityDic);
    NSLog(@"====%@",_city);
    NSLog(@"/......../%@",_district);
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BFLog(@"viewWillAppear");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 20;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BFCurrentLocationCell *cell = [BFCurrentLocationCell cellWithTableView:tableView];
        cell.status = [CLLocationManager authorizationStatus];
        cell.delegate = self;

        return cell;
    }else if (indexPath.section == 1) {
        BFHotCityCell *cell = [BFHotCityCell cellWithTableView:tableView];
        self.cellHeight = cell.cellHeight;
        cell.delegate = self;
         return cell;
    }else {
        static NSString *str = @"reuse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text = @"测试";
         return cell;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (void)hotCity{

    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- 跳转传值城市
- (void)goBackToHomeWithCity:(NSString *)city {
    _cityBlock(city);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 最热城市传值
- (void)chooseHotCity:(NSString *)city {
    _cityBlock(city);
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark --- 去设置
- (void)goToSettingInterface {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
    //添加取消按钮
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];
    //添加设置定位
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];           [[UIApplication sharedApplication] openURL:url];
            
        }
    }];
    [alertController addAction:cancleAction];
    [alertController addAction:settingAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return self.cellHeight;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    view.backgroundColor = BFColor(0xF0F1F2);
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.textColor = BFColor(0xACACAC);
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(10)];
    if (section == 0) {
        label.text = @"   当前位置";
    }else if (section == 1) {
        label.text = @"   热门城市";
    }else {
        label.text = @"   省市列表";
    }
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    [self getDate:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:_district];
    [self.tableView reloadData];
}




@end
