//
//  BFGroupOrderDetailView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#define OrderDetailViewH    BF_ScaleHeight(180)
#define LabelH              BF_ScaleHeight(20)
#import "BFGroupOrderDetailView.h"

@interface BFGroupOrderDetailView()
/**状态图片*/
@property (nonatomic, strong) UIImageView *statusImageView;
/**订单号码*/
@property (nonatomic, strong) UILabel *orderID;
/**订单状态*/
@property (nonatomic, strong) UILabel *orderStatus;
/**总额*/
@property (nonatomic, strong) UILabel *totalPrice;
/**送至*/
@property (nonatomic, strong) UILabel *recieveAddress;
/**收货人*/
@property (nonatomic, strong) UILabel *recievePerson;
/**下单时间*/
@property (nonatomic, strong) UILabel *addOrderTime;
/**配送方式*/
@property (nonatomic, strong) UILabel *distributionMode;
/**订单号码*/
@property (nonatomic, strong) UILabel *orderIDLabel;
/**订单状态*/
@property (nonatomic, strong) UILabel *orderStatusLabel;
/**总额*/
@property (nonatomic, strong) UILabel *totalPriceLabel;
/**送至*/
@property (nonatomic, strong) UILabel *recieveAddressLabel;
/**收货人*/
@property (nonatomic, strong) UILabel *recievePersonLabel;
/**下单时间*/
@property (nonatomic, strong) UILabel *addOrderTimeLabel;
/**配送方式*/
@property (nonatomic, strong) UILabel *distributionModeLabel;
/**商品图片*/
@property (nonatomic, strong) UIImageView *productIcon;
/**商品标题*/
@property (nonatomic, strong) UILabel *productTitle;
/**商品数量*/
@property (nonatomic, strong) UILabel *productCount;
/**商品单价*/
@property (nonatomic, strong) UILabel *productPrice;
/**支付按钮  status=1是显示*/
@property (nonatomic, strong) UIButton *payButton;
@end


@implementation BFGroupOrderDetailView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = BFColor(0xff0000);
        [self setView];
    }
    return self;
}

