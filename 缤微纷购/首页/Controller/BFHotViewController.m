//
//  BFHotSosoViewController.m
//  缤微纷购
//
//  Created by Wind on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFResultTableViewCell.h"
#import "FXQViewController.h"
#import "OMGToast.h"
#import "AFNTool.h"
#import "BFHotViewController.h"
#import "Header.h"
#import "ViewController.h"

@interface BFHotViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * hotView;
    UIView * searchView;
    NSUserDefaults * HotSosoHistoryDe;
    
}
/**热门搜索*/
@property (nonatomic, strong) NSMutableArray * HotSearArr;
/**猜你喜欢*/
@property (nonatomic, strong) NSMutableArray * LikeSearArr;
/**搜索结果*/
@property (nonatomic, strong) NSMutableArray * SearchWordArr;
/**搜索历史*/
@property (nonatomic, strong) NSMutableArray * HotSosoHistoryArr;
@property (nonatomic, retain) UIButton *LikeImage;

@property (nonatomic,retain)UITableView *tableView;
@end

@implementation BFHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    HotSosoHistoryDe = [NSUserDefaults standardUserDefaults];
    _HotSosoHistoryArr = [HotSosoHistoryDe valueForKey:@"HFSosoHistoryData"];
    [self hotViewS];
    [self downLoadData:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SosoEvent:) name:@"HFSosoEvent" object:nil];
}

- (void)initWithTable{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 200;
//    self.tableView.backgroundColor = [UIColor greenColor];
    
   [self.tableView registerClass:[BFResultTableViewCell class] forCellReuseIdentifier:@"reuse"];
 
    [self.view addSubview:self.tableView];
}

- (void)SosoEvent:(NSNotification *)not
{
    [self downLoadData:(NSString *)not.object];
    [hotView removeFromSuperview];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma -mark 数据请求
- (void)downLoadData:(NSString *)KeyWord
{
    if (KeyWord.length < 1) {
        KeyWord = @"%E6%B0%B4%E6%9E%9C";
    }
    
    NSString * url = [HFSEARCH stringByAppendingString:KeyWord];
    
    [AFNTool postJSONWithUrl:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = responseObject;
        
        _HotSearArr = [NSMutableArray array];
        _LikeSearArr = [NSMutableArray array];
        _SearchWordArr = [NSMutableArray array];
        
        if (dic) {
            
            _HotSearArr = dic[@"hot_item"];
            _LikeSearArr = dic[@"like_item"];
            if (![KeyWord isEqualToString:@"%E6%B0%B4%E6%9E%9C"]) {
                if (![dic[@"search_item"] isKindOfClass:[NSNull class]]) {
                    _SearchWordArr = dic[@"search_item"];
                }
                else
                {
                    [BFProgressHUD MBProgressFromView:self.view wrongLabelText:@"没有相关搜索结果"];
                }
                NSLog(@"=====%d",_SearchWordArr.count);
                [self initWithView];
                
            }
            
        }
        
        [self.tableView reloadData];
        
    } fail:^{
        
    }];
}

#pragma -makr 热门搜索
- (UIView *)hotViewS{
    
    hotView = [[UIView alloc] init];
    hotView.userInteractionEnabled = YES;
    
    CGFloat x = kScreenWidth/4-13;
    UILabel *hot = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 30)];
    hot.text = @"热门搜索词";
    
    CGFloat heights;
    if (_HotSearArr.count%4 == 0) {
        heights = _HotSearArr.count/4*30;
    }
    else
    {
        heights = (_HotSearArr.count/4+1)*30;
    }
    
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hot.frame), kScreenWidth, heights+10)];
    
    //    NSArray *arr = @[@"测试",@"测试数据",@"测试",@"测试数据",@"测试数据",@"测试数据",@"测试数",@"测试数据",@"测试数据"];
    for (int i = 0; i < _HotSearArr.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((i%4+1)*10+(i%4)* x,(i/4+1)*10+(i/4)*30, x, 30)];
        
        button.tag = i;
        button.layer.cornerRadius = 8;
        button.layer.borderColor = [UIColor colorWithRed:75/255.0 green:145/255.0 blue:211/255.0 alpha:1].CGColor;
        button.layer.borderWidth = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:CGFloatY(17)];
        NSDictionary * dic = _HotSearArr[i];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:75/255.0 green:145/255.0 blue:211/255.0 alpha:1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hotSearchEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview:button];
    }
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(buttonView.frame)+15, kScreenWidth-30, 30)];
    lab.text = @"猜你喜欢";
    
    for (int j = 0; j < _LikeSearArr.count; j++) {
        self.LikeImage = [[UIButton alloc]initWithFrame:CGRectMake((j%2+1)*10+(j%2)*((kScreenWidth-30)/2),CGRectGetMaxY(lab.frame)+(j/2+1)*10+(j/2)*((kScreenWidth-30)/2), (kScreenWidth-30)/2, (kScreenWidth-30)/2)];
        
        _LikeImage.layer.cornerRadius = 10;
        _LikeImage.layer.masksToBounds = YES;
        _LikeImage.layer.borderColor = [UIColor colorWithRed:75/255.0 green:145/255.0 blue:211/255.0 alpha:1].CGColor;
        _LikeImage.layer.borderWidth = 1;
        _LikeImage.tag = j;
        _LikeImage.userInteractionEnabled = YES;
        NSDictionary * dic = _LikeSearArr[j];
        //        [LikeImage sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]] placeholderImage:[UIImage imageNamed:@"100"]];
        [_LikeImage setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:dic[@"img"]] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
        
        [_LikeImage addTarget:self action:@selector(tapitem:) forControlEvents:UIControlEventTouchUpInside];
        
        [hotView addSubview:_LikeImage];
    }
    
    CGFloat LikeHeights;
    if (_LikeSearArr.count%2 == 0) {
        LikeHeights = (_LikeSearArr.count/2) * ((kScreenWidth-30)/2);
    }
    else
    {
        LikeHeights = (_LikeSearArr.count/2) * ((kScreenWidth-30)/2)+1;
    }
    
    //    hotView.frame = CGRectMake(0, 0, kScreenWidth, hot.frame.size.height+buttonView.frame.size.height+lab.frame.size.height+15+LikeHeights+40);
    hotView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_LikeImage.frame)+10);
    
    [hotView addSubview:buttonView];
    [hotView addSubview:hot];
    [hotView addSubview:lab];
    
    return hotView;
}

