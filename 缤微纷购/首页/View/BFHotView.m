//
//  BFHotView.m
//  缤微纷购
//
//  Created by 郑洋 on 16/5/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "ViewController.h"
#import "BFHotView.h"

@interface BFHotView ()
@property (nonatomic,retain)UIButton *button;
@property (nonatomic,retain)UIButton *itemBut;
@end

@implementation BFHotView

- (instancetype)initWithFrame:(CGRect)frame model:(BFSosoSubModel *)model other:(BFSosoModel *)otherModel{
    if ([super initWithFrame:frame]) {
        UILabel *hot = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, CGFloatX(30))];
        hot.text = @"热门搜索词";
        [self addSubview:hot];
  
        CGFloat x = (kScreenWidth-50)/4;
        for (int i = 0; i < model.titleArr.count; i++) {
            _button = [[UIButton alloc]initWithFrame:CGRectMake((i%4+1)*10+(i%4)* x,CGRectGetMaxY(hot.frame)+(i/4+1)*10+(i/4)*30, x, 30)];
//            _button.backgroundColor = [UIColor redColor];
            _button.layer.borderWidth = 1;
            _button.layer.cornerRadius = 8;
            _button.layer.masksToBounds = YES;
            _button.layer.borderColor = rgb(75, 145, 211, 1.0).CGColor;
            NSDictionary *dic = model.titleArr[i];
            [_button setTitle:dic[@"title"] forState:UIControlStateNormal];
            [_button setTitleColor:rgb(75, 145, 211, 1.0) forState:UIControlStateNormal];
            _button.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(16)];
            [_button addTarget:self action:@selector(butSelecd:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_button];
        }
        
        UILabel *love = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.button.frame)+10, kScreenWidth, CGFloatX(30))];
        love.text = @"猜你喜欢";
        [self addSubview:love];
        
        CGFloat x1 = (kScreenWidth-40)/3;
        for (int j = 0 ; j < otherModel.imgArr.count; j++) {
            _itemBut = [[UIButton alloc]initWithFrame:CGRectMake((j%3+1)*10+(j%3)* x1,CGRectGetMaxY(love.frame)+(j/3+1)*10+(j/3)*x1, x1, x1)];
            
//            _itemBut.backgroundColor = [UIColor yellowColor];
            _itemBut.layer.borderWidth = 1;
            _itemBut.layer.cornerRadius = 8;
            _itemBut.layer.masksToBounds = YES;
            _itemBut.layer.borderColor = rgb(75, 145, 211, 1.0).CGColor;
            [_itemBut setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:otherModel.imgArr[j]] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
            [_itemBut addTarget:self action:@selector(itemSelecd:) forControlEvents:UIControlEventTouchUpInside];
            _itemBut.tag = j;
            [self addSubview:_itemBut];
        }
        _cellHeight = CGRectGetMaxY(_itemBut.frame)+10;
    }
    return self;
}

- (void)butSelecd:(UIButton *)but{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(selectedBut:)] ) {
        [self.delegate selectedBut:but.titleLabel.text];
    }
}


- (void)itemSelecd:(UIButton *)but{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(selectedButton:)]) {
        [self.delegate selectedButton:but.tag];
    }
}
@end
