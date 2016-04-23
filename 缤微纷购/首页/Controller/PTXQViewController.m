//
//  PTXQViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/2/29.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "PTStepViewController.h"
#import "PTStep.h"
#import "PTModel.h"
#import "LBView.h"
#import "Header.h"
#import "Height.h"
#import "PTXQViewController.h"

@interface PTXQViewController ()

@property (nonatomic,retain)PTModel *pt;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UIButton *button;
@property (nonatomic,retain)UIWebView *web;

@end

@implementation PTXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
}

- (void)initWithView{
    
    CGFloat height = kScreenWidth/2+40+[Height heightString:self.pt.title font:13]+220;
    
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -height, kScreenWidth, height)];
    self.imageV.userInteractionEnabled = YES;
    self.imageV.backgroundColor = [UIColor whiteColor];
   
    LBView *lb = [[LBView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
  
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:self.pt.url];

    lb.dataArray = [arr copy];
    lb.isServiceLoadingImage = YES;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lb.frame), kScreenWidth-10, 40)];
    title.text = self.pt.title;
    title.font = [UIFont systemFontOfSize:15];
    title.numberOfLines = 2;
    
    UILabel *info = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(title.frame), kScreenWidth-10, 0)];
    info.text = self.pt.intro;
    info.frame = CGRectMake(5, CGRectGetMaxY(title.frame)+5, kScreenWidth-10, [Height heightString:info.text font:13]);
    info.numberOfLines = 0;
    info.font = [UIFont systemFontOfSize:13];
    info.textColor = [UIColor grayColor];

    UILabel *other = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(info.frame)+5, kScreenWidth-10, 40)];
    other.text = [NSString stringWithFormat:@"支付开团并邀请%@人开团，人数不足自动退款，详见下方拼团玩法",self.pt.team_num];
    other.textColor = [UIColor redColor];
    other.font = [UIFont systemFontOfSize:13];
    other.numberOfLines = 2;
    
    NSArray *array = [NSArray arrayWithObjects:self.pt.team_price,self.pt.price, nil];
    NSArray *arrays = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@人团购>",self.pt.team_num],@"单独购买>" ,nil];
    for (int i = 0; i < 2; i++) {
        self.button = [[UIButton alloc]initWithFrame:CGRectMake(10+(((kScreenWidth-30)/2)*i)+(i*10), CGRectGetMaxY(other.frame)+5, (kScreenWidth-30)/2, 50)];
        
        UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth-30)/2, 30)];
       
        if (i == 0) {
            money.backgroundColor = [UIColor redColor];
        }else{
            money.backgroundColor = [UIColor orangeColor];
        }
        money.text = [NSString stringWithFormat:@"%@/件",array[i]];
        money.textAlignment = NSTextAlignmentCenter;
        money.textColor = [UIColor whiteColor];
        
        UILabel *people = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(money.frame), (kScreenWidth-30)/2, 20)];
        people.text = arrays[i];
        people.textAlignment = NSTextAlignmentCenter;
        people.font = [UIFont systemFontOfSize:14];
        people.textColor = [UIColor whiteColor];
        people.backgroundColor = [UIColor blackColor];
        
        [self.imageV addSubview:self.button];
        [self.button addSubview:money];
        [self.button addSubview:people];
    }
    
    PTStep *step = [[PTStep alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.button.frame)+10, kScreenWidth, 55)];
    [step.ptStep addTarget:self action:@selector(ptStep) forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageV addSubview:step];
    [self.imageV addSubview:lb];
    [self.imageV addSubview:title];
    [self.imageV addSubview:info];
    [self.imageV addSubview:other];
    
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-120)];
    NSURL *url = [NSURL URLWithString:self.pt.info];
    BFLog(@"%@",self.pt.info);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.web.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    [self.web loadRequest:request];
    
    [self.web.scrollView addSubview:self.imageV];
    [self.view addSubview:self.web];
}

- (void)ptStep{
    PTStepViewController *pt = [[PTStepViewController alloc]init];
    [self.navigationController pushViewController:pt animated:YES];
}

- (void)getData{
    NSString *string = [NET_URL stringByAppendingString:@"/index.php?m=Json&a=team_item"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&id=%@",string ,self.ID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       if (data != nil) {
           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           self.pt = [[PTModel alloc]init];
           self.pt.title = [dic valueForKey:@"title"];
           self.pt.intro = [dic valueForKey:@"intro"];
           self.pt.team_price = [dic valueForKey:@"team_price"];
           self.pt.price = [dic valueForKey:@"price"];
           self.pt.team_num = [dic valueForKey:@"team_num"];
           self.pt.info = [dic valueForKey:@"info"];
           
           NSArray *arr = [dic valueForKey:@"imgs"];
           for (NSDictionary *dics in arr) {
               self.pt.url = [dics valueForKey:@"url"];
           }
       }
       [self initWithView];
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
