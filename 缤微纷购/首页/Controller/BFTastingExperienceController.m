//
//  BFTastingExperienceController.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFTastingExperienceController.h"
#import "BFShareView.h"


@interface BFTastingExperienceController ()<UITableViewDelegate, UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**数组*/
@property (nonatomic, strong) NSArray *listArray;
@end

@implementation BFTastingExperienceController

#pragma mark --懒加载

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"图文详情", @"试吃规则", @"试吃体验"];
    }
    return _listArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight-22)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.backgroundColor = BFColor(0xF4F4F4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark --viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"免费试吃";
    self.view.backgroundColor = BFColor(0xffffff);
    self.navigationController.navigationBar.barTintColor = BFColor(0xffffff);
    self.tabBarController.tabBar.hidden = YES;
    //添加tableviewView
    [self tableView];
    //添加navigationbar
    [self setUpNavigationBar];
    //加载数据
    [self getData];
}

#pragma mark -- 加载数据
- (void)getData {
    NSString *url = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=seckill_item&id="];
    [BFHttpTool GET:url params:nil success:^(id responseObject) {
        BFLog(@"%@", responseObject);
        if (responseObject) {
            
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.tableView.y = 0;
        }];
        
    } failure:^(NSError *error) {
        BFLog(@"%@", error);
    }];
}


#pragma mark -- 设置客服按钮
- (void)setUpNavigationBar {
    UIButton *share = [UIButton buttonWithType:0];
    //telephone.backgroundColor = [UIColor redColor];
    share.width = 30;
    share.height = 30;
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [share setImage:[UIImage imageNamed:@"iconfont-fenxiang-6"] forState:UIControlStateNormal];
    UIBarButtonItem *telephoneItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    self.navigationItem.rightBarButtonItem = telephoneItem;
}

- (void)share {
    id<ISSContent> publishContent = [ShareSDK content:@"测试测试"
                                       defaultContent:@"ddsf"
                                                image:nil
                                                title:@"这是一个分享测试"
                                                  url:@"www.baidu.com"
                                          description:@"哈哈哈"
                                            mediaType:SSPublishContentMediaTypeNews];
    //调用自定义分享
    BFShareView *share = [BFShareView shareView:publishContent];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:share];
}


#pragma mark -- tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.listArray[indexPath.row];
    
    return cell;
}



@end
