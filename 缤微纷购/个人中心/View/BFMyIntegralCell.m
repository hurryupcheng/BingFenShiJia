//
//  BFMyIntegralCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/6.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyIntegralCell.h"

@interface BFMyIntegralCell()
/**积分变化*/
@property (nonatomic, strong) UILabel *integralLabel;
/**积分使用说明*/
@property (nonatomic, strong) UILabel *instructionLabel;
/**使用时间*/
@property (nonatomic, strong) UILabel *timeLabel;
@end


@implementation BFMyIntegralCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    BFMyIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIntegral"];
    if (!cell) {
        cell = [[BFMyIntegralCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyIntegral"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        [self setCell];
    }
    return self;
}

- (void)setModel:(BFScoreModel *)model {
    if ([model.score hasPrefix:@"-"]) {
        self.integralLabel.textColor = BFColor(0x00188F);
        
    }else {
        self.integralLabel.textColor = BFColor(0xFA830E);
        
    }
    self.integralLabel.text = model.score;
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [BFTranslateTime translateTimeIntoCurrurentDate:model.add_time]];
    self.instructionLabel.text = model.action;
}

- (void)setCell {
    self.integralLabel = [UILabel labelWithFrame:CGRectMake(BF_ScaleWidth(10), BF_ScaleHeight(10), BF_ScaleWidth(50), BF_ScaleHeight(20)) font:BF_ScaleFont(13) textColor:nil text:@"+1"];
    
    //self.integralLabel.backgroundColor = [UIColor greenColor];
    [self addSubview:self.integralLabel];
    
    self.instructionLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(self.integralLabel.frame), self.integralLabel.y, BF_ScaleWidth(240), BF_ScaleHeight(20)) font:BF_ScaleFont(11) textColor:BFColor(0x5A5B5B) text:@"订单160108128315消费积分1000抵扣10元"];
    [self addSubview:self.instructionLabel];
    
    
    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, BF_ScaleHeight(35), ScreenWidth-BF_ScaleWidth(10), BF_ScaleHeight(20)) font:BF_ScaleFont(11) textColor:BFColor(0x5A5B5B) text:@"2016-01-08"];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLabel];
    
    UIView *line = [UIView drawLineWithFrame:CGRectMake(0, MyIntegralCellH-0.5, ScreenWidth, 0.5)];
    [self addSubview:line];
}

@end
