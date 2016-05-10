//
//  BFSosoViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFHotView.h"
#import "Header.h"
#import "ViewController.h"
#import "BFSosoViewController.h"

@interface BFSosoViewController ()<UISearchDisplayDelegate, UIGestureRecognizerDelegate,UISearchBarDelegate>

@property (nonatomic,retain)UISearchBar *search;
@property (nonatomic,retain)UISegmentedControl *segment;
@property (nonatomic,retain)BFHotView *hotView;

@end

@implementation BFSosoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popView)];
}

- (void)popView{
    [_search resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initVC];
    [self initWithSearch];
    [self initWithSenment];
    
    
}

#pragma  mark 初始化搜索
- (void)initWithSearch{
    _search = [[UISearchBar alloc]init];
    self.navigationItem.titleView = _search;
    _search.delegate = self;
    _search.barStyle = UIBarStyleBlack;
    _search.placeholder = @"搜索";
    _search.clearsContextBeforeDrawing = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];

}

- (void)back{
    [_search resignFirstResponder];
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark 初始化UISegmentedControl
- (void)initWithSenment{
    
    NSArray *arr = @[@"热门搜索",@"搜索历史"];
    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    self.segment.frame = CGRectMake(15, 10, kScreenWidth-30, CGFloatY(30));
    self.segment.tintColor = rgb(75, 145, 211, 1);
    [self.segment addTarget:self action:@selector(selectedHot:) forControlEvents:UIControlEventValueChanged];
    self.segment.selectedSegmentIndex = 0;
    
    [self.view addSubview:self.segment];
    
}

#pragma -mark 初始化 VC
- (void)initVC
{
    self.hot = [[BFHotSoViewController alloc] init];
    self.history = [[BFHistoryViewController alloc] init];
    
    [self addChildViewController:self.hot];
    [self addChildViewController:self.history];
    
    [self.view addSubview:self.hot.view];
    [self.view addSubview:self.history.view];
    
    CGRect rect = self.view.bounds;
    rect.origin.y += 45 + self.segment.frame.size.height;
    rect.size.height -= 45 + self.segment.frame.size.height;
    
    self.hot.view.frame = self.history.view.frame = rect;
    [self.view bringSubviewToFront:self.hot.view];

}


- (void)selectedHot:(UISegmentedControl *)segment{
    NSInteger index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:{
        [self.view bringSubviewToFront:self.hot.view];
        }
            break;
        case 1:{
        [self.view bringSubviewToFront:self.history.view];
        }
            break;
            
        default:
            break;
    }
}

//- (BFHotView *)hotView{
//    if (!_hotView) {
//        _hotView = [[BFHotView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        [self.hot.view addSubview:_hotView];
//    }
//    return _hotView;
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSString *keyWord = [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BFsoso" object:keyWord];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
