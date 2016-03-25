//
//  BFGetYearAndMonth.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/25.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGetYearAndMonth.h"

@implementation BFGetYearAndMonth
+ (NSArray *)getTenMonthBeforeTheCurrentTime {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    //截取年份
    NSString *year = [dateString substringWithRange:NSMakeRange(0, 4)];
    //截取月份
    NSString *month = [dateString substringWithRange:NSMakeRange(5, 2)];
    //转换int
    int yearCount = [year intValue];
    int monthCount = [month intValue];
    NSMutableArray *array = [NSMutableArray array];
    //for循环拼接
    if (monthCount/10 == 0) {
        [array addObject:[NSString stringWithFormat:@"%d年0%d月",yearCount,monthCount]];
    }else {
        [array addObject:[NSString stringWithFormat:@"%d年%d月",yearCount,monthCount]];
    }
    for (int i = 0; i < 9; i++) {
        if (monthCount > 1) {
            monthCount--;
        }else {
            yearCount--;
            monthCount = 12;
        }
        if (monthCount/10 == 0) {
            [array addObject:[NSString stringWithFormat:@"%d年0%d月",yearCount,monthCount]];
        }else {
            [array addObject:[NSString stringWithFormat:@"%d年%d月",yearCount,monthCount]];
        }
    }
    return [array copy];
}
@end
