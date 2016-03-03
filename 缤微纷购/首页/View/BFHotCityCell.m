//
//  BFHotCityCell.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/3.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
/**button宽度*/
#define buttonWidth    ((ScreenWidth-50)/4)
/**button高度*/
#define buttonHeight   BF_ScaleHeight(25)

#define marin     ((44-buttonHeight)/2)
/**横向间距*/
#define transverseMagin  10
/**竖直间距*/
#define verticalMargin    (44-buttonHeight)
#import "BFHotCityCell.h"

@interface BFHotCityCell ()
@property (nonatomic, strong) UIButton *cityButton;

@end

@implementation BFHotCityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"HotCity";
    BFHotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BFHotCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        //cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BFColor(0xF0F1F2);
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self setCell];
    }
    return self;
}

- (void)setCell {
    UIView *view = [[UIView alloc]init];
    NSArray *hotCity = @[@"上海", @"广州", @"北京", @"深圳", @"杭州", @"武汉"];
    // 行数
    NSUInteger rows = (hotCity.count + 4 - 1) / 4;
    for (int i = 0; i < hotCity.count; i++) {
        UIButton *cityButton = [UIButton buttonWithType:0];
        self.cityButton = cityButton;
        cityButton.layer.borderWidth = 1;
        cityButton.layer.borderColor = BFColor(0x202F6F).CGColor;
        cityButton.layer.cornerRadius = 2;
        cityButton.layer.masksToBounds = YES;
        [cityButton setTitleColor:BFColor(0x202F6F) forState:UIControlStateNormal];
        cityButton.titleLabel.font =[UIFont systemFontOfSize:BF_ScaleFont(10)];
        cityButton.frame = CGRectMake(transverseMagin + (i%4) * (buttonWidth+transverseMagin), (i/4) * (buttonHeight+verticalMargin)+marin, buttonWidth, buttonHeight);
        cityButton.tag = i + 1000;
        [cityButton setTitle:hotCity[i] forState:UIControlStateNormal];
        [cityButton addTarget:self action:@selector(chooseHotCity:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cityButton];
    }
    
    view.frame = CGRectMake(0, 0, ScreenWidth, 44*rows);
    self.cellHeight = view.height;
    [self addSubview:view];
}


- (void)chooseHotCity:(UIButton *)sender {
    BFLog(@"选择了城市");
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
