//
//  Classification.h
//  缤微纷购
//
//  Created by 郑洋 on 16/1/26.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Classification : NSObject


@property (nonatomic,retain)NSString *ID;
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *pid;
@property (nonatomic,strong) NSArray * sub_catesArr;
@property (nonatomic,retain)NSArray *idArr;
@property (nonatomic,retain)NSArray *nameArr;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
@interface ClassificationSubModel : NSObject

@property (nonatomic,retain)NSString *ID;
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *pid;
@property (nonatomic,strong) NSString * imageUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

