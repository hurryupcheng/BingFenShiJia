//
//  ShoppingViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "LogViewController.h"
#import "PrefixHeader.pch"
#import "BFStorage.h"
#import "ViewController.h"
#import "BFZFViewController.h"
#import "FXQViewController.h"
#import "UIImageView+WebCache.h"
#import "BFShoppModel.h"
#import "BFHeaderView.h"
#import "BFOtherView.h"
#import "BFFootViews.h"
#import "SPTableViewCell.h"
#import "Header.h"
#import "ShoppingViewController.h"
#import "CXArchiveShopManager.h"

@interface ShoppingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)SPTableViewCell *sp;
@property (nonatomic,retain)BFOtherView *other;
@property (nonatomic,retain)BFHeaderView *header;
@property (nonatomic,retain)BFFootViews *foot;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)UITableView *tabView;
@property (nonatomic,retain)UIButton *rightBut;
@property (nonatomic,retain)UIView *otherView;
@property (nonatomic,retain)NSMutableArray *dateArr;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)BFShoppModel *shoppModel;
@property (nonatomic,retain)UIButton *imgButton;
@property (nonatomic,retain)NSMutableArray *imgArray;
@property (nonatomic,retain)UIView *views;
@property (nonatomic,retain)BFStorage *stor;
//@property (nonatomic,retain)NSMutableArray *dataArr;

@property (nonatomic,retain)UIScrollView *scroll;
@property (nonatomic,retain)UIView *groubView;
@property (nonatomic,assign)NSInteger cellHeight;
@property (nonatomic,assign)BOOL isEdits; //是否全选
@property (nonatomic,retain)NSMutableArray *selectGoods;// 已选中
@property (nonatomic,retain)BFUserInfo *userInfo;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(220, 220, 220, 1.0);
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoHomeController)];
    
     self.title = @"购物车";
 
}

- (void)data{
    
//    [self getNewDate];
       [self getDate];
        self.views.frame = CGRectMake(0, CGRectGetMinY(self.tabBarController.tabBar.frame)-kScreenWidth/4-115, kScreenWidth, kScreenWidth/4+50);
    
        self.views.backgroundColor = [UIColor whiteColor];
    
        [self.view addSubview:self.views];

       self.groubView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.views.height-115)];
       self.groubView.backgroundColor = rgb(220, 220, 220, 1.0);
       
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/2-CGFloatX(kScreenWidth/4/2)), 10, CGFloatX(kScreenWidth/4), CGFloatY(kScreenWidth/4))];
        img.image = [UIImage imageNamed:@"kongs.png"];
        
        UILabel *kong = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame), kScreenWidth, 30)];
        kong.text = @"您的购物车空空如也～";
        kong.textColor = [UIColor grayColor];
        kong.textAlignment = NSTextAlignmentCenter;
        kong.font = [UIFont systemFontOfSize:CGFloatX(20)];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(kong.frame)+10, kScreenWidth, 30)];
        [button setTitle:@"去首页逛逛" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:CGFloatX(20)];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(gotoHomeController) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/2-CGFloatX(kScreenWidth/4)), CGRectGetMaxY(button.frame), CGFloatX(kScreenWidth/2), CGFloatY(kScreenWidth/2))];
        image.image = [UIImage imageNamed:@"buys.png"];
//        image.backgroundColor = [UIColor redColor];
        [self.view addSubview:_groubView];
        [_groubView addSubview:img];
        [_groubView addSubview:kong];
        [_groubView addSubview:button];
        [_groubView addSubview:image];

}

- (void)gotoHomeController {
    self.tabBarController.selectedIndex = 0;
}

//  计算已选商品金额
- (void)countPrice{
    double price = 0.0;
    for (BFStorage *model in self.selectGoods) {
        double pri = [model.price doubleValue];
        price += pri*model.numbers;
    }
    
    self.foot.money.text = [NSString stringWithFormat:@"合计:¥ %.2f",price];
}

- (void)selectAllBtnClick:(UIButton*)button{
//  点击全选时，把之前已选择的全部删除
    [self.selectGoods removeAllObjects];
    button.selected = !button.selected;
    self.isEdits = button.selected;
    if (self.isEdits) {
        for (BFStorage *model in self.dateArr) {
            [self.selectGoods addObject:model];
        }

    }else{
        [self.selectGoods removeAllObjects];
    }
    [self.tabView reloadData];
    [self countPrice];
}

- (void)initWithTableView{
    
    self.tabView = [[UITableView alloc]init];
    
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    self.tabView.showsHorizontalScrollIndicator = NO;
    self.tabView.showsVerticalScrollIndicator = NO;
    
    [self.tabView registerClass:[SPTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    self.foot = [[BFFootViews alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.tabBarController.tabBar.frame)-115, kScreenWidth, 50) money:@"合计:¥ 0.00" home:nil name:@"马上结算"];
    _foot.backgroundColor = [UIColor whiteColor];
    [_foot.buyButton addTarget:self action:@selector(jiesuan) forControlEvents:UIControlEventTouchUpInside];
    
    self.tabView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-(self.foot.height)-115);
    
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
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.header;
    }else{
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return kScreenWidth/4+50;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return self.views;
    }else{
        return nil;
    }
}

