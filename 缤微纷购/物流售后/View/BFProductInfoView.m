//
//  BFProductInfoView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/18.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProductInfoView.h"

@interface BFProductInfoView()


@end



@implementation BFProductInfoView



- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
        [self setView];
    }
    return self;
}

- (void)setView {
    
    UIView *line = [self setUpLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:line];
    
    self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(12.5), BF_ScaleHeight(12.5), BF_ScaleWidth(70), BF_ScaleHeight(70))];
    self.productIcon.image = [UIImage imageNamed:@"goodsImage"];
    self.productIcon.layer.borderWidth = 1;
    self.productIcon.layer.borderColor = BFColor(0xBDBEC0).CGColor;
    self.productIcon.layer.cornerRadius = 10;
    self.productIcon.layer.masksToBounds = YES;
    [self addSubview:self.productIcon];
    
    self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(12.5), self.productIcon.y+BF_ScaleHeight(8), BF_ScaleWidth(170), 0)];
    self.productTitle.text = @"云南冰糖橙-明星为你甜蜜助跑响起扑鼻 细嫩多汁";
    self.productTitle.numberOfLines = 0;
    //self.productTitle.backgroundColor = [UIColor redColor];
    self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    [self addSubview:self.productTitle];
    [self.productTitle sizeToFit];
    
    
    self.productSize = [[UILabel alloc] initWithFrame:CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productTitle.frame)+BF_ScaleHeight(10), BF_ScaleWidth(160), BF_ScaleHeight(10))];
    self.productSize.textColor = BFColor(0x9A9B9C);
    self.productSize.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
    self.productSize.text = @"5斤装";
    [self addSubview:self.productSize];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(300), 0, BF_ScaleWidth(10), self.height)];
    arrowImageView.image = [UIImage imageNamed:@"select_right"];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:arrowImageView];
    
    
    
}

- (UIView *)setUpLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = BFColor(0xBDBEC0);
    return line;
}

@end
