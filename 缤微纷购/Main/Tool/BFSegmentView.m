//
//  BFSegmentView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/14.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFSegmentView.h"

@interface BFSegmentView()
//@property (nonatomic, strong) UISegmentedControl *segmented;

@end

@implementation BFSegmentView

+ (instancetype)segmentView {
    BFSegmentView *segment = [[BFSegmentView alloc] init];
    return segment;
}


- (id) init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, 50);
        self.backgroundColor = BFColor(0xffffff);
    }
    return self;
}


- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenWidth, 0.5)];
//    line.backgroundColor = BFColor(0xA3A3A3);
//    [self addSubview:line];
    
    //NSArray *segmentedArray = @[@"VIP订单",@"客户订单",@"推荐分成订单"];
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:self.titleArray];
    self.segmented = segmented;
    
    [segmented addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventValueChanged];
    //改变segment的字体大小和颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:BFColor(0x0977ca),NSForegroundColorAttributeName,nil];
    //设置各种状态的字体和颜色
    [segmented setTitleTextAttributes:dic forState:UIControlStateNormal];
    segmented.frame = CGRectMake(5, 10, ScreenWidth-10, 30);
    //segmented.backgroundColor = [UIColor redColor];
    [segmented setTintColor:BFColor(0x0977ca)];
    [self addSubview:segmented];

 

}

- (void)click {
    BFLog(@"点击了分段控制器");
    //self.segmented.selectedSegmentIndex = 2;
    [self changeNumber:self.segmented];
}

- (void)changeNumber:(UISegmentedControl *)segment {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:segmentedControl:)]) {
        [self.delegate segmentView:self segmentedControl:segment];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
