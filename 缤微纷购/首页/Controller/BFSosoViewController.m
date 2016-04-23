//
//  BFSosoViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/4/23.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "PrefixHeader.pch"
#import "BFSosoViewController.h"

@interface BFSosoViewController ()
@property (nonatomic,retain)UISearchBar *sear;
@end

@implementation BFSosoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _sear = [[UISearchBar alloc]init];
    self.navigationItem.titleView = _sear;
    _sear.delegate = self;
    
    UIButton * right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 40, 20);
    right.titleLabel.font = [UIFont systemFontOfSize:15];
    [right setTitle:@"取消" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor colorWithRed:78/255.0 green:79/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(sosoBut) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];

}

- (void)sosoBut{
    [_sear resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSString *str = [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"====%@",str);
    [self item:str];
}

- (void)item:(NSString *)str{
    NSString *strs = [NSString stringWithFormat:@"http://bingo.luexue.com/index.php?m=Json&a=search&name=%@",str];
    [BFHttpTool GET:strs params:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}


@end
