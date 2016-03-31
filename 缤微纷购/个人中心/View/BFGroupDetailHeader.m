//
//  BFGroupDetailHeader.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/30.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define MarginH   BF_ScaleHeight(10)

#import "BFGroupDetailHeader.h"

@interface BFGroupDetailHeader()
/**成功imageview*/
@property (nonatomic, strong) UIImageView *sucessExpression;
/**失败imageview*/
@property (nonatomic, strong) UIImageView *failExpression;
/**成功的字符串*/
@property (nonatomic, strong) UILabel *success;
/**失败的字符串*/
@property (nonatomic, strong) UILabel *fail;
/**介绍的字符串*/
@property (nonatomic, strong) UILabel *detail;
@end

@implementation BFGroupDetailHeader

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    if (model) {
        if ([model.status isEqualToString:@"1"]) {
            self.backgroundColor = BFColor(0xCACACA);
            self.sucessExpression.hidden = NO;
            self.success.hidden = NO;
            self.detail.hidden = NO;
            self.failExpression.hidden = YES;
            self.fail.hidden = YES;
            self.detail.text = @"订单处理中";
        }else if ([model.status isEqualToString:@"2"]) {
            self.backgroundColor = BFColor(0xF2D8D6);
            self.sucessExpression.hidden = YES;
            self.success.hidden = YES;
            self.detail.hidden = YES;
            self.failExpression.hidden = NO;
            self.fail.hidden = NO;
        }else if ([model.status isEqualToString:@"0"]) {
            self.sucessExpression.hidden = NO;
            self.success.hidden = NO;
            self.detail.hidden = NO;
            self.failExpression.hidden = YES;
            self.fail.hidden = YES;
            self.backgroundColor = BFColor(0xCACACA);
            if ([model.xinxi isEqualToString:@"1"]) {
                self.success.text = @"开团中";
                self.detail.text = @"立即支付";
            }else if ([model.xinxi isEqualToString:@"2"]) {
                self.success.text = @"开团成功";
                self.detail.text = @"快去邀请好友加入吧";
            }else if ([model.xinxi isEqualToString:@"3"]) {
                self.success.text = @"快来入团吧";
                self.detail.text = @"就差你了";
            }else if ([model.xinxi isEqualToString:@"4"]) {
                self.success.text = @"参团成功";
                self.detail.text = @"立马付款";
            }else if ([model.xinxi isEqualToString:@"5"]) {
                self.success.text = @"参团成功";
                self.detail.text = @"继续邀请好友加入吧";
            }
        }
    }
}

- (void)setView {
    
    self.sucessExpression = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(110), MarginH, BF_ScaleWidth(25), BF_ScaleWidth(25))];
    //self.sucessExpression.backgroundColor = BFColor(0x00ff00);
    self.sucessExpression.hidden = YES;
    self.sucessExpression.image = [UIImage imageNamed:@"group_detail_success"];
    [self addSubview:self.sucessExpression];
    
    self.failExpression = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(147.5), MarginH, BF_ScaleWidth(25), BF_ScaleWidth(25))];
    self.failExpression.hidden = YES;
    //self.failExpression.backgroundColor = BFColor(0x00ff00);
    self.failExpression.image = [UIImage imageNamed:@"group_detail_fail"];
    [self addSubview:self.failExpression];
    
    self.success = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.sucessExpression.frame)+BF_ScaleWidth(10), MarginH, BF_ScaleWidth(100), BF_ScaleWidth(25))];
    self.success.hidden = YES;
    self.success.text = @"团购成功";
    self.success.textColor = BFColor(0x156811);
    self.success.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
    [self addSubview:self.success];
    
    self.fail = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.failExpression.frame), ScreenWidth, BF_ScaleWidth(30))];
    self.fail.text = @"团购失败";
    self.fail.hidden = YES;
    self.fail.textAlignment = NSTextAlignmentCenter;
    self.fail.textColor = BFColor(0xCD0E15);
    self.fail.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
    [self addSubview:self.fail];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sucessExpression.frame), ScreenWidth, BF_ScaleHeight(30))];
    self.detail.text = @"订单处理中";
    self.detail.hidden = YES;
    self.detail.textAlignment = NSTextAlignmentCenter;
    self.detail.textColor = BFColor(0x040404);
    self.detail.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [self addSubview:self.detail];
    
}

@end
