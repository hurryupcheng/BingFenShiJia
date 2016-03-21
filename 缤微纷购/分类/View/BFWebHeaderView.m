//
//  BFWebHeaderView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "LBView.h"
#import "BFWebHeaderView.h"

@interface BFWebHeaderView ()

@property (nonatomic,retain)LBView *lbView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *moneyLabel;
@property (nonatomic,retain)UILabel *oldLabel;

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
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), kScreenWidth/4, CGFloatY(30))];
//        self.moneyLabel.backgroundColor = [UIColor orangeColor];
        self.moneyLabel.font = [UIFont systemFontOfSize:CGFloatY(20)];
       
        float mon = [model.moneyArr[0] floatValue];
        self.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",mon];
        self.moneyLabel.textColor = [UIColor orangeColor];
        
        self.oldLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.moneyLabel.frame), CGRectGetMaxY(self.titleLabel.frame), kScreenWidth/4, CGFloatY(30))];
//        self.oldLabel.backgroundColor = [UIColor grayColor];
        NSString *oldPrice = [NSString stringWithFormat:@"¥ %@",model.oldMoney];
        self.oldLabel.font = [UIFont systemFontOfSize:CGFloatY(17)];
        self.oldLabel.textColor = [UIColor grayColor];
        
        NSUInteger length = [oldPrice length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
        [self.oldLabel setAttributedText:attri];
        
        self.addShopp = [[AddShopping alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-kScreenWidth/3, CGRectGetMaxY(self.lbView.frame)+10, kScreenWidth/3, CGFloatY(35))];
        
        [self.addShopp.minBut addTarget:self action:@selector(minButSelented) forControlEvents:UIControlEventTouchUpInside];
        [self.addShopp.maxBut addTarget:self action:@selector(maxButSelented) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *colorV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.moneyLabel.frame), kScreenWidth, 1)];
        colorV.backgroundColor = [UIColor grayColor];
        
        [self addSubview:_lbView];
        [self addSubview:_titleLabel];
        [self addSubview:colorV];
        [self addSubview:_addShopp];
        [self addSubview:_moneyLabel];
        [self addSubview:self.oldLabel];
     
    }
    return self;
}

- (void)minButSelented{
    self.number--;
    self.addShopp.textF.text = [NSString stringWithFormat:@"%d",self.number];
    if (self.number <= 1) {
        self.addShopp.minBut.userInteractionEnabled = NO;
    }
}

- (void)maxButSelented{
    self.number++;
    self.addShopp.textF.text = [NSString stringWithFormat:@"%d",self.number];
    if (self.number > 1) {
        self.addShopp.minBut.userInteractionEnabled = YES;
    }
}

@end
