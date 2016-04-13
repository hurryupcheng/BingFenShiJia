//
//  BFPanicCountdownView.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define ViewH   BF_ScaleHeight(20)
#import "BFPanicCountdownView.h"

@interface BFPanicCountdownView()
/**时*/
@property (nonatomic, strong) UILabel *hour;
/**时*/
@property (nonatomic, strong) UILabel *timeLabel;
/**分*/
@property (nonatomic, strong) UILabel *minute;
/**秒*/
@property (nonatomic, strong) UILabel *second;

@property (nonatomic, strong) NSArray *timeArray;
@end

@implementation BFPanicCountdownView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setModel:(BFPanicBuyingModel *)model {
    _model = model;
    if (model) {
        
        [self refreshTime];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
        
        
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, BF_ScaleHeight(10), BF_ScaleWidth(80), ViewH)];
        self.timeLabel = timeLabel;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = BFColor(0xF9FBFB);
        timeLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        [self addSubview:timeLabel];
        

        
        
        self.hour = [self setUpTimeLabelWithFrame:CGRectMake(CGRectGetMaxX(self.timeLabel.frame)+BF_ScaleWidth(8), BF_ScaleHeight(10), BF_ScaleWidth(30), ViewH)];
        
        
        
        UILabel *firstSemicolon = [self setUpSemicolonLabelWithFrame:CGRectMake(CGRectGetMaxX(self.hour.frame), BF_ScaleHeight(10), BF_ScaleWidth(5), ViewH)];
        [self addSubview:firstSemicolon];
        
        self.minute = [self setUpTimeLabelWithFrame:CGRectMake(CGRectGetMaxX(firstSemicolon.frame), BF_ScaleHeight(10), BF_ScaleWidth(30), ViewH)];
        

        
        UILabel *secondSemicolon = [self setUpSemicolonLabelWithFrame:CGRectMake(CGRectGetMaxX(self.minute.frame), BF_ScaleHeight(10), BF_ScaleWidth(5), ViewH)];
        [self addSubview:secondSemicolon];
        
        self.second = [self setUpTimeLabelWithFrame:CGRectMake(CGRectGetMaxX(secondSemicolon.frame), BF_ScaleHeight(10), BF_ScaleWidth(30), ViewH)];
        

    }
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
    

    NSInteger time;
    if (self.model.is_seckill == 1) {
        time = self.model.seckill_endtime;
        self.timeLabel.text = @"距离结束";
    }else if (self.model.is_seckill == 0) {
        time = self.model.seckill_starttime;
        self.timeLabel.text = @"距离开始";
    }
    
    
    NSDateComponents *betweenDate = [todayCalender components:NSCalendarUnitSecond fromDate:[[NSDate date]init]  toDate:[[NSDate alloc]initWithTimeIntervalSince1970:time] options:0];
    
    NSString *betweenTime;
    
    if (betweenDate.second <= 0){
        self.hour.text = @"00";
        self.minute.text = @"00";
        self.second.text = @"00";
    }else {
        betweenTime = [self hourMinuteSecond:betweenDate.second];
    }
}


- (NSString *)hourMinuteSecond:(NSInteger)time
{
    NSString *timeString;
    
    // 秒
    if (time % 60 < 10 ) {
        timeString = [NSString stringWithFormat:@"0%ld",time%60];
    }else {
        timeString = [NSString stringWithFormat:@"%ld",time%60];
    }
    
    
    self.second.text = timeString;
    // 分
    time /= 60;
    if (time >=0)
    {
        if (time % 60 < 10 ) {
            timeString = [NSString stringWithFormat:@"0%ld",time%60];
        }else {
            timeString = [NSString stringWithFormat:@"%ld",time%60];
        }
        self.minute.text = timeString;
    }
    // 时
    time /= 60;
    if (time >= 0)
    {
        if (time % 60 < 10 ) {
            timeString = [NSString stringWithFormat:@"0%ld",time%60];
        }else {
            timeString = [NSString stringWithFormat:@"%ld",time%60];
        }
        self.hour.text = timeString;
    }
    return timeString;
}




- (UILabel *)setUpTimeLabelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = BFColor(0xFCFCFC);
    label.layer.cornerRadius = 3;
    label.layer.masksToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
    label.textColor = BFColor(0x232323);
    [self addSubview:label];
    return label;
}

//创建冒号label
- (UILabel *)setUpSemicolonLabelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = BFColor(0xFCFCFC);
    label.text = @":";
    return label;
}

@end
