//
//  BFHomeFunctionView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "BFHomeFunctionView.h"
//#import "BFHomeFunctionButton.h"

@interface BFHomeFunctionView()
/**果食*/
@property (nonatomic, strong) BFHomeFunctionButton *fruitEating;
/**地方特产*/
@property (nonatomic, strong) BFHomeFunctionButton *localSpeciality;
/**休闲零食*/
@property (nonatomic, strong) BFHomeFunctionButton *casualSnacks;
/**酒水*/
@property (nonatomic, strong) BFHomeFunctionButton *wineDrinking;
/**今日特价*/
@property (nonatomic, strong) BFHomeFunctionButton *dailySpecial;
/**新品首发*/
@property (nonatomic, strong) BFHomeFunctionButton *firstPublish;
/**热销排行*/
@property (nonatomic, strong) BFHomeFunctionButton *bestSelling;
/**试吃体验*/
@property (nonatomic, strong) BFHomeFunctionButton *tastingExperience;
/**按钮类型*/
@property (nonatomic, strong) NSArray *buttonArray;


@end

@implementation BFHomeFunctionView

//- (NSArray *)buttonArray {
//    if (!_buttonArray) {
//        _buttonArray = @[BFHomeFunctionViewButtonTypeFruitEating];
//    }
//    return _buttonArray;
//}


- (id)initWithFrame:(CGRect)frame model:(BFHomeModel *)model{
    if (self = [super initWithFrame:frame]) {
        //添加控件
        //[self setView];
        [self setModel:model];
    }
    return self;
}


- (void)setModel:(BFHomeModel *)model {
    _model = model;
    if (model) {
        if ([model.abs_b isKindOfClass:[NSArray class]]) {
            NSArray *array = [BFHomeFunctionButtonList parse:model.abs_b];
            NSUInteger btnCount = array.count;
            CGFloat btnW =  BF_ScaleWidth(75);
            CGFloat btnH = self.height / 2;
            for (NSInteger i = 0; i < btnCount; i++) {
                _btn = [[BFHomeFunctionButton alloc]init];
                _btn.y = i / 4 * btnH;
                _btn.width = btnW;
                _btn.x = i % 4 * btnW + BF_ScaleWidth(10);
                _btn.height = btnH;
                _btn.tag = i;
                BFHomeFunctionButtonList *list = [BFHomeFunctionButtonList parse:array[i]];
                _btn.functionTitleLabel.text = list.title;
                //btn.backgroundColor = [UIColor redColor];
                [_btn.functionImageView sd_setImageWithURL:[NSURL URLWithString:list.img] placeholderImage:[UIImage imageNamed:@"100"]];
                [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_btn];
            }
        }
    }
}


- (void)setView {
    self.fruitEating = [self setUpButtonWithImage:@"iicon01" type:BFHomeFunctionViewButtonTypeFruitEating title:@"果食"];
    
    self.localSpeciality = [self setUpButtonWithImage:@"iicon02" type:BFHomeFunctionViewButtonTypeLocalSpeciality title:@"地方特产"];
    
    self.casualSnacks = [self setUpButtonWithImage:@"iicon03" type:BFHomeFunctionViewButtonTypeCasualSnacks title:@"休闲零食"];
    
    self.wineDrinking = [self setUpButtonWithImage:@"iicon04" type:BFHomeFunctionViewButtonTypeWineDrinking title:@"酒水"];
    
    self.dailySpecial = [self setUpButtonWithImage:@"iicon05" type:BFHomeFunctionViewButtonTypeDailySpecial title:@"今日特价"];
    
    self.firstPublish = [self setUpButtonWithImage:@"iicon06" type:BFHomeFunctionViewButtonTypeFirstPublish title:@"新品首发"];
    
    self.bestSelling = [self setUpButtonWithImage:@"iicon07" type:BFHomeFunctionViewButtonTypeBestSelling title:@"热销排行"];
    
    self.tastingExperience = [self setUpButtonWithImage:@"iicon08" type:BFHomeFunctionViewButtonTypeTastingExperience title:@"试吃体验"];
}

- (BFHomeFunctionButton *)setUpButtonWithImage:(NSString *)image type:(BFHomeFunctionViewButtonType)type title:(NSString *)title{
    BFHomeFunctionButton *button = [[BFHomeFunctionButton alloc] init];
    
    button.tag = type;
    button.functionTitleLabel.text = title;
    button.functionImageView.image = [UIImage imageNamed:image];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}
//
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    // 设置按钮的frame
//    NSUInteger btnCount = self.subviews.count;
//    CGFloat btnW =  BF_ScaleWidth(75);
//    CGFloat btnH = self.height / 2;
//    for (int i = 0; i<btnCount; i++) {
//        BFHomeFunctionButton *btn = self.subviews[i];
//        btn.y = i / 4 * btnH;
//        btn.width = btnW;
//        btn.x = i % 4 * btnW + BF_ScaleWidth(10);
//        btn.height = btnH;
//
//    }
//}

- (void)click:(BFHomeFunctionButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToGotoDifferentViewWithType:list:)]) {
        [self.delegate clickToGotoDifferentViewWithType:sender.tag list:[BFHomeFunctionButtonList parse:self.model.abs_b][sender.tag]];
    }
}

@end
