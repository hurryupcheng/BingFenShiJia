//
//  BFHeadPortraitView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/31.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFHeadPortraitView.h"




@interface BFHeadPortraitView()
/**头像*/
@property (nonatomic, strong) UIImageView *headPortrait;
/**团长*/
@property (nonatomic, strong) UIImageView *captain;
/**沙发*/
@property (nonatomic, strong) UIImageView *sofa;

@property (nonatomic, strong) UIImageView *icon;
@end

@implementation BFHeadPortraitView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    //self.backgroundColor = [UIColor redColor];
    _model = model;
    
    
    
    NSArray *array = [TeamList parse:model.thisteam];
    NSUInteger number = model.havenum;
    //行数
    NSInteger hang = number%5 != 0 ? number/5 + 1 : number/5;
    //btn大小
    NSInteger width = BF_ScaleWidth(50);
    //间距
    NSInteger jiange = BF_ScaleWidth(10);
    NSInteger dianji = 1;
    NSInteger tubiao = 101;
    for (int H = 0; H < hang; H ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        //view.backgroundColor = [UIColor blueColor];
        
        
        

        
        NSInteger viewW = 0;
        
        if (H == hang - 1  && number%5 != 0) {  //最后一行并且不为5
            for (int i = 0 ; i < number%5; i++) {
                
                UIImageView *headPortrait = [[UIImageView alloc] init];
                self.headPortrait = headPortrait;
                headPortrait.image = [UIImage imageNamed:@"group_detail_head_image"];
                headPortrait.layer.cornerRadius = BF_ScaleWidth(25);
                headPortrait.layer.borderColor = BFColor(0xffffff).CGColor;
                headPortrait.layer.borderWidth = 1;
                headPortrait.layer.masksToBounds = YES;
                headPortrait.backgroundColor = [UIColor whiteColor];
                headPortrait.frame = CGRectMake(jiange + i * (jiange +width),5, BF_ScaleWidth(50), BF_ScaleWidth(50));
                headPortrait.tag = dianji;
                [view addSubview:headPortrait];
                viewW = CGRectGetMaxX(headPortrait.frame)+jiange;
                dianji++;
                
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.backgroundColor = BFColor(0x4da800);
                icon.tag = tubiao;
                icon.hidden = YES;
                icon.layer.masksToBounds = YES;
                icon.layer.borderColor = BFColor(0xffffff).CGColor;
                icon.layer.borderWidth = 2;
                icon.layer.cornerRadius = BF_ScaleWidth(10);
                icon.frame = CGRectMake(jiange + BF_ScaleWidth(30)+i * (jiange +width),0, BF_ScaleWidth(20), BF_ScaleWidth(20));
                [view addSubview:icon];
                tubiao++;
            }
        }else{
            for (int i = 0 ; i < 5; i++) {
                UIImageView *headPortrait = [[UIImageView alloc] init];
                self.headPortrait = headPortrait;
                headPortrait.image = [UIImage imageNamed:@"group_detail_head_image"];
                headPortrait.layer.cornerRadius = BF_ScaleWidth(25);
                headPortrait.layer.borderColor = BFColor(0xffffff).CGColor;
                headPortrait.layer.borderWidth = 1;
                headPortrait.layer.masksToBounds = YES;
                headPortrait.backgroundColor = [UIColor whiteColor];
                headPortrait.frame = CGRectMake(jiange + i * (jiange +width),5, BF_ScaleWidth(50), BF_ScaleWidth(50));
                headPortrait.tag = dianji;
                [view addSubview:headPortrait];
                viewW = CGRectGetMaxX(headPortrait.frame)+jiange;
                dianji++;
                
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.backgroundColor = BFColor(0x4da800);
                icon.tag = tubiao;
                icon.hidden = YES;
                icon.layer.masksToBounds = YES;
                icon.layer.borderColor = BFColor(0xffffff).CGColor;
                icon.layer.borderWidth = 2;
                icon.layer.cornerRadius = BF_ScaleWidth(10);
                icon.frame = CGRectMake(jiange + BF_ScaleWidth(30)+i * (jiange +width),0, BF_ScaleWidth(20), BF_ScaleWidth(20));
                [view addSubview:icon];
                tubiao++;
            }
        }
        
        for (NSInteger i = 1; i <= array.count; i++) {
            TeamList *list = array[i-1];
            
            [(UIImageView *)[view viewWithTag:i] sd_setImageWithURL:[NSURL URLWithString:list.user_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
            
            if ([list.join isEqualToString:@"1"]) {
                UIImageView *icon =  (UIImageView *)[view viewWithTag:100+i];
                icon.hidden = NO;
                icon.image = [UIImage imageNamed:@"group_detail_captain"];
            }else if ([list.join isEqualToString:@"2"]) {
                UIImageView *icon =  (UIImageView *)[view viewWithTag:100+i];
                icon.hidden = NO;
                icon.image = [UIImage imageNamed:@"group_detail_sofa"];
            }else {
                
            }
                   
        }
        view.frame = CGRectMake(0,H*BF_ScaleWidth(60), viewW, BF_ScaleWidth(60));
        //将view居中在父视图上
        view.center = CGPointMake(ScreenWidth/2, view.center.y);
        self.headPortraitViewH = hang * BF_ScaleHeight(60);
        [self addSubview:view];
    }
    

}

@end
