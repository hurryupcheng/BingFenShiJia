//
//  HomeViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
//#import "SoSoViewController.h"
#import "BFSosoViewController.h"
#import "BFPTViewController.h"
#import "BFHomeCollentionView.h"

#import "PTXQViewController.h"
#import "Height.h"
#import "PTModel.h"
#import "PTTableViewCell.h"
#import "DWTableViewController.h"
#import "FXQViewController.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "HomeModel.h"
#import "FooterCollectionReusableView.h"
#import "HeaderCollectionReusableView.h"
#import "XCCollectionViewCell.h"
#import "XQViewController.h"
#import "Header.h"
#import "LBView.h"
#import "HomeViewController.h"
#import "BFPTDetailViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController ()

@property (nonatomic,retain)BFHomeCollentionView *homeVC;
@property (nonatomic,retain)BFPTViewController *ptVC;


@property (nonatomic,retain)UIView *butView;
@property (nonatomic,retain)UIButton *selectButton;

@property (nonatomic,retain)HeaderCollectionReusableView *headerView;
@property (nonatomic,retain)FooterCollectionReusableView *footerView;
@property (nonatomic,retain)LBView *lbView;
@property (nonatomic,retain)UITableView *tableV;
@property (nonatomic,retain)UIScrollView *scrollV;
@property (nonatomic,retain)UIView *viewBut;
@property (nonatomic,retain)UICollectionView *collentionView;

@property (nonatomic,retain)HomeSubModel *homeSubModel;
@property (nonatomic,retain)HomeModel *homeModel;
@property (nonatomic,retain)HomeOtherModel *homeOtherModel;
@property (nonatomic,retain)UIButton *button;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSMutableArray *itemsArray;
@property (nonatomic,retain)NSArray *titleArr;
@property (nonatomic,assign)NSInteger headerSection;
@property (nonatomic,retain)PTModel *pt;
@property (nonatomic,retain)NSMutableArray *ptLBView;

@property (nonatomic,retain)UIButton *footImageView;
@property (nonatomic,retain)UIButton *upImageView;
@property (nonatomic,retain)UIView *upBackView;


/**城市*/
@property (nonatomic, strong) NSString * currentCity;

/***/
@property (nonatomic, strong) UIButton *locationButton;
@end

@implementation HomeViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    [self initwithSegment];
    [self initVC];
    
    //获取定位
    //[self getAddress];
    

  }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentCity"];
    NSString *city = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    
    BFLog(@"========%@",city);

    if (city == nil) {
        DWTableViewController *dwVC = [[DWTableViewController alloc]init];
        dwVC.cityBlock = ^(NSString *city) {
            BFLog(@"++++++++++++%@",city);
            self.currentCity = city;
            
            if (self.currentCity.length != 0) {
                NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:city];
                [[NSUserDefaults standardUserDefaults] setObject:newData forKey:@"CurrentCity"];
                [self.locationButton  setTitle:city forState:UIControlStateNormal];
                self.currentCity = @"";
            }
            
            
        };
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dwVC];
        [self presentViewController:navigationController animated:YES completion:nil];

    }else {
        [self.locationButton  setTitle:city forState:UIControlStateNormal];
    }
    

    //BFLog(@"asdadasd");
    self.navigationController.navigationBar.barTintColor = rgb(69, 130, 242, 1.0);
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
}