- (void)tapitem:(UIButton *)img{
    
    NSDictionary *dic = _LikeSearArr[img.tag];
    FXQViewController *fx = [[FXQViewController alloc]init];
    fx.ID = dic[@"id"];
    
    [self.navigationController pushViewController:fx animated:YES];
}

- (void)hotSearchEvent:(UIButton *)bu
{
    NSString * keyWord = [bu.titleLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self downLoadData:keyWord];
    
    if (_HotSosoHistoryArr.count > 0) {
        NSMutableArray * arr = _HotSosoHistoryArr;
        
        _HotSosoHistoryArr = [NSMutableArray array];
        [_HotSosoHistoryArr addObject:bu.titleLabel.text];
        [_HotSosoHistoryArr addObjectsFromArray:arr];
    }
    else
    {
        _HotSosoHistoryArr = [NSMutableArray array];
        [_HotSosoHistoryArr addObject:bu.titleLabel.text];
    }
    
    [HotSosoHistoryDe setValue:_HotSosoHistoryArr forKey:@"HFSosoHistoryData"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HFSosoEvent" object:keyWord];
}

//- (UIView *)SearchViewS
//{
//    searchView = [[UIView alloc] init];
//
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 30)];
//    lab.text = @"搜索结果";
//    [searchView addSubview:lab];

//    for (int j = 0; j < _SearchWordArr.count; j++) {
//        self.LikeImage = [[UIButton alloc]initWithFrame:CGRectMake((j%2+1)*10+(j%2)*((kScreenWidth-30)/2),CGRectGetMaxY(lab.frame)+(j/2+1)*10+(j/2)*((kScreenWidth-30)/2), (kScreenWidth-30)/2, (kScreenWidth-30)/2)];
//
//        _LikeImage.layer.cornerRadius = 10;
//        _LikeImage.layer.masksToBounds = YES;
//        _LikeImage.layer.borderColor = [UIColor colorWithRed:75/255.0 green:145/255.0 blue:211/255.0 alpha:1].CGColor;
//        _LikeImage.layer.borderWidth = 1;
//        _LikeImage.tag = j;
//        NSDictionary * dic = _SearchWordArr[j];
//        [_LikeImage setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:dic[@"img"]] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
//
//        [_LikeImage addTarget:self action:@selector(tapitems:) forControlEvents:UIControlEventTouchUpInside];
//
//        [searchView addSubview:_LikeImage];
//    }
//
//    CGFloat SearHeights;
//    if (_SearchWordArr.count%2 == 0) {
//        SearHeights = (_SearchWordArr.count/2) * ((kScreenWidth-30)/2);
//    }
//    else
//    {
//        SearHeights = (_SearchWordArr.count/2) * ((kScreenWidth-30)/2)+1;
//    }

//    searchView.frame = CGRectMake(0, 0, kScreenWidth, 15+lab.frame.size.height+SearHeights+10);
//    searchView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_LikeImage.frame)+10);

//    return self;
//}

- (void)tapitems:(UIButton *)img{
    
    NSDictionary *dic = _SearchWordArr[img.tag];
    FXQViewController *fx = [[FXQViewController alloc]init];
    fx.ID = dic[@"id"];
    
    [self.navigationController pushViewController:fx animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _SearchWordArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    
    return cell;
}

- (void)initWithView{
    if (_SearchWordArr.count >= 1) {
        [self initWithTable];
    }
    else
    {
        UIView * views = [self hotViewS];
        views.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self.view addSubview:views];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (_SearchWordArr.count > 0) {
//        UIView * view = [self SearchViewS];
//        return view.frame.size.height;
//    }
//    else
//    {
//        UIView * view = [self hotViewS];
//        return view.frame.size.height;
//    }
//    
//}


@end
