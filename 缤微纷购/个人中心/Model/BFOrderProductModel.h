//
//  BFOrderProductModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/16.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFOrderProductModel : NSObject
/**标题*/
@property (nonatomic, strong) NSString *title;
/**图片地址*/
@property (nonatomic, strong) NSString *img;
/**单价*/
@property (nonatomic, strong) NSString *price;
/**质量*/
@property (nonatomic, strong) NSString *quantity;
/**颜色*/
@property (nonatomic, strong) NSString *color;
/**尺寸*/
@property (nonatomic, strong) NSString *size;
/**商品ID*/
@property (nonatomic, strong) NSString *ID;
/**产品*/
@property (nonatomic, strong) NSString *itemid;
@end
