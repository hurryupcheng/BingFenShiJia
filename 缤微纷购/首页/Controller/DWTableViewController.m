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

@interface DWTableViewController ()<UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**热门城市cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/**定位管理*/
@property (nonatomic, strong) CLLocationManager * manager;
/**城市*/
@property (nonatomic, strong) NSString * currentCity;
@end

@implementation DWTableViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[BFHotCityCell class] forCellReuseIdentifier:@"HotCity"];
        [_tableView registerClass:[BFCurrentLocationCell class] forCellReuseIdentifier:@"currentCity"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"城市列表";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAddress];
    BFLog(@"viewWillAppear%@",self.currentCity);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

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
        return cell;
    }else if (indexPath.section == 1) {
        BFHotCityCell *cell = [BFHotCityCell cellWithTableView:tableView];
        self.cellHeight = cell.cellHeight;
         return cell;
    }else {
        static NSString *str = @"reuse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
         return cell;
    }
   
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

- (void)getAddress{
    self.manager = [[CLLocationManager alloc]init];
    self.manager.delegate = self;
    //用于判断当前是ios7.0还是ios8.0
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        //NSLocationAlwaysUsageDescription   允许在前后台都可以授权
        //        NSLocationWhenInUseUsageDescription   允许在前台授权
        //手动授权
        
        //        主动请求前后台授权
        [self.manager requestAlwaysAuthorization];
        
        //主动请求前台授权
        //                [self.mgr requestWhenInUseAuthorization];
    }else {
        [self.manager startUpdatingLocation];
    }
    
}
//判断授权状态
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //开启定位
        [self.manager startUpdatingLocation];
        // 定位的精确度
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        //        //每隔一点距离定位一次 （单位：米）
        //        self.mgr.distanceFilter = 10;
    }
    
}
//获取定位的位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%@",locations);
    //获取我当前的位置
    CLLocation *location = [locations lastObject];
    
    //停止定位
    [self.manager stopUpdatingLocation];
    //地理反编码
    //创建反编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //调用方法，使用位置反编码对象获取位置信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *place = [placemarks lastObject];
        //        for (CLPlacemark *place in placemarks) {
        if (place == nil) {
            return ;
        }
        self.currentCity = place.locality;
        
        //[NSKeyedArchiver archiveRootObject:place.locality toFile:self.cityPath];
        
        
        //<<<<<<< HEAD
        //            self.userCity = place.locality;
        //        self.currentCity = self.userCity;
        //
        ////            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"为你定位到%@，是否从%@切换到当前城市",self.userCity,self.currentCity] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        ////            [alert show];
        ////        }
        //=======
        
    }];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
