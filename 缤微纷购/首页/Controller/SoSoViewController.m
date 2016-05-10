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
//#import "BFSosoTVCell.h"

@interface SoSoViewController ()<UISearchDisplayDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate>
{
    NSUserDefaults * SosoHistoryDe;
}
@property (nonatomic,retain)UISearchBar *search;
@property (nonatomic,retain)UISegmentedControl *segment;

/**搜索历史*/
@property (nonatomic , strong) NSMutableArray * SosoHistoryArr;
@end

@implementation SoSoViewController

- (void)viewWillAppear:(BOOL)animated{
      [self initWithSearchBar];
    //    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
  
    SosoHistoryDe = [NSUserDefaults standardUserDefaults];
    _SosoHistoryArr = [SosoHistoryDe valueForKey:@"HFSosoHistoryData"];
    
    UIButton * right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 40, 20);
    right.titleLabel.font = [UIFont systemFontOfSize:15];
    [right setTitle:@"取消" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor colorWithRed:78/255.0 green:79/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(sosoBut) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(sosoBut)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SosoEvent) name:@"BFSosoBack" object:nil];
}
#pragma  mark 观察点击历史搜索
- (void)SosoEvent{
    self.segment.selectedSegmentIndex = 0;
    [self.view bringSubviewToFront:self.HotSosoVc.view];
}

- (void)back{
    [_search resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self initWithSenment];
//    [self initWithSearchBar];
    [self initVC];
    self.view.userInteractionEnabled = YES;
    
//    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sosoViewTapped:)];
//    taps.delegate = self;
//    taps.numberOfTouchesRequired = 1;
//    [self.view addGestureRecognizer:taps];
}

//- (void)sosoViewTapped:(UITapGestureRecognizer *)tap
//{
//    [_search resignFirstResponder];
//}

#pragma -mark 初始化UISegmentedControl
- (void)initWithSenment{
    
    NSArray *arr = @[@"热门搜索",@"搜索历史"];
    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    self.segment.frame = CGRectMake(15, 10, kScreenWidth-30, CGFloatY(30));
    self.segment.tintColor = [UIColor colorWithRed:75/255.0 green:145/255.0 blue:211/255.0 alpha:1];
    [self.segment addTarget:self action:@selector(selectedHot:) forControlEvents:UIControlEventValueChanged];
    self.segment.selectedSegmentIndex = 0;
    
    [self.view addSubview:self.segment];

}

#pragma -mark  SearchBar
- (void)initWithSearchBar{

//    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    
//    [self.search setBarTintColor:[UIColor grayColor]];
    _search = [[UISearchBar alloc]init];
    self.navigationItem.titleView = _search;
    _search.delegate = self;
    _search.barStyle = UIBarStyleBlack;
    _search.placeholder = @"搜索";
    // Get the instance of the UITextField of the search bar
    
//    UITextField *searchField = [_search valueForKey:@"_searchField"];

    // Change search bar text color
//    searchField.delegate = self;
//    searchField.textColor = [UIColor whiteColor];//
//    searchField.keyboardType = UIKeyboardTypeWebSearch;
    // Change the search bar placeholder text color
//    [searchField setValue:[UIColor whiteColor]forKeyPath:@"_placeholderLabel.textColor"];
    
    _search.clearsContextBeforeDrawing = YES;
    
//    [[_search.subviews objectAtIndex:0]removeFromSuperview];
//    [self.search setShowsCancelButton:YES];
//    for (UIView *view in [[_search.subviews lastObject] subviews]) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *but = (UIButton *)view;
//            [but setTitle:@"取消" forState:UIControlStateNormal];
//            [but  setTintColor:[UIColor blackColor]];
//            [but setTitleColor:[UIColor colorWithRed:78/255.0 green:79/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
//            [but addTarget:self action:@selector(sosoBut) forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
//    UIView *segment = [_search.subviews objectAtIndex:0];
//    UIImageView *bgImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"12"]];
//    [segment addSubview:bgImage];
    
//    [self.navigationItem setTitleView:_search];
    
//    UISearchDisplayController *display = [[UISearchDisplayController alloc]initWithSearchBar:_search contentsController:self];
//    
//    display.searchResultsDataSource = self;
//    display.searchResultsDelegate = self;

}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    //edit your code
    self.segment.selectedSegmentIndex = 0;
    [self selectedHot:self.segment];
   
    NSString * keyWord = [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (_SosoHistoryArr.count > 0) {
        NSMutableArray * arr = _SosoHistoryArr;
        
        _SosoHistoryArr = [NSMutableArray array];
        [_SosoHistoryArr addObject:searchBar.text];
        [_SosoHistoryArr addObjectsFromArray:arr];
    }
    else
    {
        _SosoHistoryArr = [NSMutableArray array];
        [_SosoHistoryArr addObject:searchBar.text];
    }
    
    [SosoHistoryDe setValue:_SosoHistoryArr forKey:@"HFSosoHistoryData"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HFSosoEvent" object:keyWord];
}


- (void)sosoBut{
   
    [_search resignFirstResponder];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma -mark 初始化 VC
- (void)initVC
{
//    [self selectedHot:self.segment];
    self.HotSosoVc = [[BFHotViewController alloc] init];
    self.SosoHistoryVc = [[BFSosoHistoryViewController alloc] init];
    
    [self addChildViewController:self.HotSosoVc];
    [self addChildViewController:self.SosoHistoryVc];
    
    [self.view addSubview:self.HotSosoVc.view];
    [self.view addSubview:self.SosoHistoryVc.view];
    
    CGRect rect = self.view.bounds;
    rect.origin.y += 20 + self.segment.frame.size.height;
    rect.size.height -= 20 + self.segment.frame.size.height;
    
    self.SosoHistoryVc.view.frame = self.HotSosoVc.view.frame = rect;
    [self.view bringSubviewToFront:self.HotSosoVc.view];
}

#pragma -mark 搜索切换
- (void)selectedHot:(UISegmentedControl *)segment{
    
    NSInteger index = segment.selectedSegmentIndex;
    
    switch (index) {
        case 0:{
            [self.view bringSubviewToFront:self.HotSosoVc.view];
        }
            break;
        case 1:{
            [self.view bringSubviewToFront:self.SosoHistoryVc.view];
        }
            break;
        default:
            break;
    }
}
//// 清楚历史纪录
//- (void)clearBut{
//    [self.tableV removeFromSuperview];
//    [self.clearButton removeFromSuperview];
//}

//- (NSMutableArray *)dateArr{
//    if (!_dateArr) {
//        _dateArr = [NSMutableArray array];
//    }
//    return _dateArr;
//}


@end
