//
//  BFStorage.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFStorage : NSObject<NSCoding>
/**id*/
@property (nonatomic,retain)NSString *shopID;
/**名称*/
@property (nonatomic,retain)NSString *title;
/**图片*/
@property (nonatomic,retain)NSString *img;
/**金额*/
@property (nonatomic,retain)NSString *price;
/**加入数量*/
@property (nonatomic,assign)NSInteger numbers;
/**库存*/
@property (nonatomic,retain)NSString *stock;
/**规格*/
@property (nonatomic,retain)NSString *choose;
/**颜色*/
@property (nonatomic,retain)NSString *color;

- (instancetype)initWithTitle:(NSString *)title img:(NSString *)img money:(NSString *)price number:(NSInteger)number shopId:(NSString *)shopId stock:(NSString *)stock choose:(NSString *)choose color:(NSString *)color;

@end
