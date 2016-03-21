//
//  BFLogisticsModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/19.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ProductList;
@interface BFLogisticsModel : NSObject
/**id*/
@property (nonatomic, strong) NSString *ID;
/**订单编号*/
@property (nonatomic, strong) NSString *orderId;
/**商品单价*/
@property (nonatomic, strong) NSString *goods_sumPrice;
/**订单价格*/
@property (nonatomic, strong) NSString *order_sumPrice;
/**物流单号*/
@property (nonatomic, strong) NSString *freecode;
/**状态3.已发货 4.已完成*/
@property (nonatomic, strong) NSString *status;
/**产品数组*/
@property (nonatomic, strong) NSArray <ProductList *> *item;

@end

@interface ProductList : NSObject
/**商品图片*/
@property (nonatomic, strong) NSString *img;
/**商品标题*/
@property (nonatomic, strong) NSString *title;
/**商品数量*/
@property (nonatomic, strong) NSString *quantity;
/**尺寸*/
@property (nonatomic, strong) NSString *size;
/**颜色*/
@property (nonatomic, strong) NSString *color;
/**商品id*/
@property (nonatomic, strong) NSString *itemId;
@end
