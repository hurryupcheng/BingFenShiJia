//
//  BFTastingExperienceCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/22.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFTastingExperienceCell.h"

@interface BFTastingExperienceCell()



@end

@implementation BFTastingExperienceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFTastingExperienceCell";
    BFTastingExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFTastingExperienceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), 0, BF_ScaleWidth(100), self.height)];
        self.titleLabel.textColor = BFColor(0x0D0D0D);
        self.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        [self addSubview:self.titleLabel];
        
        UIView *line = [UIView drawLineWithFrame:CGRectMake(0, self.height-0.5, ScreenWidth, 0.5)];
        line.backgroundColor = BFColor(0xD9D9D6);
        [self addSubview:line];
        
        
    }
    return self;
}

@end
