//
//  BFSosoModel.h
//  缤微纷购
//
//  Created by 郑洋 on 16/5/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFSosoModel : NSObject
/**产品id*/
@property (nonatomic,retain)NSString *ID;
/**产品图片*/
@property (nonatomic,retain)NSString *img;
/**产品名称*/
@property (nonatomic,retain)NSString *title;
/**产品价格*/
@property (nonatomic,retain)NSString *price;

@property (nonatomic,retain)NSMutableArray *IDArr;

@property (nonatomic,retain)NSMutableArray *imgArr;

@end

@interface BFSosoSubModel : NSObject
/**产品名称*/
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSMutableArray *titleArr;
@end

@interface BFSosoSubOtherModel : NSObject
/**产品id*/
@property (nonatomic,retain)NSString *shopID;
/**产品图片*/
@property (nonatomic,retain)NSString *img;
/**产品名称*/
@property (nonatomic,retain)NSString *title;
/**产品价格*/
@property (nonatomic,retain)NSString *price;
/**产品规格*/
@property (nonatomic,retain)NSString *choose;
/**产品颜色*/
@property (nonatomic,retain)NSString *color;
/**产品库存*/
@property (nonatomic,retain)NSString *stock;
/**产品库存*/
@property (nonatomic,retain)NSString *first_stock;
/**展示的价格*/
@property (nonatomic,retain)NSString *first_price;
/**展示的颜色*/
@property (nonatomic,retain)NSString *first_color;
/**展示的尺寸*/
@property (nonatomic,retain)NSString *first_size;

@property (nonatomic,retain)NSMutableArray *shopIDarray;

//- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

