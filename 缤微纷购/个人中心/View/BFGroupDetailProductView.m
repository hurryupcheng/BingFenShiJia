//
//  BFGroupDetailProductView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailProductView.h"

@interface BFGroupDetailProductView()
/**商品图片*/
@property (nonatomic, strong) UIImageView *cover;
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**商品拼团人数*/
@property (nonatomic, strong) UILabel *teamNumber;

@end


@implementation BFGroupDetailProductView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BFColor(0xffffff);
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
        [self setView];
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    if (model) {
        BFLog(@"BFGroupDetailProductView%@",model.status);
        if ([model.status isEqualToString:@"1"]) {
            self.cover.image = [UIImage imageNamed:@"group_detail_group_success"];
        }else if ([model.status isEqualToString:@"2"]) {
            self.cover.image = [UIImage imageNamed:@"group_detail_group_fail"];
        }
        
        ItemModel *itemModel = [ItemModel parse:model.item];
        [self.productIcon sd_setImageWithURL:[NSURL URLWithString:itemModel.img] placeholderImage:[UIImage imageNamed:@"100.jpg"]];
        
        
        self.productTitle.text = itemModel.title;
        
        self.teamNumber.text = [NSString stringWithFormat:@"%@人团：¥%@/件", itemModel.team_num, itemModel.team_price];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.teamNumber.text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(9)] range:NSMakeRange(itemModel.team_num.length + 3,(self.teamNumber.text.length - itemModel.team_num.length - 3))];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(17)] range:NSMakeRange(itemModel.team_num.length + 4,itemModel.team_price.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:BFColor(0xD00000) range:NSMakeRange(itemModel.team_num.length + 3,(self.teamNumber.text.length - itemModel.team_num.length - 3))];
        self.teamNumber.attributedText = attributedString;

    }
}


- (void)setView {
    UIView *firstLine = [UIView drawLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [self addSubview:firstLine];
    
    self.cover = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(210), 0, BF_ScaleWidth(90), BF_ScaleHeight(110))];
    self.cover.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.cover];
    
    self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(90), BF_ScaleHeight(90))];
    self.productIcon.image = [UIImage imageNamed:@"100.jpg"];
    [self addSubview:self.productIcon];
    
    
    self.productTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame)+BF_ScaleWidth(10), BF_ScaleHeight(20), BF_ScaleWidth(200), 0)];
    self.productTitle.numberOfLines = 0;
    self.productTitle.textColor = BFColor(0x444444);
    self.productTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    self.productTitle.text = @"【早餐佳选】慕思妮慕丝蛋糕1000g 早餐点心";
    [self addSubview:self.productTitle];
    [self.productTitle sizeToFit];
    
    
    self.teamNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.productTitle.x, CGRectGetMaxY(self.productTitle.frame)+BF_ScaleHeight(10), BF_ScaleWidth(200), BF_ScaleHeight(20))];
    self.teamNumber.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    self.teamNumber.textColor = BFColor(0x444444);
    self.teamNumber.text = @"3人团：¥39.90/件";
    [self addSubview:self.teamNumber];
    
    
    UIView *secondLine = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(110)-0.5, ScreenWidth, 0.5)];
    [self addSubview:secondLine];
    
    
    
}

- (void)tap {
    BFLog(@"点击了产品");
    [BFNotificationCenter postNotificationName:@"clickToDetail" object:nil];
}


@end
