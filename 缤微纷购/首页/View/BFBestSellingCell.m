//
//  BFBestSellingCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBestSellingCell.h"

@interface BFBestSellingCell()<BFShopCartAnimationDelegate>
/**底部view*/
@property (nonatomic, strong) UIView *bottomView;
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**新价格*/
@property (nonatomic, strong) UILabel *productNewPrice;
/**商品标题*/
@property (nonatomic, strong) UILabel *productOriginPrice;

@property (strong, nonatomic) NSMutableArray<CALayer *> *redLayers;

@end

@implementation BFBestSellingCell

- (NSMutableArray<CALayer *> *)redLayers {
    if (!_redLayers) {
        _redLayers = [NSMutableArray array];
    }
    return _redLayers;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFBestSellingCell";
    BFBestSellingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFBestSellingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = BFColor(0xF4F4F4);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setModel:(BFBestSellingList *)model {
    _model = model;
    if (model) {
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(300), BF_ScaleHeight(85))];
        self.bottomView.backgroundColor = BFColor(0xffffff);
        self.bottomView.layer.borderWidth = 1;
        self.bottomView.layer.borderColor = BFColor(0xD5D5D6).CGColor;
        [self addSubview:self.bottomView];
        
        self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BF_ScaleHeight(85), BF_ScaleHeight(85))];
        [self.productIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.bottomView addSubview:self.productIcon];
        
        self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame) + BF_ScaleWidth(12), BF_ScaleHeight(5), BF_ScaleWidth(190), BF_ScaleHeight(35))];
        //self.productTitle.backgroundColor = [UIColor redColor];
        self.productTitle.numberOfLines = 2;
        self.productTitle.text = model.title;
        self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        [self.bottomView addSubview:self.productTitle];
        //[self.productTitle sizeToFit];
        
        self.productNewPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.productTitle.x, BF_ScaleHeight(50), BF_ScaleWidth(100), BF_ScaleHeight(15))];
        self.productNewPrice.numberOfLines = 0;
        self.productNewPrice.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        self.productNewPrice.textColor = BFColor(0xE88005);
        self.productNewPrice.text = [NSString stringWithFormat:@"¥ %@", model.price];
        [self.bottomView addSubview:self.productNewPrice];
        [self.productNewPrice sizeToFit];
        
        
        self.productOriginPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productNewPrice.frame)+BF_ScaleWidth(15), BF_ScaleHeight(51), BF_ScaleWidth(100), BF_ScaleHeight(14))];
        self.productOriginPrice.numberOfLines = 0;
        self.productOriginPrice.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
        self.productOriginPrice.textColor = BFColor(0x868686);
        self.productOriginPrice.text = [NSString stringWithFormat:@"¥ %@", model.yprice];;
        [self.bottomView addSubview:self.productOriginPrice];
        [self.productOriginPrice sizeToFit];
        
        UIView *line = [UIView drawLineWithFrame:CGRectMake(0, self.productOriginPrice.height/2, self.productOriginPrice.width, 1)];
        line.backgroundColor = BFColor(0x868686);
        [self.productOriginPrice addSubview:line];
        
        self.shoppingCart = [[UIButton alloc] initWithFrame:CGRectMake(BF_ScaleWidth(260), BF_ScaleHeight(50), BF_ScaleWidth(35), BF_ScaleHeight(35))];
        //shoppingCart.backgroundColor = [UIColor blueColor];
        [self.shoppingCart setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
        [self.shoppingCart addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.shoppingCart];

    }
}




- (void)add:(UIButton *)sender {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (!userInfo) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(gotoLogin)]) {
            [self.delegate gotoLogin];
        }
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(addToShoppingCartWithButton:)]) {
            [self animationStart];
            [self.delegate addToShoppingCartWithButton:sender];
        }
    }
}

//购物车动画
- (void)animationStart{
    //获取动画起点
    CGPoint start = [self convertPoint:self.productIcon.center toView:self];
    //获取动画终点
    CGPoint end = [self convertPoint:self.shoppingCart.center toView:self];
    //创建layer
    CALayer *chLayer = [[CALayer alloc] init];
    chLayer.contents = (UIImage *)self.productIcon.image.CGImage;
    [self.redLayers addObject:chLayer];
    chLayer.frame = CGRectMake(self.productIcon.centerX, self.productIcon.centerY, BF_ScaleHeight(40), BF_ScaleHeight(40));
    chLayer.cornerRadius = CGRectGetWidth(chLayer.frame)/3.f;
    chLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:chLayer];
    
    
    BFShopCartAnimation *animation = [[BFShopCartAnimation alloc]init];
    animation.delegate = self;
    [animation shopCatrAnimationWithLayer:chLayer startPoint:start endPoint:end changeX:start.x+BF_ScaleWidth(40) changeY:start.y-BF_ScaleHeight(65) endScale:0.3f  duration:1 isRotation:YES];
}


//动画代理动画结束移除layer
- (void)animationStop {
    [self.redLayers[0] removeFromSuperlayer];
    [self.redLayers removeObjectAtIndex:0];
}

@end
