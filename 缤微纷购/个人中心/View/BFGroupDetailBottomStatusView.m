//
//  BFGroupDetailBottomStatusView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailBottomStatusView.h"

@interface BFGroupDetailBottomStatusView()
/**状态label*/
@property (nonatomic, strong) UILabel *status;

@end

@implementation BFGroupDetailBottomStatusView

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
            self.backgroundColor = BFColor(0xffffff);
            self.status.text = @"团购成功";
        }else if([model.status isEqualToString:@"2"]){
            self.backgroundColor = BFColor(0xCACACA);
            self.status.text = @"团购失败";
        }else if([model.status isEqualToString:@"0"]){
            self.backgroundColor = BFColor(0xCACACA);
            self.status.text = [NSString stringWithFormat:@"还差 %ld 人，让小伙伴们都来组团吧!", (long)model.havenum];
        }
    }
}

- (void)setView {
    UIView *firstLine = [UIView drawLineWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    firstLine.backgroundColor = BFColor(0xCACACA);
    [self addSubview:firstLine];
    
    UIView *line = [UIView drawLineWithFrame:CGRectMake(BF_ScaleWidth(25), 0, 2, BF_ScaleHeight(20))];
    line.backgroundColor = BFColor(0xD5D5D6);
    [self addSubview:line];
    
    
    UIImageView *headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(7.5), BF_ScaleHeight(20), BF_ScaleHeight(35), BF_ScaleHeight(35))];
    headIcon.image = [UIImage imageNamed:@"group_detail_head_image"];
    headIcon.layer.cornerRadius = BF_ScaleWidth(17.5);
    headIcon.layer.borderColor = BFColor(0xffffff).CGColor;
    headIcon.layer.borderWidth = BF_ScaleWidth(2.5);
    headIcon.layer.masksToBounds = YES;
    headIcon.image = [UIImage imageNamed:@"group_detail_head_image"];
    [self addSubview:headIcon];
    
    self.status = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headIcon.frame)+BF_ScaleWidth(10), headIcon.y, BF_ScaleWidth(250), headIcon.height)];
    self.status.textColor = BFColor(0x757575);
    self.status.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [self addSubview:self.status];
    
    
    UIView *secondLine = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(70)-1, ScreenWidth, 1)];
    secondLine.backgroundColor = BFColor(0xCACACA);
    [self addSubview:secondLine];
    
}

@end
