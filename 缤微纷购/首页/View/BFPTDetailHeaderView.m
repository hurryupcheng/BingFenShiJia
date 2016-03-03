//
//  BFPTDetailHeaderView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/2.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPTDetailHeaderView.h"
#import "BFPurchaseButton.h"
@interface BFPTDetailHeaderView ()
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *playLabel;
@property (nonatomic, strong) BFPurchaseButton *groupPurchaseButton;
@property (nonatomic, strong) BFPurchaseButton *alonePurchaseButton;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIView *playView;




@end


@implementation BFPTDetailHeaderView
- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setDetailModel:(BFPTDetailModel *)detailModel {
    _detailModel = detailModel;
    self.cycleScrollView.imageURLStringsGroup = @[detailModel.img,detailModel.img];

    self.titleLabel.text = detailModel.title;
    
    self.detailLabel.frame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.titleLabel.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(20), 0);
    self.detailLabel.text = detailModel.intro;
    [self setLineSpace:BF_ScaleHeight(5) headIndent:BF_ScaleHeight(4) text:self.detailLabel.text  label:self.detailLabel];
    [self.detailLabel sizeToFit];
    
    self.playLabel.frame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.detailLabel.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(20), 0);
    self.playLabel.text = [NSString stringWithFormat:@"支付开团并邀请%@人开团，人数不足自动退款，详见下方拼团玩法",detailModel.team_num];
    [self setLineSpace:BF_ScaleHeight(6) headIndent:0 text:self.playLabel.text label:self.playLabel];
    [self.playLabel sizeToFit];
    
    self.groupPurchaseButton.frame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.playLabel.frame)+BF_ScaleHeight(5), (ScreenWidth-BF_ScaleWidth(25))/2, BF_ScaleHeight(60));
    self.groupPurchaseButton.topLabel.text = [NSString stringWithFormat:@"%@ / 件",detailModel.team_price];
    NSMutableAttributedString *topLabel = [[NSMutableAttributedString alloc] initWithString:self.groupPurchaseButton.topLabel.text];
    [topLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(16)] range:NSMakeRange(0, [detailModel.team_price length])];
    [topLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(10)] range:NSMakeRange([detailModel.team_price length],4)];
    
    self.groupPurchaseButton.topLabel.attributedText = topLabel;

    self.groupPurchaseButton.bottomLabel.text = [NSString stringWithFormat:@"%@人团购>",detailModel.team_num];
    
    self.alonePurchaseButton.frame = CGRectMake(CGRectGetMaxX(self.groupPurchaseButton.frame)+BF_ScaleHeight(5), CGRectGetMaxY(self.playLabel.frame)+BF_ScaleHeight(5), (ScreenWidth-BF_ScaleWidth(25))/2, BF_ScaleHeight(60));
    self.alonePurchaseButton.topLabel.text = [NSString stringWithFormat:@"%@ / 件",detailModel.price];
    NSMutableAttributedString *aloneTopLabel = [[NSMutableAttributedString alloc] initWithString:self.alonePurchaseButton.topLabel.text];
    [aloneTopLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(16)] range:NSMakeRange(0, [detailModel.price length])];
    [aloneTopLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(10)] range:NSMakeRange([detailModel.price length],4)];
    
    self.alonePurchaseButton.topLabel.attributedText = aloneTopLabel;
    
    self.view.frame = CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame)+BF_ScaleHeight(3), ScreenWidth, CGRectGetMaxY(self.alonePurchaseButton.frame)+BF_ScaleWidth(10));
    
    self.playView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)+BF_ScaleWidth(10), ScreenWidth, BF_ScaleHeight(70));
    
    self.headerHeight = CGRectGetMaxY(self.playView.frame);
}