- (void)setModel:(BFGroupOrderDetailModel *)model {
    _model = model;
    if (model) {
        self.orderID.text = model.orderid;
        
        switch ([model.refund_status integerValue]) {
            case 0:
                if ([model.status isEqualToString:@"1"]) {
                    self.orderStatus.text = @"未付款";
                    self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                    self.payButton.hidden = NO;
                }else if ([model.status isEqualToString:@"2"]) {
                    self.orderStatus.text = @"待发货";
                    self.statusImageView.image = [UIImage imageNamed:@"group_order_detail_pay"];
                    self.payButton.hidden = YES;
                }else if ([model.status isEqualToString:@"3"]) {
                    self.statusImageView.image = [UIImage imageNamed:@"group_order_detail_distribution"];
                    self.orderStatus.text = @"已发货";
                    self.payButton.hidden = YES;
                }else if ([model.status isEqualToString:@"4"]) {
                    self.statusImageView.image = [UIImage imageNamed:@"group_order_detail_signed"];
                    self.orderStatus.text = @"已完成";
                    self.payButton.hidden = YES;
                }else {
                    self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                    self.payButton.hidden = YES;
                    self.orderStatus.text = @"已关闭";
                }

                break;
            case 1:
                self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                self.payButton.hidden = YES;
                self.orderStatus.text = @"待退款";
                break;
            case 2:
                self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                self.payButton.hidden = YES;
                self.orderStatus.text = @"已同意退款";
                break;
            case 3:
                self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                self.payButton.hidden = YES;
                self.orderStatus.text = @"不同意退款";
                break;
            case 4:
                self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                self.payButton.hidden = YES;
                self.orderStatus.text = @"申请退货中";
                break;
            case 5:
                self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                self.payButton.hidden = YES;
                self.orderStatus.text = @"不同意退货";
                break;
            case 6:
                self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                self.payButton.hidden = YES;
                self.orderStatus.text = @"同意退货";
                break;
            case 7:
                self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                self.payButton.hidden = YES;
                self.orderStatus.text = @"等待卖家收货";
                break;
            case 8:
                self.statusImageView.image = [UIImage imageNamed:@"group_order_detail"];
                self.payButton.hidden = YES;
                self.orderStatus.text = @"已退款";
                break;
                
        }
        
        self.totalPrice.text = model.order_sumPrice;
        
        self.recieveAddress.frame = CGRectMake(BF_ScaleWidth(75), self.recieveAddressLabel.y+BF_ScaleHeight(3), BF_ScaleWidth(230), LabelH);
        self.recieveAddress.numberOfLines = 0;
        self.recieveAddress.text = model.address;
        [self.recieveAddress sizeToFit];
        
        
        self.recievePersonLabel.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.recieveAddress.frame)+BF_ScaleHeight(3), BF_ScaleWidth(65), LabelH);
        self.recievePerson.text = [NSString stringWithFormat:@"%@ %@", model.address_name, model.mobile];
        
        self.addOrderTime.text = [NSString stringWithFormat:@"%@", [BFTranslateTime translateTimeIntoAccurateTime:model.add_time]];
        
        self.distributionMode.text = model.userfree;
        
        [self.productIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"goodsImage"]];
        
        self.productTitle.text = model.title;
        
        self.productCount.text = [NSString stringWithFormat:@"数量：%@", model.quantity];
        
        self.productPrice.text = [NSString stringWithFormat:@"¥%@/件", model.team_price];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.productPrice.text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_ScaleFont(17)] range:NSMakeRange(1,model.team_price.length)];
        self.productPrice.attributedText = attributedString;
        
        
        
        [self layoutSubviews];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.orderIDLabel.frame = CGRectMake(BF_ScaleWidth(8), 0, BF_ScaleWidth(65), LabelH);
    
    self.orderID.frame = CGRectMake(BF_ScaleWidth(75), 0, BF_ScaleWidth(245), LabelH);
    
    self.orderStatusLabel.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.orderIDLabel.frame)+BF_ScaleHeight(3), BF_ScaleWidth(65), LabelH);
    
    self.orderStatus.frame = CGRectMake(BF_ScaleWidth(75), self.orderStatusLabel.y, BF_ScaleWidth(245), LabelH);
    
    self.totalPriceLabel.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.orderStatusLabel.frame)+BF_ScaleHeight(3), BF_ScaleWidth(65), LabelH);
    
    self.totalPrice.frame = CGRectMake(BF_ScaleWidth(75), self.totalPriceLabel.y, BF_ScaleWidth(245), LabelH);
    
    self.recieveAddressLabel.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.totalPriceLabel.frame)+BF_ScaleHeight(3), BF_ScaleWidth(65), LabelH);
    
    //self.recieveAddress.frame = CGRectMake(BF_ScaleWidth(75), self.recieveAddressLabel.y+BF_ScaleHeight(3), BF_ScaleWidth(230), LabelH);
    
    self.recievePersonLabel.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.recieveAddress.frame)+BF_ScaleHeight(3), BF_ScaleWidth(65), LabelH);
    
    self.recievePerson.frame = CGRectMake(BF_ScaleWidth(75), self.recievePersonLabel.y, BF_ScaleWidth(245), LabelH);
    
    self.addOrderTimeLabel.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.recievePerson.frame)+BF_ScaleHeight(3), BF_ScaleWidth(65), LabelH);
    
    self.addOrderTime.frame = CGRectMake(BF_ScaleWidth(75), self.addOrderTimeLabel.y, BF_ScaleWidth(245), LabelH);
    
    self.distributionModeLabel.frame = CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(self.addOrderTime.frame)+BF_ScaleHeight(3), BF_ScaleWidth(65), LabelH);
    
    self.distributionMode.frame = CGRectMake(BF_ScaleWidth(75), self.distributionModeLabel.y, BF_ScaleWidth(245), LabelH);
}


