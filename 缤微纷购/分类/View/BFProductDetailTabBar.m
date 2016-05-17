//
//  BFProductDetailTabBar.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFProductDetailTabBar.h"



@interface BFProductDetailTabBar(){
    __block NSInteger         leftTime;
    __block NSTimer     *timer;
    __block NSTimer     *unShelveTimer;
}


@property (strong, nonatomic) NSMutableArray<CALayer *> *redLayers;
/**添加到购物车*/
@property (strong, nonatomic) UIButton *addToCart;
/**商品下架*/
@property (strong, nonatomic) UILabel *unShelve;
@end


@implementation BFProductDetailTabBar

- (NSMutableArray<CALayer *> *)redLayers {
    if (!_redLayers) {
        _redLayers = [NSMutableArray array];
    }
    return _redLayers;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    BFShoppingCartButton *shoppingCart = [BFShoppingCartButton buttonWithType:0];
    self.shoppingCart = shoppingCart;
    shoppingCart.frame = CGRectMake(0, 0, BF_ScaleWidth(120), BF_ScaleHeight(50));
    shoppingCart.tag = BFProductDetailTabBarButtonTypeGoCart;
    [shoppingCart addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shoppingCart];
    
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    if (userInfo) {
        [[CXArchiveShopManager sharedInstance]initWithUserID:userInfo.ID ShopItem:nil];
        //[[CXArchiveShopManager sharedInstance]startArchiveShop];
        NSArray *array = [[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop];
        if (array.count == 0) {
            shoppingCart.badge.hidden = YES;
        }else {
            shoppingCart.badge.hidden = NO;
            shoppingCart.badge.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        }
    }else {
        shoppingCart.badge.hidden = YES;
    }
    
    UIButton *addToCart = [UIButton buttonWithType:0];
    self.addToCart = addToCart;
    addToCart.frame = CGRectMake(BF_ScaleWidth(180), BF_ScaleHeight(9), BF_ScaleWidth(105), BF_ScaleHeight(32));
    addToCart.hidden = NO;
    addToCart.tag = BFProductDetailTabBarButtonTypeAddCart;
    addToCart.backgroundColor = BFColor(0xF56B0A);
    [addToCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    addToCart.layer.cornerRadius = BF_ScaleHeight(9);
    [addToCart setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    [addToCart addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addToCart];
    
    self.unShelve = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(180), BF_ScaleHeight(9), BF_ScaleWidth(105), BF_ScaleHeight(32))];
    //self.unShelve.hidden = YES;
    self.unShelve.alpha = 0;
    self.unShelve.backgroundColor = BFColor(0x1F1F1F);
    self.unShelve.layer.cornerRadius = BF_ScaleHeight(9);
    self.unShelve.layer.masksToBounds = YES;
    self.unShelve.textAlignment = NSTextAlignmentCenter;
    self.unShelve.textColor = BFColor(0xffffff);
    [self addSubview:self.unShelve];
  
}

- (void)setModel:(BFProductDetialModel *)model {
    _model = model;
    if (model) {
        if (model.nowtime < [model.endtime integerValue]) {
            if ([model.first_stock integerValue] > 0) {
                unShelveTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
            }else {
                self.addToCart.hidden = YES;
                self.unShelve.hidden = NO;
                self.unShelve.text = @"商品已售罄";
                self.unShelve.alpha = 1;
            }
        }else {
            self.addToCart.hidden = YES;
            self.unShelve.hidden = NO;
            self.unShelve.text = @"商品已下架";
            self.unShelve.alpha = 1;
        }
    }
}


- (void)refreshTime {
    NSCalendar *todayCalender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *betweenDate = [todayCalender components:NSCalendarUnitSecond fromDate:[[NSDate alloc]initWithTimeIntervalSince1970:self.model.nowtime++]  toDate:[[NSDate alloc]initWithTimeIntervalSince1970:[self.model.endtime intValue]] options:0];
    //BFLog(@"----%ld", (long)betweenDate.second);
    if (betweenDate.second <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.addToCart.alpha = 0;
            self.unShelve.text = @"商品已下架";
            self.unShelve.alpha = 1;
        }];
        //取消定时器
        [unShelveTimer invalidate];
        unShelveTimer = nil;
    }else {
        self.addToCart.alpha = 1;
        self.unShelve.alpha = 0;
    }

}

- (void)click:(UIButton *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithType:)]) {
        
        leftTime = 1;
        [self.addToCart setEnabled:NO];
        [self.shoppingCart setEnabled:NO];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
        [self.delegate clickWithType:sender.tag];
    }
}


- (void)timerAction {
    leftTime--;
    if(leftTime<=0)
    {
        [self.addToCart setEnabled:YES];
        [self.shoppingCart setEnabled:YES];
        //关闭定时
        [timer invalidate];
        timer = nil;
        //self.addToCart.backgroundColor = BFColor(0xFD8727);
    } else
    {
        
        [self.addToCart setEnabled:NO];
        [self.shoppingCart setEnabled:NO];
        //[self.addToCart setBackgroundColor:BFColor(0xD5D8D1)];
    }

}



@end
