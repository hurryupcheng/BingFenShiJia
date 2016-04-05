//
//  BFTranslateTime.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFTranslateTime.h"

@implementation BFTranslateTime
+ (NSString *)translateTimeIntoTimeInterval:(NSString *)totalSecond {
    NSInteger total = [totalSecond integerValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:total];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:date];
    //HUALog(@"%@",timeStr);
    return timeStr;
}


+ (NSString *)translateTimeIntoCurrurents:(NSString *)totalSecond{
    NSInteger total = [totalSecond integerValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:total];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *timeStr = [formatter stringFromDate:date];
    //HUALog(@"%@",timeStr);
    return timeStr;
}

+ (NSString *)translateTimeIntoCurrurentDate:(NSString *)totalSecond {
    NSInteger total = [totalSecond integerValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:total];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [formatter stringFromDate:date];
    //HUALog(@"%@",timeStr);
    return timeStr;
}

+ (NSString *)translateTimeIntoAccurateTime:(NSString *)totalSecond {
    NSInteger total = [totalSecond integerValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:total];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:date];
    //HUALog(@"%@",timeStr);
    return timeStr;
}

+ (NSString *)translateTimeIntoAccurateChineseTime:(NSString *)totalSecond {
    NSInteger total = [totalSecond integerValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:total];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    NSString *timeStr = [formatter stringFromDate:date];
    //HUALog(@"%@",timeStr);
    return timeStr;
}
@end
