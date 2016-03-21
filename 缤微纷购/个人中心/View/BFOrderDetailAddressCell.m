//
//  BFOrderDetailAddressCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFOrderDetailAddressCell.h"

@interface BFOrderDetailAddressCell()
/**背景图*/
@property (nonatomic, strong) UIImageView *bgImageView;


@end


@implementation BFOrderDetailAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BFOrderDetailAddressCell";
    BFOrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFOrderDetailAddressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(110))];
    self.bgImageView.image = [UIImage imageNamed:@"adds"];
    [self addSubview:self.bgImageView];
}

@end
