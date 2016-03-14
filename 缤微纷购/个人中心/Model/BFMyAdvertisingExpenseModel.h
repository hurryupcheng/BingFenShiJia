//
//  BFMyAdvertisingExpenseModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/7.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFBaseModel.h"
@interface BFMyAdvertisingExpenseModel : BFBaseModel
/**记录这行是否被打开*/
@property (nonatomic, getter=isOpen) BOOL isOpen;
/**数据数组*/
@property (nonatomic, strong) NSArray *groups;
/**时间*/
@property (nonatomic, copy) NSString *date;
/**当前月份*/
@property (nonatomic, copy) NSString *month;
/**当前年份*/
@property (nonatomic, copy) NSString *year;
/**总金额*/
@property (nonatomic, strong) NSString *total;

+ (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict;
- (instancetype)parsingJsonWithDictionary:(NSDictionary *)dict;
@end
