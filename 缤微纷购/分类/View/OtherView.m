//
//  OtherView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFClassminView.h"
#import "Height.h"
#import "UIImageView+WebCache.h"
#import "AddShopping.h"
#import "ViewController.h"
#import "Header.h"
#import "OtherView.h"

@interface OtherView ()

@property (nonatomic,retain)UIButton *selecdent;
@property (nonatomic,retain)NSArray *arrays;
//@property (nonatomic,retain)NSArray *guige;
@property (nonatomic,retain)BFClassminView *name;
@property (nonatomic,retain)BFClassminView *het;
@property (nonatomic,retain)BFClassminView *num;

@property (nonatomic,assign)NSInteger number;
@property (nonatomic,assign)NSInteger stock;
@property (nonatomic,retain)NSMutableArray *stockArr;

@end

@implementation OtherView


- (instancetype)initWithFrame:(CGRect)frame img:(NSString *)img title:(NSString *)title money:(NSMutableArray *)money arr:(NSMutableArray *)arr set:(NSArray *)set num:(NSString *)num stock:(NSMutableArray *)stock{

    if ([super initWithFrame:frame]) {
        self.stockArr = stock;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake1(5, 0, kScreenWidth/4, kScreenWidth/4)];
//        self.imageView.backgroundColor = [UIColor greenColor];
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
        self.img = img;
        [self addSubview:_imageView];
        
        self.titleLabel = [[UILabel alloc]init];
//        _titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.text = title;
        _titleLabel.font = [UIFont systemFontOfSize:CGFloatY(16)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame)+5, 0, kScreenWidth-(_imageView.frame.size.width)-20, [Height heightString:title font:CGFloatY(16)]);
        [_titleLabel sizeToFit];
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+5, CGRectGetMaxY(_titleLabel.frame), kScreenWidth-(_imageView.frame.size.width)-20, CGFloatY(30))];
//        self.moneyLabel.backgroundColor = [UIColor grayColor];

        self.arrays = [NSArray array];
        self.arrays = [money copy];
       
        NSString *string = [NSString stringWithFormat:@"%@",self.arrays[0]];
        float money = [string floatValue];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"价格:¥%.2f元",money]];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, [str length]-4)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:CGFloatY(16)] range:NSMakeRange(0,[str length])];
        
        self.moneyLabel.attributedText = str;

        self.name = [[BFClassminView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+10, kScreenWidth, CGFloatY(25)) title:@"颜色"];
        
        [self addSubview:_name];
        
        self.reds = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_name.frame)+10, (kScreenWidth-50)/4, CGFloatY(30))];
        _reds.layer.borderWidth = 1;
        _reds.layer.borderColor = [UIColor redColor].CGColor;
        
        if (arr.count != 0) {

        for (int j = 0; j < arr.count; j++) {
            self.arrBut = [[UIButton alloc]initWithFrame:CGRectMake(10+(j%4)*10+(j%4)*((kScreenWidth-50)/4), 10+CGRectGetMaxY(_name.frame)+(j/4)*10+(j/4)*CGFloatY(30), (kScreenWidth-50)/4, CGFloatY(30))];
            
            self.arrBut.layer.borderColor = [UIColor grayColor].CGColor;
            self.arrBut.layer.borderWidth = 1;
            [self.arrBut setTitle:arr[j] forState:UIControlStateNormal];
            [self.arrBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.arrBut.tag = j;
            [self.arrBut addTarget:self action:@selector(arrBut:) forControlEvents:UIControlEventTouchUpInside]
            ;
            self.arrBut.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(14)];
            [self addSubview:self.arrBut];
        }
    }
    
        self.het = [[BFClassminView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.arrBut.frame)+10, kScreenWidth, CGFloatY(25)) title:@"规格"];
        
        [self addSubview:_het];
        
        self.red = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_het.frame)+10, (kScreenWidth-50)/4, CGFloatY(30))];
        _red.layer.borderWidth = 1;
        _red.layer.borderColor = [UIColor redColor].CGColor;
        
        for (int k= 0; k < set.count; k++) {
            self.arrayBut = [[UIButton alloc]initWithFrame:CGRectMake(10+(k%4)*10+(k%4)*((kScreenWidth-50)/4), 10+CGRectGetMaxY(_het.frame)+(k/4)*10+(k/4)*CGFloatY(30), (kScreenWidth-50)/4, CGFloatY(30))];
            
            self.arrayBut.layer.borderWidth = 1;
            self.arrayBut.layer.borderColor = [UIColor grayColor].CGColor;
            [self.arrayBut setTitle:set[k] forState:UIControlStateNormal];
            [self.arrayBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.arrayBut.tag = k;
            [self.arrayBut addTarget:self action:@selector(arrayBut:) forControlEvents:UIControlEventTouchUpInside];
            self.arrayBut.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(14)];
            
            self.selectedGuige = set[0];
            [self addSubview:self.arrayBut];
            }
        
        
        
        self.num = [[BFClassminView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.arrayBut.frame)+10, kScreenWidth, CGFloatY(25)) title:@"数量"];
        
        [self addSubview:self.num];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.num.frame)+10, CGFloatX(kScreenWidth/4), CGFloatY(35))];
        label.text = @"购买数量:";
        label.font = [UIFont systemFontOfSize:CGFloatX(16)];
        
        self.addShopp = [[AddShopping alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMaxY(self.num.frame)+10, CGFloatX(kScreenWidth/3), CGFloatY(35))];
        
        NSInteger nums = [num integerValue];
        self.number = nums;
        self.addShopp.textF.text = num;
