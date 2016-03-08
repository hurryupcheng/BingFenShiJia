//
//  BFShoppModel.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFShoppModel : NSObject

@property (nonatomic,retain)NSString *ID;
@property (nonatomic,retain)NSString *img;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *price;
@property (nonatomic,assign)NSInteger number;
@property (nonatomic,retain)NSMutableArray *dateArr;
@property (nonatomic,retain)NSMutableArray *imgArr;
@property (nonatomic,retain)NSMutableArray *IDArr;

- (instancetype)initWithsetDateDictionary:(NSDictionary *)dic;

@end
