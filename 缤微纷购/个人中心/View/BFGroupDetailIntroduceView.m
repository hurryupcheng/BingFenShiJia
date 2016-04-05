//
//  BFGroupDetailIntroduceView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailIntroduceView.h"
#import "BFStepView.h"

@interface BFGroupDetailIntroduceView()
/**步骤1*/
@property (nonatomic, strong) BFStepView *stepOne;
/**步骤2*/
@property (nonatomic, strong) BFStepView *stepTwo;
/**步骤3*/
@property (nonatomic, strong) BFStepView *stepThree;
/**步骤4*/
@property (nonatomic, strong) BFStepView *stepFour;

@end

@implementation BFGroupDetailIntroduceView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

-(void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    if (model) {
        if ([model.status isEqualToString:@"2"]) {
            self.stepThree.hidden = YES;
            self.stepFour.hidden = YES;
        } else if ([model.status isEqualToString:@"1"]) {
            self.stepFour.numberImageView.image = [UIImage imageNamed:@"d2"];
            self.stepFour.upLabel.textColor = BFColor(0xEB2E3D);
            self.stepFour.bottomLabel.textColor = BFColor(0xEB2E3D);
        } else if ([model.status isEqualToString:@"0"]) {
            self.stepThree.numberImageView.image = [UIImage imageNamed:@"c2"];
            self.stepThree.upLabel.textColor = BFColor(0xEB2E3D);
            self.stepThree.bottomLabel.textColor = BFColor(0xEB2E3D);
        }
    }
}

- (void)setView {
    
    UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(100), BF_ScaleHeight(44))];
    introduceLabel.text = @"拼团玩法";
    introduceLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    introduceLabel.textColor = BFColor(0x808080);
    [self addSubview:introduceLabel];
    
    UIButton *detailButton = [UIButton buttonWithType:0];
    detailButton.frame = CGRectMake(BF_ScaleWidth(250), 0, BF_ScaleWidth(60), BF_ScaleHeight(44));
    detailButton.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    [detailButton setTitleColor:BFColor(0x363636) forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
    [self addSubview:detailButton];
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(250), BF_ScaleHeight(35), BF_ScaleWidth(60), BF_ScaleHeight(12))];
    
    arrow.image = [UIImage imageNamed:@"group_detai_arrow"];
    [self addSubview:arrow];
    
    self.stepOne = [self setUpViewWithX:CGRectGetMaxX(self.stepOne.frame) image:@"a1" uptitle:@"选择" bottomTitle:@"心仪商品"];
    
    self.stepTwo = [self setUpViewWithX:CGRectGetMaxX(self.stepOne.frame) image:@"b1" uptitle:@"支付开团" bottomTitle:@"或参团"];
    
    self.stepThree = [self setUpViewWithX:CGRectGetMaxX(self.stepTwo.frame) image:@"c1" uptitle:@"等待好友" bottomTitle:@"参团支付"];
    
    self.stepFour = [self setUpViewWithX:CGRectGetMaxX(self.stepThree.frame) image:@"d1" uptitle:@"达到人数" bottomTitle:@"团购成功"];

    
    
    UIView *line = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(80)-1, ScreenWidth, 1)];
    line.backgroundColor = BFColor(0xCACACA);
    [self addSubview:line];
    
}

//创建view
- (BFStepView *)setUpViewWithX:(CGFloat)x image:(NSString *)image uptitle:(NSString *)uptitle bottomTitle:(NSString *)bottomTitle{
    BFStepView *view = [[BFStepView alloc] initWithFrame:CGRectMake(x, BF_ScaleHeight(44), BF_ScaleWidth(75), BF_ScaleHeight(22))];
    view.numberImageView.image = [UIImage imageNamed:image];
    view.upLabel.text = uptitle;
    view.bottomLabel.text = bottomTitle;
    [self addSubview:view];
    return view;
}


//查看详情
- (void)click:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lookDetail" object:nil];
}


@end
