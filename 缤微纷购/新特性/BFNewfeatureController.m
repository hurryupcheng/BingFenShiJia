//
//  BFNewfeatureController.m
//  缤微纷购
//
//  Created by 程召华 on 16/5/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define BFNewfeatureCount 3
#import "BFNewfeatureController.h"
#import "RootViewController.h"
#import "BFNewfeaturePageControl.h"

@interface BFNewfeatureController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation BFNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i< BFNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        // 显示图片
        NSString *name = [NSString stringWithFormat:@"feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == BFNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
}


    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(BFNewfeatureCount * scrollW, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;

    // 4.添加pageControl：分页，展示目前看的是第几页
//    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    self.pageControl = pageControl;
//    pageControl.numberOfPages = BFNewfeatureCount;
//    //pageControl.backgroundColor = [UIColor redColor];
////    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"current_page"]];
////    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"page"] ];
////    pageControl.x = (ScreenWidth-100)/2;
////    pageControl.centerY = scrollH - 50;
////    pageControl.width = 100;
////    pageControl.height = 50;
//    [self.view addSubview:pageControl];
//    //[pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
//    [self pageChanged:pageControl];
//     //UIPageControl就算没有设置尺寸，里面的内容还是照常显示的
//    
//    pageControl.userInteractionEnabled = NO;

}

-(void)pageChanged:(UIPageControl*)pc{
    NSArray *subViews = pc.subviews;
    for (int i = 0; i < [subViews count]; i++) {
        UIView* subView = [subViews objectAtIndex:i];
        if ([NSStringFromClass([subView class]) isEqualToString:NSStringFromClass([UIImageView class])]) {
            ((UIImageView*)subView).image = (pc.currentPage == i ? [UIImage imageNamed:@"current_page"] : [UIImage imageNamed:@"page"]);
        }
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
    // 1.3四舍五入 1.3 + 0.5 = 1.8 强转为整数(int)1.8= 1
    // 1.5四舍五入 1.5 + 0.5 = 2.0 强转为整数(int)2.0= 2
    // 1.6四舍五入 1.6 + 0.5 = 2.1 强转为整数(int)2.1= 2
    // 0.7四舍五入 0.7 + 0.5 = 1.2 强转为整数(int)1.2= 1
}

/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
//    // 1.分享给大家（checkbox）
//    UIButton *shareBtn = [[UIButton alloc] init];
//    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
//    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
//    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
//    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    shareBtn.width = 200;
//    shareBtn.height = 30;
//    shareBtn.centerX = imageView.width * 0.5;
//    shareBtn.centerY = imageView.height * 0.65;
//    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//    [imageView addSubview:shareBtn];
//    //    shareBtn.backgroundColor = [UIColor redColor];
//    //    shareBtn.imageView.backgroundColor = [UIColor blueColor];
//    //    shareBtn.titleLabel.backgroundColor = [UIColor yellowColor];
//    
//    // top left bottom right
//    
//    // EdgeInsets: 自切
//    // contentEdgeInsets:会影响按钮内部的所有内容（里面的imageView和titleLabel）
//    //    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 100, 0, 0);
//    
//    // titleEdgeInsets:只影响按钮内部的titleLabel
//    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    
//    // imageEdgeInsets:只影响按钮内部的imageView
//    //    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 50);
//    
//    
//    
//    //    shareBtn.titleEdgeInsets
//    //    shareBtn.imageEdgeInsets
//    //    shareBtn.contentEdgeInsets
//    
//    // 2.开始微博
//    UIButton *startBtn = [[UIButton alloc] init];
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
//    startBtn.size = startBtn.currentBackgroundImage.size;
//    startBtn.centerX = shareBtn.centerX;
//    startBtn.centerY = imageView.height * 0.75;
//    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
//    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
//    [imageView addSubview:startBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [imageView addGestureRecognizer:tap];
    
}





- (void)click
{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[RootViewController alloc] init];
    

}




@end
