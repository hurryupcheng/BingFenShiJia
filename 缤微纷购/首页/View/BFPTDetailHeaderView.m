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


@end


@implementation BFPTDetailHeaderView
- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    self.backgroundColor = BFColor(0xD4D4D4);
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,BF_ScaleHeight(10), ScreenWidth, BF_ScaleHeight(140)) delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    //cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    [self addSubview:self.cycleScrollView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame)+BF_ScaleHeight(3), ScreenWidth, 0)];
    view.backgroundColor = BFColor(0xffffff);
    
    
    CGRect titleFrame = CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(15), ScreenWidth-BF_ScaleWidth(20), 0);
    self.titleLabel = [UILabel labelWithFrame:titleFrame font:BF_ScaleFont(15) textColor:BFColor(0x000000) text:@"[限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购]"];
    self.titleLabel.numberOfLines = 0;
    NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    NSMutableParagraphStyle *titleParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [titleParagraphStyle setFirstLineHeadIndent:BF_ScaleHeight(10)];
    [titleAttributedString addAttribute:NSParagraphStyleAttributeName value:titleParagraphStyle range:NSMakeRange(0, [self.titleLabel.text length])];
    self.titleLabel.attributedText = titleAttributedString;
    [view addSubview:self.titleLabel];
    [self.titleLabel sizeToFit];

    CGRect detailFrame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.titleLabel.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(20), 0);
    self.detailLabel = [UILabel labelWithFrame:detailFrame font:BF_ScaleFont(11) textColor:BFColor(0xD4D4D4) text:@"[限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购]"];
    self.detailLabel.numberOfLines = 0;
    NSMutableAttributedString *detailAttributedString = [[NSMutableAttributedString alloc] initWithString:self.detailLabel.text];
    NSMutableParagraphStyle *detailParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [detailParagraphStyle setLineSpacing:BF_ScaleHeight(3)];//调整行间距
    [detailParagraphStyle setFirstLineHeadIndent:BF_ScaleHeight(10)];
    [detailAttributedString addAttribute:NSParagraphStyleAttributeName value:detailParagraphStyle range:NSMakeRange(0, [self.detailLabel.text length])];
    self.detailLabel.attributedText = detailAttributedString;
    [view addSubview:self.detailLabel];
    [self.detailLabel sizeToFit];
    
    CGRect playFrame = CGRectMake(BF_ScaleWidth(10), CGRectGetMaxY(self.detailLabel.frame)+BF_ScaleHeight(10), ScreenWidth-BF_ScaleWidth(20), 0);
    self.playLabel = [UILabel labelWithFrame:playFrame font:BF_ScaleFont(11) textColor:BFColor(0xFF0000) text:@"[限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购限量抢购]"];
    self.playLabel.numberOfLines = 0;
    NSMutableAttributedString *playAttributedString = [[NSMutableAttributedString alloc] initWithString:self.playLabel.text];
    NSMutableParagraphStyle *playParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [playParagraphStyle setLineSpacing:BF_ScaleHeight(8)];//调整行间距
    [playAttributedString addAttribute:NSParagraphStyleAttributeName value:playParagraphStyle range:NSMakeRange(0, [self.playLabel.text length])];
    self.playLabel.attributedText = playAttributedString;
    [view addSubview:self.playLabel];
    [self.playLabel sizeToFit];
    

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
    
    
    UIView *playView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+BF_ScaleWidth(10), ScreenWidth, BF_ScaleHeight(70))];
    playView.backgroundColor = BFColor(0xffffff);
    

    
    
    [self addSubview:playView];
    
    self.headerHeight = CGRectGetMaxY(playView.frame);
    
}



- (void)groupPurchase:(BFPurchaseButton *)sender {
    BFLog(@"团购购买");
}

- (void)alonePurchase:(BFPurchaseButton *)sender {
    BFLog(@"个人购买");
}
@end
