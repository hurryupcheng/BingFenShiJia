//
//  BFUserModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFBaseModel.h"

@interface BFUserModel : BFBaseModel
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *money;


+ (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict;
- (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict;
@end
