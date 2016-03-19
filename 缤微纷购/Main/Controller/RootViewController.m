//
//  RootViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Header.h"
#import "BFLogisticsAndAfterSaleController.h"
#import "HomeViewController.h"
#import "ClassificationViewController.h"
#import "ShoppingViewController.h"
#import "PersonalViewController.h"
#import "RootViewController.h"
#import "BFNavigationController.h"

@interface RootViewController ()

@property (nonatomic,retain)HomeViewController *homeVC;
@property (nonatomic,retain)ClassificationViewController *classFVC;
@property (nonatomic,retain)ShoppingViewController *shoppVC;
@property (nonatomic,retain)PersonalViewController *personalVC;
@property (nonatomic,retain)BFLogisticsAndAfterSaleController *shVC;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBar.translucent = NO;
    NSArray *array = @[@"首页",@"购物车",@"个人中心",@"分类",@"物流·售后"];
    self.homeVC = [[HomeViewController alloc]init];
   
    [self setController:self.homeVC title:array[0] image:@"icon_01.png" selectImage:@"icon_11.png"];
    
    self.shoppVC = [[ShoppingViewController alloc]init];
    [self setController:self.shoppVC title:array[1] image:@"icon_02.png" selectImage:@"icon_12.png"];
    
    self.personalVC = [[PersonalViewController alloc]init];
    [self setController:self.personalVC title:array[2] image:@"icon_03.png" selectImage:@"icon_13.png"];
    [self.personalVC.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:rgb(0, 0, 128, 1.0)}];
    
    self.classFVC = [[ClassificationViewController alloc]init];
    [self setController:self.classFVC title:array[3] image:@"icon_04.png" selectImage:@"icon_14.png"];
    
    self.shVC = [[BFLogisticsAndAfterSaleController alloc]init];
    [self setController:self.shVC title:array[4] image:@"icon_05.png" selectImage:@"icon_15.png"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setController:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectimage{
    
    VC.tabBarItem.title = title;
    BFNavigationController *navigation = [[BFNavigationController alloc]initWithRootViewController:VC];
    [VC.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:CGFloatX(20)],NSForegroundColorAttributeName:[UIColor blueColor]}];
    //VC.navigationController.navigationBar.translucent = NO;
    VC.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.tintColor = [UIColor redColor];
    
    [self addChildViewController:navigation];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
