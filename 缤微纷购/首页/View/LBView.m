//
//  LBView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/8.
//  Copyright © 2016年 xinxincao. All rights reserved.
//


#import "Header.h"
#import "LBView.h"
#import "UIImageView+WebCache.h"

@interface LBView ()<UIScrollViewDelegate>

@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)UIPageControl *pageC;
@property (nonatomic,assign)NSInteger curpage;
@property (nonatomic,retain)NSMutableArray *curArray;
@property (nonatomic,retain)NSTimer *timer;

@end

@implementation LBView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initWithScrollView];
        [self initWithPageControl];
    }
    return self;
}

- (void)initWithScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    
//    self.backgroundColor = [UIColor greenColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    self.scrollView.delegate = self;
    
    self.curArray = [NSMutableArray arrayWithCapacity:3];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenWidth/2)];
        
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taps:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:imageView];
    }
    
    [self addSubview:self.scrollView];

}

- (void)taps:(UITapGestureRecognizer *)tap{
    if (self.delegateLB != nil && [self.delegateLB respondsToSelector:@selector(LBViewDelegate:didSelected:)]) {
        [self.delegateLB LBViewDelegate:self didSelected:self.curpage];
    }

}


- (void)initWithPageControl{
    self.pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2-10, CGRectGetHeight(self.scrollView.frame)-30, 20, 20)];
    [self addSubview:self.pageC];
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    self.pageC.numberOfPages = dataArray.count;
    [self updateCurViewWithPage:0];
    
    if (dataArray.count <= 1) {
        self.timer = nil;
    }else{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction{
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth*2, 0) animated:YES];
}

- (NSInteger)updateCurpage:(NSInteger)page{
    
    NSInteger count = self.dataArray.count;
    return (count + page)%count;
}

- (void)updateCurViewWithPage:(NSInteger)page{
    NSInteger pre = [self updateCurpage:page - 1];
    _curpage = [self updateCurpage:page];
    NSInteger last = [self updateCurpage:page +1];
    
    [self.curArray removeAllObjects];
    
    [self.curArray addObject:self.dataArray[pre]];
    [self.curArray addObject:self.dataArray[_curpage]];
    [self.curArray addObject:self.dataArray[last]];
    
    NSArray *array = self.scrollView.subviews;
    for (int i = 0; i < self.curArray.count; i++) {
        UIImageView *imageView = array[i];
        if (_isServiceLoadingImage) {
#warning 需要设置加载时默认图时  更换placeholderImage
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.curArray[i]] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
        }else{
         imageView.image = [UIImage imageNamed:self.curArray[i]];

        }
       
    }
    
    self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    self.pageC.currentPage = _curpage;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = self.scrollView.contentOffset.x;
    if (x >= kScreenWidth *2) {
        [self updateCurViewWithPage:_curpage + 1];
    }else if (x <= 0){
        [self updateCurViewWithPage:_curpage - 1];
    }
}


@end
