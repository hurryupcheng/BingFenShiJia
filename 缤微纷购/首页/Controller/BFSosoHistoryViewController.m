//
//  BFSosoHistoryViewController.m
//  缤微纷购
//
//  Created by Wind on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
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
   
//    NSLog( @"%@", NSHomeDirectory());
    
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
//    _SosoHistoryArr = [NSMutableArray array];
    
    _SosoHistoryArr = [HFSosoHistoryDe valueForKey:@"HFSosoHistoryData"];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = YES;
    
    UIButton * clearButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [clearButton setTitle:@"清空搜索记录" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(20)];
    [clearButton setTitleColor:BFColor(0x000000) forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [clearButton addTarget:self action:@selector(clearBut) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = clearButton;
}

// 清楚历史纪录
- (void)clearBut{
    
//    [HFSosoHistoryDe removeObjectForKey:@"HFSosoHistoryData"];
//    
//    [HFSosoHistoryDe synchronize];
    
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    
    NSDictionary* dict = [defs dictionaryRepresentation];
    
    for(id key in dict) {
        
        [defs  removeObjectForKey:key];
        
    }
    
    [defs synchronize];
    
    
//    [HFSosoHistoryDe setValue:nil forKey:@"HFSosoHistoryData"];
//    [HFSosoHistoryDe removeObjectForKey:@"HFSosoHistoryData"];
     _SosoHistoryArr = [HFSosoHistoryDe valueForKey:@"HFSosoHistoryData"];
   
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _SosoHistoryArr.count>0? _SosoHistoryArr.count:0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    BFSosoTVCell * cell = [BFSosoTVCell BFSosoTVCell:tableView];
    cell.HFSosoTitleLabel.text = _SosoHistoryArr[indexPath.row];
   
    cell.imageView.image = [UIImage imageNamed:@"iconfont-search.png"];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return kScreenHeight/10;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //主动取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString * keyWord = [_SosoHistoryArr[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HFSosoEvent" object:keyWord];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BFSosoBack" object:keyWord];
    
   
}


@end
