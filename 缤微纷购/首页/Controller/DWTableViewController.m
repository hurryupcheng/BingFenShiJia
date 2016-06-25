//
//  DWTableViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "DWTableViewController.h"
#import "BFCityTableViewController.h"
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
/**省份数组*/
@property (nonatomic, strong) NSArray *provinceArray;



@end

@implementation DWTableViewController

#pragma mark -- 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)provinceArray {
    if (!_provinceArray) {
         NSString *path = [[NSBundle mainBundle]pathForResource:@"location" ofType:@"plist"];
        _provinceArray = [NSArray arrayWithContentsOfFile:path];

    }
    return _provinceArray;
}


#pragma mark -- viewDidLoad
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


#pragma mark -- 移除通知
- (void)dealloc {
    [BFNotificationCenter removeObserver:self];
}

#pragma mark -- 返回按钮
- (void)backToHome {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentCity"];
    NSString *city = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    BFLog(@"---====%@",city);
    if (city.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请选择所在城市" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
   
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 定位状态改变，刷新页面
- (void)gotoReload {
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.provinceArray.count;
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
        NSDictionary *provinceDictionary = self.provinceArray[indexPath.row];
        cell.textLabel.text = provinceDictionary[@"province"];
        NSArray *array = provinceDictionary[@"city"];
        if (array.count != 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
         return cell;
    }
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        BFCityTableViewController *cityVC = [[BFCityTableViewController alloc] init];
        NSDictionary *provinceDictionary = self.provinceArray[indexPath.row];
        NSArray *array = provinceDictionary[@"city"];
        cityVC.cityArray = array;
        if (array.count != 0) {
            cityVC.provinceDictionary = provinceDictionary;
            [self.navigationController pushViewController:cityVC animated:YES];
        }else {
            NSDictionary *provinceDictionary = self.provinceArray[indexPath.row];
            BFLog(@"=-=-=-%@", provinceDictionary[@"province"]);
            _cityBlock(provinceDictionary[@"province"]);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
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






@end
