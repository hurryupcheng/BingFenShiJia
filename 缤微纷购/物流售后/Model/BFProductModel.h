//
//  BFProductModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFProductModel : NSObject
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
/***/
@property (nonatomic, strong) NSString *ID;
/***/
@property (nonatomic, strong) NSString *OrderID;
@end
