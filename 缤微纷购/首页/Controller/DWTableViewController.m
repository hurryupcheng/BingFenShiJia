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

@interface DWTableViewController ()<UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate, SettingLocationDelegate, ChooseCurrentCityDelegate>
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

@property (nonatomic,retain)UIButton *hotBut;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self getDate:0];
    
    [self.view addSubview:self.tableView];
    self.title = @"城市列表";
    UIBarButtonItem *back = [UIBarButtonItem itemWithTarget:self action:@selector(backToHome) image:@"iconfont-htmal5icon37" highImage:@"iconfont-htmal5icon37"];
    self.navigationItem.leftBarButtonItem = back;
    //如果定位状态改变，接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoReload) name:@"reloadData" object:nil];
}

- (void)backToHome {
    BFLog(@"asdasdasd");
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return _dataArray.count;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BFCurrentLocationCell *cell = [BFCurrentLocationCell cellWithTableView:tableView];
        cell.status = [CLLocationManager authorizationStatus];
        //BFLog(@"到这里来了%d",[CLLocationManager authorizationStatus]);
        cell.delegate = self;
        cell.cityDelegate = self;
        return cell;
    }else if (indexPath.section == 1) {
        BFHotCityCell *cell = [BFHotCityCell cellWithTableView:tableView];
        self.cellHeight = cell.cellHeight;
        self.hotBut = cell.cityButton;
//        cell.backgroundColor = [UIColor whiteColor];
        [self.hotBut addTarget:self action:@selector(hotCity) forControlEvents:UIControlEventTouchUpInside];
         return cell;
    }else {
        static NSString *str = @"reuse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text = _dataArray[indexPath.row];
//        NSLog(@"/////%@",_dataArray[indexPath.row]);
         return cell;
    }
   
}
- (void)hotCity{
    NSLog(@"%@",self.hotBut.titleLabel.text);
//    _cityBlock(self.hotBut.titleLabel.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goBackToHome {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark --- 
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
    NSLog(@"%d",indexPath.row);
    [self getDate:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:_district];
    [self.tableView reloadData];
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
