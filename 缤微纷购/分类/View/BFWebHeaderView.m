//
//  BFWebHeaderView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Height.h"
#import "ViewController.h"
#import "Header.h"
#import "LBView.h"
#import "BFWebHeaderView.h"

@interface BFWebHeaderView ()

@property (nonatomic,retain)LBView *lbView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *moneyLabel;
@property (nonatomic,retain)UILabel *oldLabel;
@property (nonatomic,retain)UILabel *stockLabel;
@property (nonatomic,retain)NSString *stock;
@property (nonatomic,retain)UILabel *guige;
@property (nonatomic,retain)UIView *colorV;

@property (nonatomic,assign)NSInteger number;

@end

@implementation BFWebHeaderView

- (instancetype)initWithFrame:(CGRect)frame model:(FXQModel *)model{
    if ([super initWithFrame:frame]) {
        
        self.lbView = [[LBView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
//        _lbView.backgroundColor = [UIColor whiteColor];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in model.imgsArr) {
            [arr addObject:[dic valueForKey:@"url"]];
        }
        self.lbView.isServiceLoadingImage = YES;
        self.lbView.dataArray = [arr copy];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_lbView.frame), kScreenWidth/2+40, CGFloatY(30))];
//        self.titleLabel.backgroundColor = [UIColor greenColor];
        self.titleLabel.text = model.title;
        self.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(18)];
        
        self.moneyLabel = [[UILabel alloc]init];
//        self.moneyLabel.backgroundColor = [UIColor orangeColor];
        self.moneyLabel.font = [UIFont systemFontOfSize:CGFloatY(20)];
       
        float mon = [model.moneyArr[0] floatValue];
        self.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",mon];
        self.moneyLabel.textColor = [UIColor orangeColor];
        self.moneyLabel.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame)+10, [Height widthString:self.moneyLabel.text font:self.moneyLabel.font], CGFloatY(30));
        
        self.oldLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.moneyLabel.frame)+15, CGRectGetMaxY(self.titleLabel.frame)+10, kScreenWidth/4, CGFloatY(30))];
//        self.oldLabel.backgroundColor = [UIColor grayColor];
        NSString *oldPrice = [NSString stringWithFormat:@"¥ %@",model.oldMoney];
        self.oldLabel.font = [UIFont systemFontOfSize:CGFloatY(17)];
        self.oldLabel.textColor = [UIColor grayColor];
        
        NSUInteger length = [oldPrice length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
        [self.oldLabel setAttributedText:attri];
        
        self.addShopp = [[AddShopping alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-kScreenWidth/3, CGRectGetMaxY(self.lbView.frame)+5, kScreenWidth/3, CGFloatY(35))];
        
        [self.addShopp.minBut addTarget:self action:@selector(minButSelented) forControlEvents:UIControlEventTouchUpInside];
        [self.addShopp.maxBut addTarget:self action:@selector(maxButSelented) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.addShopp.textF.text integerValue] <= 1) {
            self.addShopp.minBut.enabled = NO;
        }
        
        self.stock = model.stock;
        self.stockLabel = [[UILabel alloc]init];
        self.stockLabel.text = [NSString stringWithFormat:@"库存数量:%@",model.stockArr[0]];
        self.stockLabel.font = [UIFont systemFontOfSize:CGFloatX(16)];
        CGFloat stockWeight = [Height widthString:self.stockLabel.text font:self.stockLabel.font];
        self.stockLabel.frame = CGRectMake(CGRectGetMaxX(self.frame)-stockWeight-10, CGRectGetMaxY(self.addShopp.frame)+5, stockWeight, CGFloatX(30));
        self.stockLabel.textAlignment = NSTextAlignmentRight;
        
        for (int i = 0; i < 3; i++) {
           _colorV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stockLabel.frame)+(CGFloatX(40)*i), kScreenWidth, 0.5)];
            _colorV.backgroundColor = [UIColor grayColor];
            
            [self addSubview:_colorV];
        }
        
        self.guige = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.stockLabel.frame)+5, kScreenWidth, CGFloatX(30))];
        
        self.guige.text = @"商品规格";
        self.guige.font = [UIFont systemFontOfSize:CGFloatX(16)];
        
        UILabel *choose = [[UILabel alloc]init];
        choose.text = model.guigeArr[0];
        choose.font = [UIFont systemFontOfSize:CGFloatX(16)];
        
        CGFloat weight = [Height widthString:choose.text font:choose.font];
        choose.frame = CGRectMake(kScreenWidth-weight-20, 0, weight, CGFloatX(30));
        
        UILabel *shop = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.guige.frame)+10, kScreenWidth, CGFloatX(30))];
        shop.text = @"商品详情(建议wifi状态下查看)";
        shop.font = [UIFont systemFontOfSize:CGFloatX(16)];
        
        self.headerHeight = CGRectGetMaxY(_colorV.frame)+5;
        
        [self addSubview:_lbView];
        [self addSubview:_titleLabel];
        [self addSubview:_addShopp];
        [self addSubview:_moneyLabel];
        [self addSubview:self.oldLabel];
        [self addSubview:_stockLabel];
        [self.guige addSubview:choose];
        [self addSubview:self.guige];
        [self addSubview:shop];
  
    }
    return self;
}

- (void)minButSelented{
    self.number--;
    self.addShopp.maxBut.enabled = YES;
    self.addShopp.textF.text = [NSString stringWithFormat:@"%d",self.number];
    if ([self.addShopp.textF.text integerValue] <= 1) {
        self.addShopp.textF.text = @"1";
        self.addShopp.minBut.enabled = NO;
    }
}

- (void)maxButSelented{
    self.number++;
    self.addShopp.minBut.enabled = YES;
    
    self.addShopp.textF.text = [NSString stringWithFormat:@"%d",self.number];
    
    if ([self.addShopp.textF.text integerValue] >= [_stock integerValue]) {
        
        self.addShopp.maxBut.enabled = NO;
    }
}

@end
