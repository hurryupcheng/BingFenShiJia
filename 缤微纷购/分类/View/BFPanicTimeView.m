//
//  BFPanicTimeView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define ViewH   BF_ScaleHeight(40)

#import "BFPanicTimeView.h"
#import "BFPanicCountdownView.h"

@interface BFPanicTimeView()
/***/
@property (nonatomic, strong) BFPanicCountdownView *countdownView;

@end

@implementation BFPanicTimeView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setModel:(BFPanicBuyingModel *)model {
    _model = model;
    if (model) {
        UIView *backgroud = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ViewH)];
        backgroud.backgroundColor = BFColor(0x000000);
        backgroud.alpha = 0.3;
        [self addSubview:backgroud];
        
        UIImageView *clock = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(10), BF_ScaleWidth(20), BF_ScaleHeight(20))];
        clock.image = [UIImage imageNamed:@"clock"];
        [self addSubview:clock];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clock.frame)+BF_ScaleWidth(8), 0, BF_ScaleWidth(35), ViewH)];
        leftLabel.text = @"剩余";
        leftLabel.textColor = BFColor(0xF9FBFB);
        leftLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        [self addSubview:leftLabel];
        
        UILabel *stock = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame), BF_ScaleHeight(10), BF_ScaleWidth(40), BF_ScaleHeight(20))];
        stock.backgroundColor = BFColor(0xFCFCFC);
        stock.layer.cornerRadius = 3;
        stock.layer.masksToBounds = YES;
        stock.textAlignment = NSTextAlignmentCenter;
        stock.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        stock.textColor = BFColor(0x232323);
        if (model.first_stock.length != 0) {
            if ([model.first_stock integerValue] <= 0) {
                stock.text = @"0";
            }else {
                stock.text = model.first_stock;
            }
        }else {
            stock.text = @"0";

        }
        [self addSubview:stock];
        

        
        self.countdownView = [[BFPanicCountdownView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(124), 0, BF_ScaleWidth(188), ViewH)];
        //self.countdownView.backgroundColor = [UIColor greenColor];
        self.countdownView.model = model;
        [self addSubview:self.countdownView];
    }
}

@end
