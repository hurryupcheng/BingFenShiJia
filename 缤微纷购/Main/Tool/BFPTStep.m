//
//  BFPTStep.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "ViewController.h"
#import "Header.h"
#import "BFPTStep.h"

@interface BFPTStep ()
/**查看详情按钮*/
@property (nonatomic,retain)UIButton *stepBut;
/**步骤图片*/
@property (nonatomic,retain)UIImageView *img;
/**步骤title*/
@property (nonatomic,retain)UILabel *title;
/**底部view*/
@property (nonatomic,retain)UIView *groub;

@end

@implementation BFPTStep

- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index{
    if ([super initWithFrame:frame]) {
        UILabel *pt = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, kScreenWidth, CGFloatX(25))];
        pt.text = @"拼团步骤";
        pt.font = [UIFont systemFontOfSize:CGFloatX(13)];
        
        self.stepBut = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pt.frame)-(kScreenWidth/4), 10, kScreenWidth/4, CGFloatX(25))];
        [self.stepBut setTitle:@"查看详情" forState:UIControlStateNormal];
        [self.stepBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.stepBut addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        self.stepBut.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(13)];
        
        NSArray *imgArr = @[@"a1.png",@"b1.png",@"c1.png",@"d1.png"];
        NSArray *imageArr = @[@"a2.png",@"b2.png",@"c2.png",@"d2.png"];
        NSArray *titleArr = @[@"选择心仪商品",@"支付开团或参团",@"等待好友参团支付",@"达到人数团购成功"];
        for (int i = 0; i < 4; i++) {
            self.groub = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4*i, CGRectGetMaxY(pt.frame), kScreenWidth/4, CGFloatX(40))];
            
            self.img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, CGFloatX(20), CGFloatX(20))];
            _img.image = [UIImage imageNamed:imgArr[i]];
            _img.layer.cornerRadius = CGFloatX(10);
            _img.layer.masksToBounds = YES;
            
            self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_img.frame)+5, 0, kScreenWidth/4-30, CGFloatX(40))];
            _title.font = [UIFont systemFontOfSize:CGFloatX(13)];
            _title.tag = i;
            _title.text = titleArr[i];
            _title.numberOfLines = 2;
            
            if (_title.tag == index) {
                _title.textColor = [UIColor redColor];
                self.img.image = [UIImage imageNamed:imageArr[index]];
            }
            
            [self addSubview:self.groub];
            [self.groub addSubview:self.img];
            [self.groub addSubview:self.title];
            
        }
        
        
        [self addSubview:pt];
        [self addSubview:self.stepBut];
      
    }
    return self;
}

//代理方法
- (void)click:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToCheckDetail)]) {
        [self.delegate goToCheckDetail];
    }
}




@end
