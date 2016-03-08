//
//  SoSoViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Header.h"
#import "SoSoViewController.h"

@interface SoSoViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>

@property (nonatomic,retain)UISearchBar *search;
@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,retain)UISegmentedControl *segment;
@property (nonatomic,retain)UIView *hotView;
@property (nonatomic,retain)UIButton *clearButton;
@property (nonatomic,retain)NSMutableArray *dateArr;

@end

@implementation SoSoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithSenment];
    [self initWithhot];
    [self initWithSearchBar];
    self.dateArr = [NSMutableArray arrayWithObjects:@"11",@"22",@"33",@"44",@"55", nil];
}

#pragma  mark 初始化UISegmentedControl
- (void)initWithSenment{
    
    NSArray *arr = @[@"热门搜索",@"搜索历史"];
    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    self.segment.frame = CGRectMake(20, 10, kScreenWidth-40, BF_ScaleHeight(25));
    
    [self.segment addTarget:self action:@selector(selectedHot:) forControlEvents:UIControlEventValueChanged];
    self.segment.selectedSegmentIndex = 0;
    
    [self.view addSubview:self.segment];

}

#pragma  mark  SearchBar
- (void)initWithSearchBar{

    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    _search.placeholder = @"搜索";
    _search.clearsContextBeforeDrawing = YES;
//    search.backgroundColor = [UIColor redColor];
    
    [self.search setShowsCancelButton:YES];
    for (UIView *view in [[_search.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *but = (UIButton *)view;
            [but setTitle:@"取消" forState:UIControlStateNormal];
            [but addTarget:self action:@selector(sosoBut) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [self.navigationItem setTitleView:_search];
    
    UISearchDisplayController *display = [[UISearchDisplayController alloc]initWithSearchBar:_search contentsController:self];
    
    display.searchResultsDataSource = self;
    display.searchResultsDelegate = self;

}

- (void)sosoBut{
    
    NSLog(@"11111");
}


#pragma  makr 热门搜索
- (void)initWithhot{
  
    self.hotView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segment.frame)+10, kScreenWidth, kScreenHeight)];
    self.hotView.userInteractionEnabled = YES;
    
    CGFloat x = kScreenWidth/4-13;
    UILabel *hot = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 30)];
    hot.text = @"热门搜索词";
    
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hot.frame), kScreenWidth, 100)];
    
    NSArray *arr = @[@"测试",@"测试数据",@"测试",@"测试数据",@"测试数据",@"测试数据",@"测试数",@"测试数据",@"测试数据"];
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((i%4+1)*10+(i%4)* x,(i/4+1)*10+(i/4)*30, x, 30)];
        
        button.tag = i;
        button.layer.cornerRadius = 8;
        button.layer.borderColor = [UIColor blueColor].CGColor;
        button.layer.borderWidth = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:CGFloatY(17)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [buttonView addSubview:button];
    }
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 160, kScreenWidth-30, 30)];
    lab.text = @"猜你喜欢";
    
    for (int j = 0; j < 2; j++) {
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake((j%2+1)*10+(j%2)*((kScreenWidth-30)/2),CGRectGetMaxY(lab.frame)+(j/2+1)*10+(j/2)*((kScreenWidth-30)/2), (kScreenWidth-30)/2, (kScreenWidth-30)/2)];
        
        but.layer.cornerRadius = 10;
        but.layer.borderColor = [UIColor blueColor].CGColor;
        but.layer.borderWidth = 1;
        but.tag = 100+j;
        
        [self.hotView addSubview:but];
    }
    
    [self.hotView addSubview:buttonView];
    [self.view addSubview:self.hotView];
    [self.hotView addSubview:hot];
    [self.hotView addSubview:lab];
}
#pragma  mark 初始化tableView
- (void)initWithTableView{
   
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segment.frame)+10, kScreenWidth, kScreenHeight-200)];
    
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.showsVerticalScrollIndicator = NO;
    
    self.clearButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableV.frame), kScreenWidth, 30)];
    [self.clearButton setTitle:@"清空搜索记录" forState:UIControlStateNormal];
    [self.clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearBut) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.clearButton];
    [self.view addSubview:self.tableV];
    
}

#pragma  mark  tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dateArr.count>0?self.dateArr.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *str = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = self.dateArr[indexPath.row];
    return cell;
}
//  搜索切换
- (void)selectedHot:(UISegmentedControl *)segment{
  
    NSInteger index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:{
            [self.tableV removeFromSuperview];
            [self initWithhot];
            [self.clearButton removeFromSuperview];
        }
            break;
        case 1:{
            [self.hotView removeFromSuperview];
            if (self.dateArr.count == 0) {
                [self.tableV removeFromSuperview];
                [self.clearButton removeFromSuperview];
            }else{
            [self initWithTableView];
            }
        }
            break;
        default:
            break;
    }
}
// 清楚历史纪录
- (void)clearBut{
    [self.tableV removeFromSuperview];
    [self.clearButton removeFromSuperview];
}

- (NSMutableArray *)dateArr{
    if (!_dateArr) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.tabBarController.tabBar.hidden = YES;
}


@end
