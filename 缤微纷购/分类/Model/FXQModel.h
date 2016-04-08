//
//  FXQModel.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/27.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXQModel : NSObject

@property (nonatomic,retain)NSString *img;
@property (nonatomic,retain)NSString *price;
@property (nonatomic,retain)NSString *yanse;
@property (nonatomic,retain)NSString *choose;
@property (nonatomic,retain)NSString *stock;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *url;
@property (nonatomic,retain)NSString *oldMoney;
@property (nonatomic,retain)NSString *info;
@property (nonatomic,assign)NSInteger numbers;
@property (nonatomic,retain)NSString *shopID;
@property (nonatomic,retain)NSString *color;

@property (nonatomic,retain)NSMutableArray *nameArr;
@property (nonatomic,retain)NSMutableArray *guigeArr;
@property (nonatomic,retain)NSMutableArray *stockArr;
@property (nonatomic,retain)NSMutableArray *imageArr;
@property (nonatomic,retain)NSMutableArray *imgsArr;
@property (nonatomic,retain)NSMutableArray *moneyArr;

@end
