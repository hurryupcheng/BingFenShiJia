//
//  BFPanicBuyingCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPanicBuyingCell.h"

@implementation BFPanicBuyingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFPanicBuyingCell";
    BFPanicBuyingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFPanicBuyingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(12), 0, BF_ScaleWidth(100), BF_ScaleHeight(40))];
        self.titleLabel.textColor = BFColor(0x000000);
        self.titleLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(15)];
        [self addSubview:self.titleLabel];
        
        UIView *line = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleHeight(40)-0.5, ScreenWidth, 0.5)];
        line.backgroundColor = BFColor(0xBABABA);
        [self addSubview:line];
        
    }
    return self;
}

@end