//        self.addShopp.backgroundColor = [UIColor greenColor];
        [self.addShopp.maxBut addTarget:self action:@selector(maxButSelented) forControlEvents:UIControlEventTouchUpInside];
        [self.addShopp.minBut addTarget:self action:@selector(minButSelented) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.addShopp.textF.text integerValue] <= 1) {
            self.addShopp.minBut.enabled = NO;
        }
        
        [self addSubview:_titleLabel];
        [self addSubview:_moneyLabel];
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
   
    NSString *string = [NSString stringWithFormat:@"%@",self.arrays[0]];
    float money = [string floatValue];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"价格:¥%.2f元",money]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, [str length]-4)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:CGFloatY(16)] range:NSMakeRange(0,[str length])];
    
    self.moneyLabel.attributedText = str;

}

- (void)arrayBut:(UIButton *)but{
    
    self.selecdent.selected = NO;
    but.selected = YES;
    self.selecdent = but;
    self.red.frame = but.frame;
    
    NSString *string = [NSString stringWithFormat:@"%@",self.arrays[but.tag]];
    float money = [string floatValue];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"价格:¥%.2f元",money]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, [str length]-4)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:CGFloatY(16)] range:NSMakeRange(0,[str length])];
    
    self.moneyLabel.attributedText = str;
    self.selectedGuige = but.titleLabel.text;
    if (but.selected == YES) {
        
        if ([self.addShopp.textF.text integerValue] >= [self.stockArr[but.tag] integerValue]) {
            self.addShopp.textF.text = self.stockArr[but.tag];
           
        }
    }
    
//    if (self.arrayBut.selected == YES) {
//        self.hot = _guige[self.arrayBut.tag];
//        NSLog(@"%@",_guige[self.arrayBut.tag]);
//    }
}

- (void)minButSelented{
    self.addShopp.maxBut.enabled = YES;
    self.number--;
    self.addShopp.textF.text = [NSString stringWithFormat:@"%d",self.number];
    if ([self.addShopp.textF.text integerValue] <= 1) {
        self.addShopp.textF.text = @"1";
        self.addShopp.minBut.enabled = NO;
    }
}

- (void)maxButSelented{
    
    if ([self.addShopp.textF.text integerValue] >= [self.stockArr[0] integerValue]) {

        self.addShopp.maxBut.enabled = NO;
    }else{
    
        self.addShopp.minBut.enabled = YES;
        self.number++;
        self.addShopp.textF.text = [NSString stringWithFormat:@"%d",self.number];
    }
}

@end
