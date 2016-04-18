//
//  BFPayoffHeader.m
//  缤微纷购
//
//  Created by 郑洋 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "ViewController.h"
#import "Header.h"
#import "BFPayoffHeader.h"

@interface BFPayoffHeader ()
@property (nonatomic,retain)UIImageView *image;
@property (nonatomic,retain)UIScrollView *scroll;
@end

@implementation BFPayoffHeader

- (instancetype)initWithFrame:(CGRect)frame timeNum:(NSString *)time img:(NSMutableArray *)imgArr{
    if ([super initWithFrame:frame]) {
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
        img.image = [UIImage imageNamed:@"cbg.png"];
        
        UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(40, kScreenWidth/4-CGFloatX(35/2), CGFloatX(35), CGFloatX(35))];
        
        right.layer.cornerRadius = CGFloatX(35/2);
        right.layer.masksToBounds = YES;
        right.image = [UIImage imageNamed:@"mydingdan.png"];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(right.frame)+5, kScreenWidth/4-CGFloatX(20), kScreenWidth, CGFloatY(25))];
        name.text = @"我们已收到您的订单";
        name.font = [UIFont systemFontOfSize:CGFloatX(17)];
        name.textColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(right.frame)+5, CGRectGetMaxY(name.frame), kScreenWidth, CGFloatY(25))];
        title.text = @"将尽快处理";
        title.font = [UIFont systemFontOfSize:CGFloatX(17)];
        title.textColor = [UIColor whiteColor];
        
//        NSDateFormatter *date = [[NSDateFormatter alloc]init];
//        [date setDateFormat:@"yyyyMMddHHmmssSSS"];
//        NSString *time = [date stringFromDate:[NSDate date]];
        
        self.number = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(img.frame), kScreenWidth, CGFloatY(40))];
        self.number.text = [NSString stringWithFormat:@"订单编号:%@",time];
        self.number.font = [UIFont systemFontOfSize:CGFloatX(17)];
        
        UILabel *now = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_number.frame)-90, 0, 70, CGFloatY(40))];
        now.text = @"待发货";
        now.font = [UIFont systemFontOfSize:CGFloatX(17)];
        
        UIView *block = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_number.frame), kScreenWidth, 0.5)];
        block.backgroundColor = [UIColor blackColor];
        
        _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(block.frame)+10, kScreenWidth, (kScreenWidth-70)/6)];
        _scroll.contentSize = CGSizeMake(((kScreenWidth-70)/6+10)*(imgArr.count)+10, 0);
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        
        for (int i = 0; i < imgArr.count; i++) {
            _image = [[UIImageView alloc]initWithFrame:CGRectMake(10+(kScreenWidth-70)/6*i+(i*10), 0, (kScreenWidth-70)/6, (kScreenWidth-70)/6)];
            
//            _image.backgroundColor = [UIColor redColor];
            [_image setImageWithURL:[NSURL URLWithString:imgArr[i]] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
            
            [_scroll addSubview:_image];
            
        }
        self.height = CGRectGetMaxY(_scroll.frame)+10;
      
        [self addSubview:img];
        [img addSubview:right];
        [img addSubview:name];
        [img addSubview:title];
        [self addSubview:_number];
        [_number addSubview:now];
        [self addSubview:block];
        [self addSubview:_scroll];
    }
    return self;
}

@end
