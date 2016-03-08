//
//  ShoppingViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFZFViewController.h"
#import "FXQViewController.h"
#import "UIImageView+WebCache.h"
#import "BFShoppModel.h"
#import "BFHeaderView.h"
#import "BFOtherView.h"
#import "BFFootView.h"
#import "SPTableViewCell.h"
#import "Header.h"
#import "ShoppingViewController.h"

@interface ShoppingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)SPTableViewCell *sp;
@property (nonatomic,retain)BFOtherView *other;
@property (nonatomic,retain)BFHeaderView *header;
@property (nonatomic,retain)BFFootView *foot;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)UITableView *tabView;
@property (nonatomic,retain)UIButton *rightBut;
@property (nonatomic,retain)UIView *otherView;
@property (nonatomic,retain)NSMutableArray *dateArr;
@property (nonatomic,retain)BFShoppModel *shoppModel;
@property (nonatomic,retain)UIButton *imgButton;
@property (nonatomic,retain)NSMutableArray *imgArray;
@property (nonatomic,retain)UIView *views;

@property (nonatomic,assign)BOOL isEdits; //是否全选
@property (nonatomic,retain)NSMutableArray *selectGoods;// 已选中

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(220, 220, 220, 1.0);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoHomeController)];
    
     self.title = @"购物车";
    
    self.selectGoods = [NSMutableArray array];
    [self getDate];

}

- (void)gotoHomeController {
    self.tabBarController.selectedIndex = 0;
}

//  计算已选商品金额
- (void)countPrice{
    double price = 0.0;
    for (BFShoppModel *model in self.selectGoods) {
        double pri = [model.price doubleValue];
        price += pri*model.number;
    }
    self.foot.money.text = [NSString stringWithFormat:@"合计:¥ %.2f",price];
}

- (void)selectAllBtnClick:(UIButton*)button{
//  点击全选时，把之前已选择的全部删除
    [self.selectGoods removeAllObjects];
    button.selected = !button.selected;
    self.isEdits = button.selected;
    if (self.isEdits) {
        for (BFShoppModel *model in self.dateArr) {
            [self.selectGoods addObject:model];
        }
        
    }else{
        [self.selectGoods removeAllObjects];
    }
    [self.tabView reloadData];
    [self countPrice];
}

- (void)initWithTabView{

    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-(self.foot.height)-160) style:UITableViewStylePlain];
    
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    self.tabView.showsHorizontalScrollIndicator = NO;
    self.tabView.showsVerticalScrollIndicator = NO;
    
    [self.tabView registerClass:[SPTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    self.foot = [[BFFootView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-163, kScreenWidth, 50)];
    _foot.backgroundColor = [UIColor whiteColor];
    [_foot.buyButton addTarget:self action:@selector(jiesuan) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.header = [[BFHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.header.backgroundColor = rgb(220, 220, 220, 1.0);
    self.header.userInteractionEnabled = YES;
    [self.header.allSeled addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  
    [self.view addSubview:self.tabView];
    [self.view addSubview:_foot];
    
}

#pragma  mark tabView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dateArr.count;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.header;
    }else if(section == 2){
        self.views  = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tabView.frame), kScreenWidth, kScreenWidth/4+50)];
        [self initWithLoveView];
        return self.views;
    }else{
        return 0;
    }
    
}

- (void)initWithLoveView{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth/3-20, 1)];
    lab.backgroundColor = [UIColor grayColor];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 0, kScreenWidth/3, 30)];
    labe.text = @"你可能还要买";
    labe.textAlignment = NSTextAlignmentCenter;
    labe.textColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labe.frame)+5, 15, kScreenWidth/3-20, 1)];
    label.backgroundColor = [UIColor grayColor];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(labe.frame)+10, kScreenWidth-60, kScreenWidth/4)];
    
    scroll.contentSize = CGSizeMake(scroll.width*(self.dateArr.count/3), 0);
    scroll.shouldGroupAccessibilityChildren = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.pagingEnabled = YES;
    
    for (int i = 0; i < self.dateArr.count; i++) {
        self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/4*i)+(i*10), 0, kScreenWidth/4, kScreenWidth/4)];
        _imgButton.layer.borderColor = [UIColor grayColor].CGColor;
        _imgButton.layer.borderWidth = 1;
        _imgButton.tag = i;
        _imgButton.userInteractionEnabled = YES;
        
        [_imgButton addTarget:self action:@selector(imgButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_imgButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:self.shoppModel.imgArr[i]] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
        
        [scroll addSubview:_imgButton];
    }
    
    [self.views addSubview:scroll];
    [self.views addSubview:lab];
    [self.views addSubview:labe];
    [self.views addSubview:label];
}

