//
//  BFUpYearAndMonthCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFUpYearAndMonthCell.h"

@implementation BFUpYearAndMonthCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFUpYearAndMonthCell";
    BFUpYearAndMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFUpYearAndMonthCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCell];
    }
    return self;
}



- (void)setCell {
    self.yearAndMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(44))];
    self.yearAndMonth.textAlignment = NSTextAlignmentCenter;
    self.yearAndMonth.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(15)];
//    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY/MM"];
//    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//    NSLog(@"dateString:%@",dateString);
//    
//    NSString *year = [dateString substringWithRange:NSMakeRange(0, 4)];
//    NSString *month = [dateString substringWithRange:NSMakeRange(5, 2)];
//    self.yearAndMonth.text = [NSString stringWithFormat:@"%@年%@月", year, month];
    
    
    
    [self addSubview:self.yearAndMonth];
    
}

@end
