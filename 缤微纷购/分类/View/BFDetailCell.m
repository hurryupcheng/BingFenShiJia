//
//  BFDetailCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFDetailCell.h"

@implementation BFDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFDetailCell";
    BFDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(20), 0, BF_ScaleWidth(60), BF_ScaleHeight(40))];
        detail.text = @"商品详情";
        detail.textColor = BFColor(0x000000);
        detail.font = [UIFont systemFontOfSize:BF_ScaleFont(13)];
        [self addSubview:detail];
        
        UILabel *advice = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(80), 0, BF_ScaleWidth(100), BF_ScaleHeight(40))];
        advice.text = @"(建议在Wifi浏览)";
        advice.textColor = BFColor(0x8E8E8E);
        advice.font = [UIFont systemFontOfSize:BF_ScaleFont(11)];
        [self addSubview:advice];
        
        UIView *firstLine = [UIView drawLineWithFrame:CGRectMake(0, BF_ScaleWidth(40)-0.5, ScreenWidth, 0.5)];
        firstLine.backgroundColor = BFColor(0xBABABA);
        [self addSubview:firstLine];
    }
    return self;
}


@end