- (void)initWithLoveView{
    [self.tabView reloadData];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth/3-20, 1)];
    lab.backgroundColor = [UIColor grayColor];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 0, kScreenWidth/3, 30)];
    labe.text = @"热门推荐";
    labe.textAlignment = NSTextAlignmentCenter;
    labe.textColor = [UIColor grayColor];
    labe.font = [UIFont systemFontOfSize:CGFloatX(17)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labe.frame)+5, 15, kScreenWidth/3-20, 1)];
    label.backgroundColor = [UIColor grayColor];
    
    self.scroll.frame = CGRectMake(30, CGRectGetMaxY(labe.frame)+10, kScreenWidth-60, (kScreenWidth-90)/3);

    _scroll.contentSize = CGSizeMake(_scroll.width*(self.dataArray.count/3), 0);
    _scroll.shouldGroupAccessibilityChildren = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.pagingEnabled = YES;
  
    for (int i = 0; i < self.dataArray.count; i++) {
        self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(((kScreenWidth-90)/3*i)+(i*10), 0, (kScreenWidth-90)/3, (kScreenWidth-90)/3)];
        _imgButton.layer.borderColor = [UIColor grayColor].CGColor;
        _imgButton.layer.borderWidth = 1;
        _imgButton.tag = i;
        _imgButton.userInteractionEnabled = YES;
        
        [_imgButton addTarget:self action:@selector(imgButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_imgButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:self.shoppModel.imgArr[i]] placeholderImage:[UIImage imageNamed:@"750.jpg"]];
        
        [_scroll addSubview:_imgButton];
    }
    
    [self.views addSubview:_scroll];
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
  
        return self.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        return 7;
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
        BFStorage *model = [self.dateArr objectAtIndex:indexPath.row];
       
        weakCell.add.textF.text = numStr;
        model.numbers = count;
        
        [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
        [[CXArchiveShopManager sharedInstance]shoppingCartChangeNumberWithShopID:model.shopID ctrl:YES];
        
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
        BFStorage *model = [self.dateArr objectAtIndex:indexPath.row];
       
        weakCell.add.textF.text = numStr;
        model.numbers = count;
        [self.dateArr replaceObjectAtIndex:indexPath.row withObject:model];
        
        [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
        [[CXArchiveShopManager sharedInstance]shoppingCartChangeNumberWithShopID:model.shopID ctrl:NO];
        
//        判断已选择数组里有无该对象，有就删除重新添加
        if ([self.selectGoods containsObject:model]) {
            [self.selectGoods removeObject:model];
            [self.selectGoods addObject:model];
            [self countPrice];
        }
    };
    [cell reloadDataWith:[self.dateArr objectAtIndex:indexPath.row]];
    
    self.cellHeight = cell.cellHeight;
    
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

#pragma  mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFStorage *model = [self.dateArr objectAtIndex:indexPath.row];
    FXQViewController *fx = [[FXQViewController alloc]init];
    fx.ID = model.shopID;
    [self.navigationController pushViewController:fx animated:YES];
}

#pragma mark  移除商品
- (void)close:(UIButton *)button{
    NSArray *arr = [self.tabView visibleCells];
    for (UITableViewCell *cell in arr) {
        if (cell.tag == button.tag) {
            BFStorage * storage = [self.dateArr objectAtIndex:cell.tag];
            [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
            [[CXArchiveShopManager sharedInstance]removeItemKeyWithOneItem:storage.shopID];
            
            [self.dateArr removeObjectAtIndex:cell.tag];
            [self.tabView reloadData];
            if (self.dateArr.count == 0) {
                [self.tabView removeFromSuperview];
                [self data];
            }
        }
    }
}

- (void)jiesuan{
    
    BFZFViewController *bfzf = [[BFZFViewController alloc]init];
    bfzf.modelArr = _selectGoods;
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
           self.dataArray = [shoppModel.dateArr copy];

        }
       [self initWithLoveView];
//       [self.tabView reloadData];
       [self.tabView.mj_header endRefreshing];
   }];
}

- (void)viewWillAppear:(BOOL)animated{
    self.userInfo = [BFUserDefaluts getUserInfo];
    if (self.userInfo == nil) {
        [self data];
    }else{
    [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
    self.dateArr = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
    
    if (self.dateArr.count == 0 || self.userInfo == nil) {
//        [self.tabView removeFromSuperview];
        [self data];
       
    }else{
        
//        [self getNewDate];
        [self getDate];
        [_groubView removeFromSuperview];
        [self initWithTableView];
        [self.tabView reloadData];
    }
    }
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.selectGoods removeAllObjects];
    self.isEdits = NO;
    self.header.allSeled.selected = NO;
    self.foot.money.text = [NSString stringWithFormat:@"合计:¥ 0.00"];
    
}

- (UIScrollView *)scroll{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc]init];
    }
    return _scroll;
}

- (UIView *)views{
    if (!_views) {
        _views = [[UIView alloc]init];
    }
    return _views;
}

- (NSMutableArray *)dateArr{
    if (!_dateArr) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)selectGoods{
    if (!_selectGoods) {
        _selectGoods = [NSMutableArray array];
    }
    return _selectGoods;
}

- (void)getNewDate{
  self.tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      [self getDate];
  }];
    [self.tabView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
