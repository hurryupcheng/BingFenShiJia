//
//  BFGroupDetailCountdownView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailCountdownView.h"
#import "BFCountdownView.h"

@interface BFGroupDetailCountdownView()

/**对于诸位大侠的相助，团长感激涕零*/
@property (nonatomic, strong) UILabel *helpLabel;
/**团购成功或者失败*/
@property (nonatomic, strong) UILabel *statusLabel;
/**倒计时view*/
@property (nonatomic, strong) BFCountdownView *countdown;
/**还差几人*/
@property (nonatomic, strong) UILabel *lackLabel;
@end

@implementation BFGroupDetailCountdownView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    if (model) {
        
        [self.helpLabel removeFromSuperview];
        self.helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(15))];
        self.helpLabel.text = @"对于诸位大侠的相助，团长感激涕零";
        //self.helpLabel.backgroundColor = [UIColor redColor];
        self.helpLabel.textAlignment = NSTextAlignmentCenter;
        self.helpLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        self.helpLabel.textColor = BFColor(0x5D5D5D);
        [self addSubview:self.helpLabel];
        
        [self.lackLabel removeFromSuperview];
        self.lackLabel = [[UILabel alloc] init];
        //self.lackLabel.text = @"还差3人，盼你如南方人盼暖气~";
        self.lackLabel.backgroundColor = BFColor(0xCACACA);
        self.lackLabel.textAlignment = NSTextAlignmentCenter;
        self.lackLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        self.lackLabel.textColor = BFColor(0x5D5D5D);
        [self addSubview:self.lackLabel];
        BFLog(@"---%@", self.lackLabel.window);
        
        
        if ([model.status isEqualToString:@"0"]) {
            self.lackLabel.frame = CGRectMake(0, CGRectGetMaxY(self.helpLabel.frame)+BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(15));
            NSString *lack = [NSString stringWithFormat:@"%lu", model.havenum];
            self.lackLabel.text = [NSString stringWithFormat:@"还差 %@ 人，盼你如南方人盼暖气~", lack];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.lackLabel.text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xEB0003) range:NSMakeRange(3,lack.length)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(17)] range:NSMakeRange(3,lack.length)];
            self.lackLabel.attributedText = attributedString;
            
            self.countdown.frame = CGRectMake(0, CGRectGetMaxY(self.lackLabel.frame)+BF_ScaleHeight(6), ScreenWidth, BF_ScaleHeight(20));

        }else {
            self.lackLabel.frame = CGRectMake(0, CGRectGetMaxY(self.helpLabel.frame), ScreenWidth, 0);
            
        }
        
        self.countdown = [[BFCountdownView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lackLabel.frame)+BF_ScaleHeight(6), ScreenWidth, BF_ScaleHeight(23))];
        self.countdown.model = model;
        [self addSubview:self.countdown];
        
        //[self.statusLabel removeFromSuperview];
        self.statusLabel = [[UILabel alloc] init];
        //self.statusLabel.backgroundColor = [UIColor blueColor];
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        self.statusLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        self.statusLabel.textColor = BFColor(0x5D5D5D);
        [self addSubview:self.statusLabel];
        
        if ([model.status isEqualToString:@"0"]) {
            self.statusLabel.frame = CGRectMake(0, CGRectGetMaxY(self.countdown.frame)+BF_ScaleHeight(7), ScreenWidth, 0);
            self.countdownViewH = CGRectGetMaxY(self.statusLabel.frame)+BF_ScaleHeight(12);
        }else if([model.status isEqualToString:@"1"]) {
            self.statusLabel.text = @"团购成功，卖家将尽快发货";
            self.statusLabel.frame = CGRectMake(0, CGRectGetMaxY(self.countdown.frame)+BF_ScaleHeight(7), ScreenWidth, BF_ScaleHeight(14));
            self.countdownViewH = CGRectGetMaxY(self.statusLabel.frame)+BF_ScaleHeight(10);
        }else if([model.status isEqualToString:@"2"]) {
            self.statusLabel.text = @"团购失败";
            self.statusLabel.frame = CGRectMake(0, CGRectGetMaxY(self.countdown.frame)+BF_ScaleHeight(7), ScreenWidth, BF_ScaleHeight(14));
            self.countdownViewH = CGRectGetMaxY(self.statusLabel.frame)+BF_ScaleHeight(10);
        }
    }
}



- (void)setView {
    
}

@end
