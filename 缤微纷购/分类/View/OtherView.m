//
//  OtherView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "AddShopping.h"
#import "ViewController.h"
#import "Header.h"
#import "OtherView.h"

@interface OtherView ()

@property (nonatomic,retain)UIButton *selecdent;

@end

@implementation OtherView

- (instancetype)initWithFrame:(CGRect)frame img:(NSString *)img title:(NSString *)title money:(NSString *)money number:(NSString *)number hot:(NSString *)hot arr:(NSMutableArray *)arr set:(NSMutableSet *)set{

    if ([super initWithFrame:frame]) {
  
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake1(5, 0, kScreenWidth/4, kScreenWidth/4)];
//        self.imageView.backgroundColor = [UIColor greenColor];
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+5, 0, kScreenWidth-(_imageView.frame.size.width)-20, CGFloatY(40))];
//        _titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.text = title;
        _titleLabel.font = [UIFont systemFontOfSize:CGFloatY(16)];
        _titleLabel.numberOfLines = 2;
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+5, CGRectGetMaxY(_titleLabel.frame), kScreenWidth-(_imageView.frame.size.width)-20, CGFloatY(25))];
//        _moneyLabel.backgroundColor = [UIColor greenColor];
      
        _moneyLabel.text = [NSString stringWithFormat:@"价格: ¥%@元   库存: %@",money,number];
        _moneyLabel.font = [UIFont systemFontOfSize:CGFloatY(15)];

        self.hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+5, CGRectGetMaxY(_moneyLabel.frame), kScreenWidth, CGFloatY(25))];
        _hotLabel.text = hot;
        _hotLabel.font = [UIFont systemFontOfSize:CGFloatY(15)];
//        _hotLabel.backgroundColor = [UIColor greenColor];
        
        NSArray *arrs = @[@"颜色",@"尺寸",@"数量"];
        for (int i = 0; i < 3; i++) {
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake1(5, CGRectGetMaxY(_imageView.frame)+40+(70*i), kScreenWidth, 20)];
            name.text = arrs[i];
            name.font = [UIFont systemFontOfSize:CGFloatY(15)];
            
            UIView *black = [[UIView alloc]initWithFrame:CGRectMake1(5, CGRectGetMaxY(_imageView.frame)+65+(70*i), kScreenWidth-10, 1)];
            black.backgroundColor = [UIColor blackColor];
            
            [self addSubview:name];
            [self addSubview:black];
        }
        
        self.reds = [[UILabel alloc]initWithFrame:CGRectMake1(10, CGRectGetMaxY(_imageView.frame)+75, kScreenWidth/5, 30)];
        _reds.layer.borderWidth = 2;
        _reds.layer.borderColor = [UIColor redColor].CGColor;
        
        if (arr.count != 0) {
 
        for (int j = 0; j < arr.count; j++) {
            self.arrBut = [[UIButton alloc]initWithFrame:CGRectMake1(10+(kScreenWidth/5*j)+(j*10), CGRectGetMaxY(_imageView.frame)+75, kScreenWidth/5, 30)];
            
            self.arrBut.layer.borderColor = [UIColor grayColor].CGColor;
            self.arrBut.layer.borderWidth = 1;
            [self.arrBut setTitle:arr[j] forState:UIControlStateNormal];
            [self.arrBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.arrBut.tag = 200+j;
            [self.arrBut addTarget:self action:@selector(arrBut:) forControlEvents:UIControlEventTouchUpInside]
            ;
            self.arrBut.titleLabel.font = [UIFont systemFontOfSize:CGFloatY(14)];
            [self addSubview:self.arrBut];
        }
    }
  
        self.red = [[UILabel alloc]initWithFrame:CGRectMake1(10, CGRectGetMaxY(_imageView.frame)+145, kScreenWidth/5, 30)];
        _red.layer.borderWidth = 2;
        _red.layer.borderColor = [UIColor redColor].CGColor;
       
        if (array.count != 0) {
    
        for (int k= 0; k < array.count; k++) {
            self.arrayBut = [[UIButton alloc]initWithFrame:CGRectMake1(10+(kScreenWidth/5*k)+(k*10), CGRectGetMaxY(_imageView.frame)+145, kScreenWidth/5, 30)];
            
            self.arrayBut.layer.borderWidth = 1;
            self.arrayBut.layer.borderColor = [UIColor grayColor].CGColor;
            [self.arrayBut setTitle:array[k] forState:UIControlStateNormal];
            [self.arrayBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.arrayBut.tag = 300+k;
            [self.arrayBut addTarget:self action:@selector(arrayBut:) forControlEvents:UIControlEventTouchUpInside];
            self.arrayBut.titleLabel.font = [UIFont systemFontOfSize:CGFloatY(14)];
            
            [self addSubview:self.arrayBut];
        }
    }
        if (self.arrayBut.tag == 100) {
            self.arrayBut.selected = YES;
            self.arrayBut.layer.backgroundColor = [UIColor redColor].CGColor;
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.arrayBut.frame)+50, kScreenWidth/4, CGFloatY(30))];
        label.text = @"购买数量:";
        
        self.addShopp = [[AddShopping alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMaxY(self.arrayBut.frame)+45, kScreenWidth/3, CGFloatY(35))];
//        self.addShopp.backgroundColor = [UIColor greenColor];
        
        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
        [self addSubview:_moneyLabel];
        [self addSubview:_hotLabel];
        [self addSubview:label];
        [self addSubview:_addShopp];
        [self addSubview:_red];
        [self addSubview:_reds];
    }
    return self;
}

- (void)arrBut:(UIButton *)but{
    self.selecdent.selected = NO;
    but.selected = YES;
    self.selecdent = but;
    self.reds.frame = but.frame;

}

- (void)arrayBut:(UIButton *)but{
    self.selecdent.selected = NO;
    but.selected = YES;
    self.selecdent = but;
    self.red.frame = but.frame;

}



@end
