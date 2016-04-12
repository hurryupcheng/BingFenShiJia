//
//  BFBestSellingModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFBestSellingList;
@interface BFBestSellingModel : NSObject
/**总页数*/
@property (nonatomic, assign) NSInteger page_num;
/**产品数组*/
@property (nonatomic, strong) NSArray<BFBestSellingList *> *item;
@end

@interface BFBestSellingList : NSObject
/**商品id*/
@property (nonatomic, strong) NSString *ID;
/**商品图片*/
@property (nonatomic, strong) NSString *img;
/**商品标题*/
@property (nonatomic, strong) NSString *title;
/**商品新价格*/
@property (nonatomic, strong) NSString *price;
/**商品原价格*/
@property (nonatomic, strong) NSString *yprice;
/**商品货号*/
@property (nonatomic, strong) NSString *goods_sn;
/**商品品牌号*/
@property (nonatomic, strong) NSString *brand;
/**商品类别号*/
@property (nonatomic, strong) NSString *cate_id;
/**商品颜色*/
@property (nonatomic, strong) NSString *color;
/**商品尺寸*/
@property (nonatomic, strong) NSString *size;
/**id*/
@property (nonatomic, strong) NSString *thisprice;
/**商品库存*/
@property (nonatomic, strong) NSString *stock;
@end