//
//  BFPayoffViewController.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFGenerateOrderModel.h"
@interface BFPayoffViewController : UIViewController
/**生成订单模型*/
@property (nonatomic, strong) BFGenerateOrderModel *orderModel;

@property (nonatomic,retain) NSString *pay;//支付方式

/**订单编号*/
@property (nonatomic,retain)NSString *orderid;

@property (nonatomic,retain)NSMutableArray *img;
/**商品总价*/
@property (nonatomic,retain) NSString *totalPrice;
/**添加订单时间*/
@property (nonatomic,retain)NSString *addTime;

@end
