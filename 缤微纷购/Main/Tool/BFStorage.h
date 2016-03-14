//
//  BFStorage.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFStorage : NSObject<NSCoding>

@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *img;
@property (nonatomic,retain)NSString *spec;
@property (nonatomic,retain)NSString *money;
@property (nonatomic,assign)NSInteger numbers;

- (instancetype)initWithTitle:(NSString *)title img:(NSString *)img spec:(NSString *)spec money:(NSString *)money number:(NSInteger)number;

@end
