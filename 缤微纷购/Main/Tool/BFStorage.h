//
//  BFStorage.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFStorage : NSObject<NSCoding>

@property (nonatomic,retain)NSString *shopID;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *img;
@property (nonatomic,retain)NSString *price;
@property (nonatomic,assign)NSInteger numbers;
@property (nonatomic,retain)NSString *stock;
@property (nonatomic,retain)NSString *choose;
@property (nonatomic,retain)NSString *color;

- (instancetype)initWithTitle:(NSString *)title img:(NSString *)img money:(NSString *)price number:(NSInteger)number shopId:(NSString *)shopId stock:(NSString *)stock choose:(NSString *)choose color:(NSString *)color;

@end
