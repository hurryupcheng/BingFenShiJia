//
//  BFMyCouponsCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define BGViewMarginW  BF_ScaleWidth(25)
#define BGViewMarginH  BF_ScaleHeight(8)
#define BGViewHeight   BF_ScaleHeight(89)
#import "BFMyCouponsCell.h"

@interface BFMyCouponsCell()
/**红包图片*/
@property (nonatomic, strong) UIImageView *redPacketImageView;
/**上面文字miaos*/
@property (nonatomic, strong) UILabel *topTitleLabel;
/**下面文字描述*/
@property (nonatomic, strong) UILabel *bottomTitleLabel;
/**时间*/
@property (nonatomic, strong) UILabel *timeLabel;
@end


@implementation BFMyCouponsCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    BFMyCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIntegral"];
    if (!cell) {
        cell = [[BFMyCouponsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyIntegral"];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        [self setCell];
    }
    return self;
}


- (void)setCell {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(BGViewMarginW, BGViewMarginH, ScreenWidth-2*BGViewMarginW, BGViewHeight)];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-2*BGViewMarginW, BF_ScaleHeight(65))];
    topView.backgroundColor = BFColor(0xF38B2D);
    [bgView addSubview:topView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), ScreenWidth-2*BGViewMarginW, BF_ScaleHeight(24))];
    bottomView.backgroundColor = BFColor(0xEDEDEF);
    [bgView addSubview:bottomView];
    
    self.redPacketImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(12.5), BF_ScaleHeight(12.5), BF_ScaleWidth(35), BF_ScaleHeight(40))];
    self.redPacketImageView.image = [UIImage imageNamed:@"hongbao"];
    self.redPacketImageView.layer.masksToBounds = YES;
    self.redPacketImageView.layer.cornerRadius = 3;
    [topView addSubview:self.redPacketImageView];
    
    self.topTitleLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.redPacketImageView.frame), CGRectGetMinY(self.redPacketImageView.frame), topView.width-CGRectGetMaxX(self.redPacketImageView.frame), self.redPacketImageView.height/2) font:BF_ScaleFont(13) textColor:BFColor(0xffffff) text:@"缤纷世家双11优惠券"];
    self.topTitleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:self.topTitleLabel];
    
    self.bottomTitleLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.redPacketImageView.frame), CGRectGetMaxY(self.topTitleLabel.frame), topView.width-CGRectGetMaxX(self.redPacketImageView.frame), self.redPacketImageView.height/2) font:BF_ScaleFont(13) textColor:BFColor(0xffffff) text:@"限量抢购，半小时内使用有效"];
    self.bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:self.bottomTitleLabel];
    
    UIImageView *timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(10), 0, BF_ScaleWidth(12), bottomView.height)];
    timeImageView.image = [UIImage imageNamed:@"time"];
    timeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [bottomView addSubview:timeImageView];
    
    self.timeLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(timeImageView.frame)+BF_ScaleWidth(12), 0, BF_ScaleWidth(200), bottomView.height) font:BF_ScaleFont(10) textColor:BFColor(0x4C4D4D) text:@"领取时间：2016-09-04 09:04"];
    [bottomView addSubview:self.timeLabel];
}

@end
