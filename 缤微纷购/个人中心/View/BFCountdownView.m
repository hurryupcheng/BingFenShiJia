//
//  BFCountdownView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define LabelH   BF_ScaleHeight(23)
#import "BFCountdownView.h"

@interface BFCountdownView()
/**剩余*/
//@property (nonatomic, strong) UILabel *left;
/**时*/
@property (nonatomic, strong) UILabel *hour;
/**分*/
@property (nonatomic, strong) UILabel *minute;
/**秒*/
@property (nonatomic, strong) UILabel *second;

@property (nonatomic, strong) NSArray *timeArray;

@end

@implementation BFCountdownView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor whiteColor];
        [self setView];
    }
    return self;
}

- (void)setModel:(BFGroupDetailModel *)model {
    _model = model;
    if (model) {

        
        [self refreshTime];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    }
}

- (void)setView {
    UILabel *left = [self setUpDescribeLabelWithFrame:CGRectMake(0, 0, BF_ScaleWidth(90), LabelH) text:@"  ————  剩余" textAlignment:NSTextAlignmentRight];
    [self addSubview:left];
    
    self.hour = [self setUpTimeLabelWithFrame:CGRectMake(CGRectGetMaxX(left.frame)+BF_ScaleWidth(3), 0, BF_ScaleWidth(40), LabelH)];
    
    UILabel *firstSemicolon = [self setUpSemicolonLabelWithFrame:CGRectMake(CGRectGetMaxX(self.hour.frame), 0, BF_ScaleWidth(7), LabelH)];
    [self addSubview:firstSemicolon];
    
    self.minute = [self setUpTimeLabelWithFrame:CGRectMake(CGRectGetMaxX(firstSemicolon.frame), 0, BF_ScaleWidth(40), LabelH)];
    
    UILabel *secondSemicolon = [self setUpSemicolonLabelWithFrame:CGRectMake(CGRectGetMaxX(self.minute.frame), 0, BF_ScaleWidth(7), LabelH)];
    [self addSubview:secondSemicolon];
    
    self.second = [self setUpTimeLabelWithFrame:CGRectMake(CGRectGetMaxX(secondSemicolon.frame), 0, BF_ScaleWidth(40), LabelH)];
    
    UILabel *end = [self setUpDescribeLabelWithFrame:CGRectMake(CGRectGetMaxX(self.second.frame)+BF_ScaleWidth(3), 0, BF_ScaleWidth(90), LabelH) text:@"结束  ————  " textAlignment:NSTextAlignmentLeft];
    [self addSubview:end];
}

- (void)refreshTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond |NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitQuarter |NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear fromDate:[NSDate date]];
    
    NSCalendar *todayCalender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *todayDateComponents = [[NSDateComponents alloc] init];
    todayDateComponents.year = dateComponents.year;
    todayDateComponents.month = dateComponents.month;
    todayDateComponents.day = dateComponents.day;
    todayDateComponents.hour = [_timeArray[0] integerValue];
    todayDateComponents.minute = [_timeArray[1] integerValue];
    todayDateComponents.second = [_timeArray[2] integerValue];
    
    
    NSDate *todayDate = [todayCalender dateFromComponents:todayDateComponents];
    
    NSDateComponents *betweenDate = [todayCalender components:NSCalendarUnitSecond fromDate:[[NSDate date]init]  toDate:[[NSDate alloc]initWithTimeIntervalSince1970:[self.model.endtime integerValue]] options:0];
    
    NSString *betweenTime;

    //self.titleLabel.text = [NSString stringWithFormat:@"距离今天\n%@\n还有",_setTimeString];
    
    betweenTime = [self hourMinuteSecond:betweenDate.second];
    BFLog(@"%@,%@,%@",betweenDate,[[NSDate date]init],[[NSDate alloc]initWithTimeIntervalSince1970:[self.model.endtime integerValue]]);
}


- (NSString *)hourMinuteSecond:(NSInteger)time
{
    NSString *timeString;
    
    // 秒
    timeString = [NSString stringWithFormat:@"%ld秒",time%60];
    self.second.text = timeString;
    // 分
    time /= 60;
    if (time >=0)
    {
        timeString = [NSString stringWithFormat:@"%ld分\n%@",time%60,timeString];
        self.minute.text = timeString;
    }
    
    // 时
    time /= 60;
    if (time >= 0)
    {
        timeString = [NSString stringWithFormat:@"%ld小时\n%@",time%60,timeString];
        self.hour.text = timeString;
    }
    
    return timeString;
}




//创建时分秒label
- (UILabel *)setUpTimeLabelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = BFColor(0x313131);
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = BFColor(0xffffff);
    label.text = @"23时";
    label.layer.cornerRadius = 3;
    label.layer.masksToBounds = YES;
    [self addSubview:label];
    return label;
}
//创建冒号label
- (UILabel *)setUpSemicolonLabelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = BFColor(0x5D5D5D);
    label.text = @":";
    return label;
}
//创建剩余和结束label
- (UILabel *)setUpDescribeLabelWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    label.textAlignment = textAlignment;
    label.textColor = BFColor(0x5D5D5D);
    label.text = text;
    return label;
}

@end
