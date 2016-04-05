//
//  BFGroupDetailTeamCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/4/1.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFGroupDetailTeamCell.h"

@interface BFGroupDetailTeamCell()
/**bottomView*/
@property (nonatomic, strong) UIView *bottomView;
/***/
@property (nonatomic, strong) UIImageView *headIcon;

@property (nonatomic, strong) UILabel *nickName;

@property (nonatomic, strong) UILabel *addTime;

@end


@implementation BFGroupDetailTeamCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFGroupDetailTeamCell";
    BFGroupDetailTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFGroupDetailTeamCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xCACACA);
        [self setCell];
    }
    return self;
}

- (void)setCell {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(45))];
    self.bottomView.backgroundColor = BFColor(0xffffff);
    [self addSubview:self.bottomView];
    
    
}

@end
