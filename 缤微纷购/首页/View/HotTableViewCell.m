//
//  HotTableViewCell.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "Header.h"
#import "HotTableViewCell.h"

@implementation HotTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)arr count:(NSInteger)count{

    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        CGFloat x = kScreenWidth/4;
        for (int i = 0; i < count; i++) {
            self.button = [[UIButton alloc]initWithFrame:CGRectMake((i%4+1)*5+(i%4)* x,(i/4+1)*5+(i/4)*x, x, 30)];
            self.button.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:self.button];
        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
