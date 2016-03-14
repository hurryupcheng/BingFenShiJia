//
//  BFNavigationController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFNavigationController.h"

@interface BFNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.delegate = self;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]init];
//    back.title = nil;
    self.navigationItem.backBarButtonItem = back;
    __weak typeof (self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //                self.interactivePopGestureRecognizer.enabled = YES;
        /* UIGestureRecognizerDelegate */
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }

}
+ (void)initialize
{
    
    
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = BFColor(0x1A2E90);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = BFColor(0x1A2E90);
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateHighlighted];
    
    //获取特定类的所有导航条
    
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
   // navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back_green"]];
    //    navigationBar.backIndicatorImage = [[UIImage imageNamed:@"back_green"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    navigationBar.backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"back_green"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, hua_scale(2.5)) forBarMetrics:UIBarMetricsDefault];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    navigationBar.titleTextAttributes = dict;
    
//    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : BFColor(0x1A2E90)}];
//    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:BF_ScaleFont(10)]}];
    
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"iconfont-htmal5icon37" highImage:@"iconfont-htmal5icon37"];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
#warning 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
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
