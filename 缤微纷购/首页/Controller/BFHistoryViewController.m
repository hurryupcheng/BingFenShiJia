//
//  BFHistoryViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "ViewController.h"
#import "BFURLEncodeAndDecode.h"
#import "BFHistoryViewController.h"

@interface BFHistoryViewController ()
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSUserDefaults *userDefaus;
@property (nonatomic,retain)UIButton *clearBut;
@property (nonatomic,retain)NSUserDefaults *userDefaultes;
@property (nonatomic,retain)UIView *line;
@end

@implementation BFHistoryViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIButton *)clearBut{
    if (!_clearBut) {
        
        _clearBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatX(40))];
        [_clearBut setTitle:@"清除历史纪录" forState:UIControlStateNormal];
        [_clearBut setTitleColor:rgb(190, 190, 190, 1.0) forState:UIControlStateNormal];
        [_clearBut addTarget:self action:@selector(clearData) forControlEvents:UIControlEventTouchUpInside];
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMinY(_clearBut.frame), kScreenWidth, 1.0)];
        _line.backgroundColor = rgb(220, 220, 220, 1.0);
        if (_dataArray.count != 0) {
            [_clearBut addSubview:_line];
        }

    }
    return _clearBut;
}

- (void)clearData{
  [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"BFHistory"];
    [_userDefaultes synchronize];
    [_dataArray removeAllObjects];
    [_line removeFromSuperview];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{

  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newHistoryData:) name:@"newHistory" object:nil];
}

- (void)newHistoryData:(NSNotification *)not{

    [_dataArray removeAllObjects];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"BFHistory"];
    _dataArray = [myArray mutableCopy];
    
    if (_dataArray.count != 0) {
        [_clearBut addSubview:_line];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

   [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"BFHistory"];
    _dataArray = [myArray mutableCopy];
    NSLog(@"myArray======%@  %@",myArray,_dataArray);
    
    [self clearBut];
    self.tableView.tableFooterView = _clearBut;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.imageView.image = [UIImage imageNamed:@"iconfont-search.png"];
    cell.textLabel.text = [BFURLEncodeAndDecode decodeFromPercentEscapeString:_dataArray[indexPath.row]];
    cell.textLabel.textColor = rgb(220, 220, 220, 1.0);

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BFHistory" object:_dataArray[indexPath.row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BFSosoBack" object:_dataArray[indexPath.row]];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
