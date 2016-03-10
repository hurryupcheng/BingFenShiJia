//
//  HomeModel.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{

    self = [super init];
    if (self) {
        self.bannerDataArray = [self upataOtherModelWithData:dic[@"ads_banner"]];
        self.footDataArray = [self upataOtherModelWithData:dic[@"ads_foot"]];
        self.homeDataArray = [self upataSubModelWithData:dic[@"ads_home"]];
        self.oneDataArray = [self upataOtherModelWithData:dic[@"ads_one"]];
        
    }
    return self;
}

-(NSArray *)upataSubModelWithData:(NSArray *)dataSource{
    
    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dic in dataSource) {
        HomeSubModel * otherModel = [[HomeSubModel alloc]initWithDictionary:dic];
        [dataArray addObject:otherModel];
    }
    return [dataArray copy];
}
-(NSArray *)upataOtherModelWithData:(NSArray *)dataSource{

    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary * dic in dataSource) {
        HomeOtherModel * otherModel = [[HomeOtherModel alloc]initWithDictionary:dic];
        [dataArray addObject:otherModel];
      }
    return [dataArray copy];
}

@end

@implementation HomeSubModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
  
    self = [super init];
    if (self) {

        self.upurl = dic[@"upurl"];
        self.upimg = dic[@"upimg"];
        
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * idArr = [NSMutableArray arrayWithCapacity:0];
        NSArray *arr = [dic valueForKey:@"items"];
        
        for (NSDictionary *dics in arr){
            HomeSubModel *home = [[HomeSubModel alloc]initWithDictionary:dics];
            home.img = dics[@"item_img"];
            home.url = dics[@"item_url"];
            
            [array addObject:home.img];
            [idArr addObject:home.url];
        }
        self.imageArray = [array copy];
        self.idArray = [idArr copy];

    }
    return self;
}

@end

@implementation HomeOtherModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    
    self = [super init];
    if (self) {
        self.content = dic[@"content"];
        self.url = dic[@"url"];
        self.id_type = dic[@"id_type"];
  
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

@end