- (void)imgButton:(UIButton *)but{
    FXQViewController *fx = [[FXQViewController alloc]init];
    fx.ID = self.shoppModel.IDArr[but.tag];
    [self.navigationController pushViewController:fx animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else if(section == 1){
        return 7;
    }else{
        return kScreenWidth/4+50;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.isSelected = self.isEdits;
    if ([self.selectGoods containsObject:[self.dateArr objectAtIndex:indexPath.row]]) {
        cell.isSelected = YES;
    }
    
    cell.selBlock = ^(BOOL isSelected){
        if (isSelected) {
            [self.selectGoods addObject:[self.dateArr objectAtIndex:indexPath.row]];
        }else{
            [self.selectGoods removeObject:[self.dateArr objectAtIndex:indexPath.row]];
        }
        
        if (self.selectGoods.count == self.dateArr.count) {
            self.header.allSeled.selected = YES;
        }else{
            self.header.allSeled.selected = NO;
        }
        [self countPrice];
    };
    
    __block SPTableViewCell *weakCell = cell;
    cell.numAddBlock = ^(){
        NSInteger count = [weakCell.add.textF.text integerValue];
        count++;
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        BFShoppModel *model = [self.dateArr objectAtIndex:indexPath.row];
        weakCell.add.textF.text = numStr;
        model.number = count;
       
        [self.dateArr replaceObjectAtIndex:indexPath.row withObject:model];
        if ([self.selectGoods containsObject:model]) {
            [self.selectGoods removeObject:model];
            [self.selectGoods addObject:model];
            [self countPrice];
        }
    };
    
    cell.numCutBlock = ^(){
        NSInteger count = [weakCell.add.textF.text integerValue];
        count--;
        if (count <= 0) {
            return ;
        }  
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        BFShoppModel *model = [self.dateArr objectAtIndex:indexPath.row];
        weakCell.add.textF.text = numStr;
        model.number = count;
        [self.dateArr replaceObjectAtIndex:indexPath.row withObject:model];
        
//        判断已选择数组里有无该对象，有就删除重新添加
        if ([self.selectGoods containsObject:model]) {
            [self.selectGoods removeObject:model];
            [self.selectGoods addObject:model];
            [self countPrice];
        }
    };
    [cell reloadDataWith:[self.dateArr objectAtIndex:indexPath.row]];
    
    [cell.close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    cell.tag = indexPath.row;
    
    NSArray *subViews = [cell.contentView subviews];
    for (id view in subViews) {
        if ([view isKindOfClass:[cell.close class]]) {
            [view setTag:indexPath.row];
            [cell.contentView bringSubviewToFront:view];
        }
    }
    
    return cell;
}
//  移除商品
- (void)close:(UIButton *)button{
    NSArray *arr = [self.tabView visibleCells];
    for (UITableViewCell *cell in arr) {
        if (cell.tag == button.tag) {
            [self.dateArr removeObjectAtIndex:cell.tag];
            [self.tabView reloadData];
            break;
        }
    }

}

- (void)jiesuan{
    BFZFViewController *bfzf = [[BFZFViewController alloc]init];
    [self.navigationController pushViewController:bfzf animated:YES];
}

- (void)getDate{

    NSURL *url = [NSURL URLWithString:@"http://bingo.luexue.com/index.php?m=Json&a=cart"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
      
       if (data != nil) {
           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
           BFShoppModel *shoppModel = [[BFShoppModel alloc]initWithsetDateDictionary:dic];
           self.shoppModel = shoppModel;
           [self.dateArr addObjectsFromArray:shoppModel.dateArr];
        }
       [self initWithTabView];
   }];
}

- (NSMutableArray *)dateArr{
    if (!_dateArr) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    
    [self.selectGoods removeAllObjects];
    self.isEdits = NO;
    self.header.allSeled.selected = NO;
    self.foot.money.text = [NSString stringWithFormat:@"¥:0.00"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
