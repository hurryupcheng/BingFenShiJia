//
//  HomeModel.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic,strong) NSArray * bannerDataArray;
@property (nonatomic,strong) NSArray * homeDataArray;
@property (nonatomic,strong) NSArray * footDataArray;
@property (nonatomic,strong) NSArray * oneDataArray;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@interface HomeOtherModel : NSObject //ads_banner ads_foot ads_one

@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * url;
@property (nonatomic,strong) NSString * id_type;


-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@interface HomeSubModel : NSObject //ads_home

@property (nonatomic,retain)NSString *upimg;
@property (nonatomic,retain)NSString *upurl;
@property (nonatomic,retain)NSString *img;
@property (nonatomic,retain)NSString *url;
@property (nonatomic,retain)NSArray *imageArray;
@property (nonatomic,retain)NSArray *idArray;


-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

