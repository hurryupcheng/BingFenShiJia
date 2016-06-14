//
//  BFIntegralRuleController.m
//  缤微纷购
//
//  Created by 程召华 on 16/6/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFIntegralRuleController.h"

@interface BFIntegralRuleController ()
/**tableview*/
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation BFIntegralRuleController

#pragma mark -懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(718.5))];
        [self.view addSubview:_scrollView];
        UIImageView *rule = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(718.5))];
        rule.image = [UIImage imageNamed:@"integral"];
        [_scrollView addSubview:rule];
    }
    return _scrollView;
}


#pragma mark -viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"101"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建滚动视图
    [self scrollView];
    //创建返回按钮
    [self setUpBackButton];

}

#pragma mark -创建返回按钮
- (void)setUpBackButton {
    UIButton *back = [UIButton buttonWithType:0];
    back.frame = CGRectMake(5, 22, 35, 40);
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark --viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

@end
