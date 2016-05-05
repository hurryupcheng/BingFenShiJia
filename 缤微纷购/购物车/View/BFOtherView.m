//
//  BFOtherView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFShoppModel.h"
#import "AFNTool.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "BFOtherView.h"

@interface BFOtherView ()
@property (nonatomic,retain)BFShoppModel *shoppModel;
@property (nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation BFOtherView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        [self getDate];
    }
    return self;
}

- (void)initWithView{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth/3-20, 1)];
    lab.backgroundColor = [UIColor grayColor];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 0, kScreenWidth/3, 30)];
    labe.text = @"热门推荐";
    labe.textAlignment = NSTextAlignmentCenter;
    labe.textColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labe.frame)+5, 15, kScreenWidth/3-20, 1)];
    label.backgroundColor = [UIColor grayColor];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(labe.frame)+10, kScreenWidth-60, kScreenWidth/4)];
    
    scroll.contentSize = CGSizeMake(scroll.width*(self.dataArray.count/3), 0);
    scroll.shouldGroupAccessibilityChildren = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.pagingEnabled = YES;
    scroll.userInteractionEnabled = YES;
//    scroll.backgroundColor = [UIColor redColor];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/4*i)+(i*10), 0, (scroll.width-30)/3, (scroll.width-30)/3)];
        _imgButton.layer.borderColor = [UIColor grayColor].CGColor;
        _imgButton.layer.borderWidth = 1;
        _imgButton.tag = i;
        _imgButton.userInteractionEnabled = YES;
        [_imgButton addTarget:self action:@selector(item:model:) forControlEvents:UIControlEventTouchUpInside];
        [_imgButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:self.shoppModel.imgArr[i]] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
        
        [scroll addSubview:_imgButton];
    }
    
    [self addSubview:scroll];
    [self addSubview:lab];
    [self addSubview:labe];
    [self addSubview:label];
    
}

- (void)getDate{
    
    NSString *urls = @"http://bingo.luexue.com/index.php?m=Json&a=cart";
    [AFNTool postJSONWithUrl:urls parameters:nil success:^(id responseObject) {
        BFShoppModel *shoppModel = [[BFShoppModel alloc]initWithsetDateDictionary:responseObject];
        self.shoppModel = shoppModel;
        self.dataArray = [shoppModel.dateArr copy];
        [self initWithView];
    } fail:^{
        
    }];
    
}


- (void)item:(UIButton *)but model:(BFShoppModel *)model{
    model = self.shoppModel;
    if (self.otherDelegate != nil && [self.otherDelegate respondsToSelector:@selector(BFOtherViewDelegate:ID:)]) {
        [self.otherDelegate BFOtherViewDelegate:self ID:model.IDArr[but.tag]];
    }
}

@end
