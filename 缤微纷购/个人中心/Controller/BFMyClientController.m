//
//  BFMyClientController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFMyClientController.h"

@interface BFMyClientController ()<UITableViewDelegate, UITableViewDataSource, BFSegmentViewDelegate>

/**底部tableView*/
@property (nonatomic, strong) UITableView *bottomTableView;
/**上面tableView*/
@property (nonatomic, strong) UITableView *upTableView;
/**自定义分段控制器页面*/
@property (nonatomic, strong) BFSegmentView *segment;
@end

@implementation BFMyClientController

- (UITableView *)bottomTableView {
    if (_bottomTableView) {
//        _bottomTableView = [UITableView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) style:<#(UITableViewStyle)#>
    }
    return _bottomTableView;
}



- (BFSegmentView *)segment {
    if (!_segment) {
        _segment = [BFSegmentView segmentView];
        _segment.delegate = self;
        _segment.titleArray = @[@"已关注", @"未关注", @"直推人数", @"团队人数"];
    }
    return _segment;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segment];
    
}

- (void)segmentView:(BFSegmentView *)segmentView segmentedControl:(UISegmentedControl *)segmentedControl {
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            BFLog(@"点击已关注");
            break;
        case 1:
            BFLog(@"点击未关注");
            break;
        case 2:
            BFLog(@"点击直推人数");
            break;
        case 3:
            BFLog(@"点击团队人数");
            break;
            
        default:
            break;
    }
}



@end
