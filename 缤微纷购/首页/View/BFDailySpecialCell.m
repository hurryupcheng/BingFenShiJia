//
//  BFDailySpecialCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/13.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFDailySpecialCell.h"
#import "BFTimeView.h"


@interface BFDailySpecialCell()
/**上部倒计时视图*/
@property (nonatomic, strong) BFTimeView *timeView;

@end

@implementation BFDailySpecialCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFDailySpecialCell";
    BFDailySpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFDailySpecialCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.backgroundColor = BFColor(0xF4F4F4);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setModel:(BFDailySpecialProductList *)model {
    _model = model;
    self.timeView = [[BFTimeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(25))];
    self.timeView.model = model;
    [self addSubview:self.timeView];
    
    self.productView = [[BFDailySpecialProductView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeView.frame), ScreenWidth, BF_ScaleHeight(120))];
    self.productView.model = model;
    [self addSubview:self.productView];
    
}

@end