- (void)setView {
    self.backgroundColor = BFColor(0xD4D4D4);
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(140)) delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.cycleScrollView.currentPageDotColor = BFColor(0xFF0000);
    self.cycleScrollView.pageDotColor = BFColor(0xffffff);
    self.cycleScrollView.pageControlDotSize = CGSizeMake(BF_ScaleHeight(8), BF_ScaleHeight(8));
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    [self addSubview:self.cycleScrollView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame)+BF_ScaleHeight(3), ScreenWidth, 0)];
    self.view = view;
    view.backgroundColor = BFColor(0xffffff);
    
    
    CGRect titleFrame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(15), ScreenWidth-BF_ScaleWidth(20), 0);
    self.titleLabel = [UILabel labelWithFrame:titleFrame font:BF_ScaleFont(15) textColor:BFColor(0x000000) text:@"[限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购]"];
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    [view addSubview:self.titleLabel];
    

    CGRect detailFrame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.titleLabel.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(20), 0);
    self.detailLabel = [UILabel labelWithFrame:detailFrame font:BF_ScaleFont(11) textColor:BFColor(0xD4D4D4) text:@"[限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购]"];
    self.detailLabel.numberOfLines = 0;
    [view addSubview:self.detailLabel];
    
    
    CGRect playFrame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.detailLabel.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(20), 0);
    self.playLabel = [UILabel labelWithFrame:playFrame font:BF_ScaleFont(11) textColor:BFColor(0xFF0000) text:@"[限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购]"];
    self.playLabel.numberOfLines = 0;
    [view addSubview:self.playLabel];
    
    

    CGRect groupButton = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.playLabel.frame)+BF_ScaleHeight(5), (ScreenWidth-BF_ScaleWidth(25))/2, BF_ScaleHeight(60));
    self.groupPurchaseButton = [[BFPurchaseButton alloc]initWithFrame:groupButton];
    self.groupPurchaseButton.topLabel.backgroundColor = BFColor(0xFF0000);
    self.groupPurchaseButton.topLabel.text = @"19.90/件";
    self.groupPurchaseButton.bottomLabel.text = @"5人团购>";
    [self.groupPurchaseButton addTarget:self action:@selector(groupPurchase:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.groupPurchaseButton];
    
    CGRect aloneButton = CGRectMake(CGRectGetMaxX(self.groupPurchaseButton.frame)+BF_ScaleHeight(5), CGRectGetMaxY(self.playLabel.frame)+BF_ScaleHeight(5), (ScreenWidth-BF_ScaleWidth(25))/2, BF_ScaleHeight(60));
    self.alonePurchaseButton = [[BFPurchaseButton alloc]initWithFrame:aloneButton];
    self.alonePurchaseButton.topLabel.backgroundColor = BFColor(0xFA6900);
    self.alonePurchaseButton.topLabel.text = @"29.00/件";
    self.alonePurchaseButton.bottomLabel.text = @"单独购买>";
    [self.alonePurchaseButton addTarget:self action:@selector(alonePurchase:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.alonePurchaseButton];
    
    view.height = CGRectGetMaxY(self.alonePurchaseButton.frame)+BF_ScaleWidth(10);
    [self addSubview:view];
    
    
    self.playView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+BF_ScaleWidth(10), ScreenWidth, BF_ScaleHeight(70))];
    self.playView.backgroundColor = BFColor(0xffffff);
    self.playView.backgroundColor = [UIColor blueColor];
    
    
    
    [self addSubview:self.playView];
    
    
    
}

- (void)setLineSpace:(CGFloat)lineSpace  headIndent:(CGFloat)headIndent text:(NSString *)text label:(UILabel *)lable{
    NSMutableAttributedString *detailAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *detailParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [detailParagraphStyle setLineSpacing:lineSpace];//调整行间距
    [detailParagraphStyle setFirstLineHeadIndent:headIndent];
    [detailAttributedString addAttribute:NSParagraphStyleAttributeName value:detailParagraphStyle range:NSMakeRange(0, [text length])];
    lable.attributedText = detailAttributedString;
}


- (void)groupPurchase:(BFPurchaseButton *)sender {
    BFLog(@"团购购买");
}

- (void)alonePurchase:(BFPurchaseButton *)sender {
    BFLog(@"个人购买");
}
@end
