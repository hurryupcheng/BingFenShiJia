//
//  BFSosoHistoryViewController.m
//  缤微纷购
//
//  Created by Wind on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFSosoHistoryViewController.h"
#import "BFSosoTVCell.h"
#import "Header.h"

@interface BFSosoHistoryViewController ()
{
    NSUserDefaults * HFSosoHistoryDe;
}
@property (nonatomic, strong) NSMutableArray * SosoHistoryArr;
@end

@implementation BFSosoHistoryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog( @"%@", NSHomeDirectory());
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SosoHistoryEvent:) name:@"HFSosoEvent" object:nil];
    
    HFSosoHistoryDe = [NSUserDefaults standardUserDefaults];
    
    _SosoHistoryArr = [HFSosoHistoryDe valueForKey:@"HFSosoHistoryData"];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)SosoHistoryEvent:(NSNotification *)not
{
    _SosoHistoryArr = [NSMutableArray array];
    
    _SosoHistoryArr = [HFSosoHistoryDe valueForKey:@"HFSosoHistoryData"];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = YES;
    
    UIButton * clearButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [clearButton setTitle:@"清空搜索记录" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [clearButton setTitleColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [clearButton addTarget:self action:@selector(clearBut) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = clearButton;
}

// 清楚历史纪录
- (void)clearBut{
    [HFSosoHistoryDe setValue:nil forKey:@"HFSosoHistoryData"];
     _SosoHistoryArr = [HFSosoHistoryDe valueForKey:@"HFSosoHistoryData"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _SosoHistoryArr.count>0? _SosoHistoryArr.count:0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    BFSosoTVCell * cell = [BFSosoTVCell BFSosoTVCell:tableView];
    
    cell.HFSosoTitleLabel.text = _SosoHistoryArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight/10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //主动取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString * keyWord = [_SosoHistoryArr[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HFSosoEvent" object:keyWord];
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