- (void)setView {
    self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(100))];
    self.statusImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.statusImageView];
    
    UIView *firstLine = [UIView drawLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.statusImageView.frame), ScreenWidth, 0.5)];
    [self addSubview:firstLine];
    
    UIView *orderDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.statusImageView.frame) + BF_ScaleHeight(15), ScreenWidth, OrderDetailViewH)];
    //orderDetailView.backgroundColor = BFColor(0xff0000);
    [self addSubview:orderDetailView];
    
    UILabel *orderIDLabel = [self setUpLabelWithFrame:CGRectZero text:@"订单号码："];
    self.orderIDLabel = orderIDLabel;
    [orderDetailView addSubview:orderIDLabel];
    
    
    self.orderID = [self setUpLabelWithFrame:CGRectZero textColor:BFColor(0x222222) font:BF_ScaleFont(13) text:@"201603262119451483"];
    [orderDetailView addSubview:self.orderID];
    
    UILabel *orderStatusLabel = [self setUpLabelWithFrame:CGRectZero text:@"订单状态："];
    self.orderStatusLabel = orderStatusLabel;
    [orderDetailView addSubview:orderStatusLabel];
    
    self.orderStatus = [self setUpLabelWithFrame:CGRectZero textColor:BFColor(0xD90006) font:BF_ScaleFont(13) text:@"待发货"];
    [orderDetailView addSubview:self.orderStatus];
    
    UILabel *totalPriceLabel = [self setUpLabelWithFrame:CGRectZero text:@"总 额："];
    self.totalPriceLabel = totalPriceLabel;
    [orderDetailView addSubview:totalPriceLabel];
    
    self.totalPrice = [self setUpLabelWithFrame:CGRectZero textColor:BFColor(0xD4001B) font:BF_ScaleFont(17) text:@"24.90"];
    [orderDetailView addSubview:self.totalPrice];
    
    UILabel *recieveAddressLabel = [self setUpLabelWithFrame:CGRectZero text:@"送 至："];
    self.recieveAddressLabel = recieveAddressLabel;
    [orderDetailView addSubview:recieveAddressLabel];
    
    self.recieveAddress = [self setUpLabelWithFrame:CGRectZero textColor:BFColor(0x4F4F4F) font:BF_ScaleFont(13) text:@"广东省广州市天河区富力盈通通大厦通通大厦通通大厦"];
    self.recieveAddress.numberOfLines = 0;
    [orderDetailView addSubview:self.recieveAddress];
    [self.recieveAddress sizeToFit];
    
    
    UILabel *recievePersonLabel = [self setUpLabelWithFrame:CGRectZero text:@"收 货 人："];
    self.recievePersonLabel = recievePersonLabel;
    [orderDetailView addSubview:recievePersonLabel];
    
    self.recievePerson = [self setUpLabelWithFrame:CGRectZero textColor:BFColor(0x4F4F4F) font:BF_ScaleFont(13) text:@"哈哈哈哈 13986600772"];
    [orderDetailView addSubview:self.recievePerson];
    
    
    UILabel *addOrderTimeLabel = [self setUpLabelWithFrame:CGRectZero text:@"下单时间："];
    self.addOrderTimeLabel = addOrderTimeLabel;
    [orderDetailView addSubview:addOrderTimeLabel];
    
    self.addOrderTime = [self setUpLabelWithFrame:CGRectZero textColor:BFColor(0x222222) font:BF_ScaleFont(13) text:@"2016-03-26 21:03:45"];
    [orderDetailView addSubview:self.addOrderTime];
    
    UILabel *distributionModeLabel = [self setUpLabelWithFrame:CGRectZero text:@"配送方式："];
    self.distributionModeLabel = distributionModeLabel;
    [orderDetailView addSubview:distributionModeLabel];
    
    self.distributionMode = [self setUpLabelWithFrame:CGRectZero textColor:BFColor(0x222222) font:BF_ScaleFont(13) text:@"申通快递"];
    [orderDetailView addSubview:self.distributionMode];
    
    
    
    UILabel *productInfoLabel = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(8), CGRectGetMaxY(orderDetailView.frame)+BF_ScaleHeight(30), BF_ScaleHeight(100), BF_ScaleHeight(16)) text:@"商品信息"];
    productInfoLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(16)];
    [self addSubview:productInfoLabel];
    
    
    
    UIView *productView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(productInfoLabel.frame)+BF_ScaleHeight(25), ScreenWidth, BF_ScaleHeight(90))];
    [self addSubview:productView];
    
    UIView *secondLine = [UIView drawLineWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [productView addSubview:secondLine];
    
    
    self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(BF_ScaleWidth(8), BF_ScaleHeight(15), BF_ScaleHeight(60), BF_ScaleHeight(60))];
    self.productIcon.image = [UIImage imageNamed:@"goodsImage"];
    [productView addSubview:self.productIcon];
    
    self.productTitle = [self setUpLabelWithFrame:CGRectMake(CGRectGetMaxX(self.productIcon.frame) + BF_ScaleWidth(15), self.productIcon.y, BF_ScaleWidth(220), 0) text:@"【万人预售】精选阳西套袋荔枝毛重10斤装顺丰包邮,"];
    self.productTitle.numberOfLines = 0;
    [productView addSubview:self.productTitle];
    [self.productTitle sizeToFit];
    
    
    self.productCount = [self setUpLabelWithFrame:CGRectMake(self.productTitle.x, BF_ScaleHeight(56), BF_ScaleWidth(100), BF_ScaleHeight(20)) textColor:BFColor(0x4F4F4F) font:BF_ScaleFont(13) text:@"数量：1"];
    [productView addSubview:self.productCount];
    
    
    self.productPrice = [self setUpLabelWithFrame:CGRectMake(BF_ScaleWidth(210), BF_ScaleHeight(56), BF_ScaleWidth(100), BF_ScaleHeight(20)) textColor:BFColor(0xD4001B) font:BF_ScaleFont(9) text:@"¥24.9/件"];
    self.productPrice.textAlignment = NSTextAlignmentRight;
    [productView addSubview:self.productPrice];
    
    
    
    UIView *thirdLine = [UIView drawLineWithFrame:CGRectMake(0, productView.height-0.5, ScreenWidth, 0.5)];
    [productView addSubview:thirdLine];
    
    UIButton *checkGroupDetail = [UIButton buttonWithType:0];
    checkGroupDetail.frame = CGRectMake(BF_ScaleWidth(180), CGRectGetMaxY(productView.frame)+BF_ScaleHeight(10), BF_ScaleWidth(120), BF_ScaleHeight(30));
    [checkGroupDetail setTitle:@"查看团详情  >" forState:UIControlStateNormal];
    [checkGroupDetail setTitleColor:BFColor(0x888888) forState:UIControlStateNormal];
    checkGroupDetail.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    checkGroupDetail.layer.borderWidth = 0.5;
    checkGroupDetail.layer.cornerRadius = 4;
    checkGroupDetail.layer.borderColor =BFColor(0x888888).CGColor;
    checkGroupDetail.tag = BFGroupOrderDetailViewButtonTypeGroup;
    [checkGroupDetail addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:checkGroupDetail];
    
    UIButton *payButton = [UIButton buttonWithType:0];
    self.payButton = payButton;
    payButton.frame = CGRectMake(BF_ScaleWidth(20), CGRectGetMaxY(productView.frame)+BF_ScaleHeight(10), BF_ScaleWidth(120), BF_ScaleHeight(30));
    [payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [payButton setTitleColor:BFColor(0xffffff) forState:UIControlStateNormal];
    payButton.backgroundColor = BFColor(0xD4001B);
    payButton.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    payButton.layer.cornerRadius = 4;
    payButton.hidden = YES;
    payButton.tag = BFGroupOrderDetailViewButtonTypePay;
    [payButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:payButton];

    
}

//两个button的点击事件
- (void)click:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToViewWithButtonType:)]) {
        [self.delegate clickToViewWithButtonType:sender.tag];
    }
}



//创建label
- (UILabel *)setUpLabelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    //label.backgroundColor = BFColor(0x00ff00);
    
    return label;
}

//创建label
- (UILabel *)setUpLabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(CGFloat)font text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    //label.backgroundColor = BFColor(0x00ff00);
    
    return label;
}

@end
