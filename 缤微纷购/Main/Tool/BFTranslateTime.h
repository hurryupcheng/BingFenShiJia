//
//  BFTranslateTime.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFTranslateTime : NSObject
/**把返回的时间总秒数转变成 MM月dd日HH时*/
+ (NSString *)translateTimeIntoMonthDayHour:(NSString *)totalSecond;
/**把返回的时间总秒数转变成 HH:mm:ss*/
+ (NSString *)translateTimeIntoTimeInterval:(NSString *)totalSecond;
/**把返回的时间总秒数转变成yyyy-MM-dd HH:mm*/
+ (NSString *)translateTimeIntoCurrurents:(NSString *)totalSecond;
/**把返回的时间总秒数转变成yyyy-MM-dd*/
+ (NSString *)translateTimeIntoCurrurentDate:(NSString *)totalSecond;
/**把返回的时间总秒数转变成yyyy-MM-dd HH:mm:ss*/
+ (NSString *)translateTimeIntoAccurateTime:(NSString *)totalSecond;
/**把返回的时间总秒数转变成yyyy年MM月dd日HH时mm分*/
+ (NSString *)translateTimeIntoAccurateChineseTime:(NSString *)totalSecond;
@end