- (void)initwithSegment{
    
    
    self.butView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BF_ScaleFont(160), CGFloatX(25))];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, BF_ScaleFont(80), CGFloatX(25))];
    _button.backgroundColor = [UIColor whiteColor];
    _button.layer.cornerRadius = CGFloatX(10);
    _button.layer.masksToBounds = YES;
    _button.selected = YES;
    _button.tag = 100;
    [_button setTitle:@"缤纷商城" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(14)];
    [_button setTitleColor:BFColor(0x0977ca) forState:UIControlStateSelected];
    [_button addTarget:self action:@selector(setControll:) forControlEvents:UIControlEventTouchUpInside];
    
    self.but = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_button.frame)-15, 0, BF_ScaleFont(80), CGFloatX(25))];
    _but.backgroundColor = rgb(43, 97, 196, 1.0);
    _but.layer.cornerRadius = CGFloatX(10);
    _but.layer.masksToBounds = YES;
    [_but setTitle:@"缤纷拼团" forState:UIControlStateNormal];
    _but.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(14)];
    _but.tag = 200;
    [_but setTitleColor:BFColor(0x0977ca) forState:UIControlStateSelected];
    [_but addTarget:self action:@selector(setControll:) forControlEvents:UIControlEventTouchUpInside];
    [self.butView addSubview:_but];
    [self.butView addSubview:_button];
    self.navigationItem.titleView = self.butView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-sousuo-3.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(soso)];
    
    CGRect frame = CGRectMake(0, 22, BF_ScaleFont(70), 44);
    // UIButton *button = [UIButton buttonWithFrame:frame title:text image:image font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
    //button.backgroundColor = [UIColor redColor];
    UIButton *locationButton = [UIButton buttonWithType:0];
    self.locationButton = locationButton;
    locationButton.frame = frame;
    //[button setTitle:title forState:UIControlStateNormal];
    [locationButton setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    locationButton.imageView.contentMode = UIViewContentModeCenter;
    locationButton.contentMode = UIViewContentModeCenter;
    [locationButton setImage:[UIImage imageNamed:@"4.pic_hd"] forState:UIControlStateNormal];
    locationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    locationButton.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
    [locationButton addTarget:self action:@selector(clickToChangeCity) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *location = [[UIBarButtonItem alloc] initWithCustomView:locationButton];
    
    
    BFLog(@"dianjile %@,,,",self.currentCity);
    UIBarButtonItem *leftSpace = [UIBarButtonItem leftSpace:BF_ScaleFont(-10)];
    self.navigationItem.leftBarButtonItems = @[leftSpace,location];
    
    
    
}


- (void)initVC{
    self.homeVC = [[BFHomeCollentionView alloc]init];
    self.ptVC = [[BFPTViewController alloc]init];
    
    [self addChildViewController:self.homeVC];
    [self addChildViewController:self.ptVC];
    
    [self.view addSubview:self.homeVC.view];
    [self.view addSubview:self.ptVC.view];
    [self.view bringSubviewToFront:self.homeVC.view];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.translucent = YES;
//}

//- (void)changeCurrentCity:(NSNotification *)notification {
//    self.currentCity = notification.userInfo[@"city"];
//    
//}
//
//
//- (void)currentCity:(NSNotification *)notification {
//    
//    self.currentCity = notification.userInfo[@"city"];
//    
//    //[self.tableV reloadData];
//}

//- (void)dealloc {
//    [BFNotificationCenter removeObserver:self];
//}

/*
- (void)updateViewCtrl{
    
//    [self initWithCollectionView];
    [self initWithOtherView];
}

*/



#pragma mark -- 定位按钮点击
- (void)clickToChangeCity {
    DWTableViewController *dwVC = [[DWTableViewController alloc]init];
    dwVC.cityBlock = ^(NSString *city) {
        self.currentCity = city;
        if (self.currentCity.length != 0) {
            NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:city];
            [[NSUserDefaults standardUserDefaults] setObject:newData forKey:@"CurrentCity"];
            [self.locationButton  setTitle:city forState:UIControlStateNormal];
            self.currentCity = @"";
        }
        [self.tableV reloadData];
        BFLog(@"=====%@", city);
    };
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dwVC];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark 分类列表初始化
- (void)initWithBut{
    
    self.viewBut = [[UIView alloc]init];
    self.viewBut.backgroundColor = [UIColor redColor];
    
    if (self.titleArr.count <= 4) {
        self.viewBut.frame = CGRectMake(0, CGRectGetMaxY(self.lbView.frame), kScreenWidth, (but_x)+20);
    }else{
        self.viewBut.frame = CGRectMake(0, CGRectGetMaxY(self.lbView.frame), kScreenWidth, ((but_x)*2)+20);
    }
    
    for (int i = 0; i < 8; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *backView = [[UIView alloc]init];
        backView.frame = CGRectMake((i%4+1)*5+(i%4)* (but_x),(i/4+1)*5+(i/4)*(but_x), but_x, but_x);
       
//        button.tag = 10 + i;
//        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, image_x-5, image_x-5)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"iicon0%d.png",i+1]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), but_x, 20)];
        label.text = [NSString stringWithFormat:@"%@",self.titleArr[i]];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:CGFloatY(14)];
        
        [backView addSubview:image];
        [backView addSubview:label];
        [self.headerView addSubview:self.viewBut];
        [self.viewBut addSubview:backView];
    }
}
#pragma  mark 首页切换
- (void)setControll:(UIButton *)button{
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    switch (button.tag) {
        case 100:{

            [self.butView bringSubviewToFront:button];

            self.button.backgroundColor = [UIColor whiteColor];
            self.but.backgroundColor = rgb(43, 97, 196, 1.0);
            [self.view bringSubviewToFront:self.homeVC.view];
        }
            break;
        case 200:{
            
            [self.butView bringSubviewToFront:button];

            self.button.backgroundColor = rgb(43, 97, 196, 1.0);
            self.button.selected = NO;
            self.but.backgroundColor = [UIColor whiteColor];
            [self.view bringSubviewToFront:self.ptVC.view];
        }
            break;
        default:
            break;
    }

}

#pragma  mark 搜索按钮点击事件
- (void)soso{
 
//    SoSoViewController *soso = [[SoSoViewController alloc]init];
    BFSosoViewController *soso = [[BFSosoViewController alloc]init];
//    BFSosoViewController *soso = [[BFSosoViewController alloc]init];
//    UINavigationController * sosoNav = [[UINavigationController alloc] initWithRootViewController:soso];
//    [sosoNav setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//    [self presentViewController:sosoNav animated:YES completion:nil];
    [self.navigationController pushViewController:soso animated:YES];
}



@end
