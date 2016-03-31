//
//  BFHeadPortraitView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/31.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFHeadPortraitView.h"

@interface BFHeadPortraitView()

@end


@interface BFHeadPortraitView()
/**头像*/
@property (nonatomic, strong) UIImageView *headPortrait;
@end

@implementation BFHeadPortraitView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    TeamList *list = [TeamList parse:model.thisteam];
    NSUInteger number = model.havenum;
    //行数
    NSInteger hang = number%5 != 0 ? number/5 + 1 : number/5;
    //btn大小
    NSInteger width = 50;
    //间距
    NSInteger jiange = 10;
    for (int H = 0; H < hang; H ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor blueColor];
        NSInteger viewW = 0;
        if (H == hang - 1  && number%5 != 0) {  //最后一行并且不为5
            for (int i = 0 ; i < number%5; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.layer.cornerRadius = 25;
                btn.layer.masksToBounds = YES;
                btn.backgroundColor = [UIColor grayColor];
                btn.frame = CGRectMake(jiange + i * (jiange +width),5, 50, 50);
                [view addSubview:btn];
                viewW = CGRectGetMaxX(btn.frame)+jiange;
            }
        }else{
            for (int i = 0 ; i < 5; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.layer.cornerRadius = 25;
                btn.layer.masksToBounds = YES;
                btn.backgroundColor = [UIColor grayColor];
                btn.frame = CGRectMake(jiange + i * (jiange +width),5, 50, 50);
                [view addSubview:btn];
                viewW = CGRectGetMaxX(btn.frame)+jiange;
            }
        }
        view.frame = CGRectMake(0,H*60, viewW, 60);
        view.frame = CGRectMake(0,H*60, viewW, 60);
        //将view居中在父视图上
        view.center = CGPointMake(self.frame.size.width/2, view.center.y);
        [self addSubview:view];
    }


}

@end
