//
//  ShoppingViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/4.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "BFEmptyView.h"
#import "LogViewController.h"
#import "PrefixHeader.pch"
#import "ViewController.h"
#import "BFZFViewController.h"
#import "FXQViewController.h"
#import "BFHeaderView.h"
#import "BFOtherView.h"
#import "BFFootViews.h"
#import "SPTableViewCell.h"
#import "Header.h"
#import "ShoppingViewController.h"
#import "CXArchiveShopManager.h"

@interface ShoppingViewController ()<UITableViewDataSource,UITableViewDelegate,BFOtherViewDelegate>
@property (nonatomic,retain)SPTableViewCell *sp;
@property (nonatomic,retain)BFOtherView *other;
@property (nonatomic,retain)BFHeaderView *header;
@property (nonatomic,retain)BFFootViews *foot;
@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UITableView *tabView;
@property (nonatomic,retain)UIButton *rightBut;
@property (nonatomic,retain)UIView *otherView;
@property (nonatomic,retain)NSMutableArray *dateArr;

@property (nonatomic,retain)UIButton *imgButton;
@property (nonatomic,retain)BFStorage *stor;

@property (nonatomic,assign)NSInteger cellHeight;
@property (nonatomic,assign)BOOL isEdits; //是否全选
@property (nonatomic,retain)NSMutableArray *selectGoods;// 已选中
@property (nonatomic,retain)BFUserInfo *userInfo;
@property (nonatomic,retain)UIView *backV;
@property (nonatomic) BOOL footItem;
@property (nonatomic,retain)BFEmptyView *empty;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(220, 220, 220, 1.0);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"laji.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(removeAll)];

     self.title = @"购物车";
}

- (void)data{

    self.empty.backgroundColor = rgb(245, 245, 245, 1.0);
    [_empty.button addTarget:self action:@selector(gotoHomeController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_empty];
    
    if (self.footItem == NO) {
        _other.frame = CGRectMake(0, CGRectGetMinY(self.tabBarController.tabBar.frame)-kScreenWidth/4-115, kScreenWidth, kScreenWidth/4+50);
    }
    [self.view addSubview:_other];
}

#pragma  mark other代理方法
- (void)BFOtherViewDelegate:(BFOtherView *)otherView ID:(NSString *)itemID{

    FXQViewController *fx = [[FXQViewController alloc]init];
    fx.ID = itemID;
    [self.navigationController pushViewController:fx animated:YES];
}


#pragma  mark 删除所有商品
- (void)removeAll{
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清除购物车吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alerV = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             if (self.userInfo) {

                [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
                [[CXArchiveShopManager sharedInstance]removeItemKeyOneDataSource:self.userInfo.ID];
                UITabBarController *tabBar = [self.tabBarController viewControllers][1];
                tabBar.tabBarItem.badgeValue = nil;

                [self.dateArr removeAllObjects];
                [self.tabView reloadData];
                if (self.dateArr.count == 0) {
                    self.footItem = NO;
                    [self.tabView removeFromSuperview];
                    [self.foot removeFromSuperview];
                    [self data];
                    [self other];
                }
             }
        
    }];
    UIAlertAction *alers = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [aler addAction:alers];
    [aler addAction:alerV];
    
    
    [self presentViewController:aler animated:YES completion:nil];
    
}

- (void)gotoHomeController{
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
        self.foot.buyButton.enabled = YES;
    }else{
        [self.selectGoods removeAllObjects];
        self.foot.buyButton.enabled = NO;
    }
    [self.tabView reloadData];
    [self countPrice];
}

- (void)initWithTableView{
    _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self.footItem == YES) {
       [self.view addSubview:_backV];
    }

    self.tabView = [[UITableView alloc]init];
    
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    self.tabView.showsHorizontalScrollIndicator = NO;
    self.tabView.showsVerticalScrollIndicator = NO;
    
    [self.tabView registerClass:[SPTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    self.foot = [[BFFootViews alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.tabBarController.tabBar.frame)-115, kScreenWidth, 50) money:@"合计:¥ 0.00" home:nil name:@"马上结算"];
    _foot.backgroundColor = [UIColor whiteColor];
    _foot.buyButton.enabled = NO;
    [_foot.buyButton addTarget:self action:@selector(jiesuan) forControlEvents:UIControlEventTouchUpInside];
    
    self.tabView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-(self.foot.height)-115);
    
    self.header = [[BFHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.header.backgroundColor = BFColor(0xF3F4F5);
    self.header.userInteractionEnabled = YES;
    [self.header.allSeled addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  
    [self.backV addSubview:self.tabView];
    [self.backV addSubview:_foot];

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
       
        return self.other;
    }else{
        return nil;
    }
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
            self.foot.buyButton.enabled = YES;
        }else{
            [self.selectGoods removeObject:[self.dateArr objectAtIndex:indexPath.row]];
            self.foot.buyButton.enabled = NO;
        }
        
        if (self.selectGoods.count == self.dateArr.count) {
            self.header.allSeled.selected = YES;
        }else{
            self.header.allSeled.selected = NO;
        }

        [self countPrice];
    };
    
    __block SPTableViewCell *weakCell = cell;
    cell.sumBlock = ^(){
        BFStorage *model = [self.dateArr objectAtIndex:indexPath.row];

        NSInteger number = [weakCell.add.textF.text integerValue];
        if (number <= 1 || weakCell.add.textF.text == nil) {
            number = 1;
        }else if (number >= [model.stock integerValue]){
            number = [model.stock integerValue];
        }
        [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
        [[CXArchiveShopManager sharedInstance]shoppingCartChangeNumberWithShopID:model.shopID ctrl:YES num:[NSString stringWithFormat:@"%d",number]];
        
        model.numbers = number;
        
        [self.dateArr replaceObjectAtIndex:indexPath.row withObject:model];
        if ([self.selectGoods containsObject:model]) {
            [self.selectGoods removeObject:model];
            [self.selectGoods addObject:model];
            
        }
        [self countPrice];
    };
    
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
            UITabBarController *tabBar = [self.tabBarController viewControllers][1];
            tabBar.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)self.dateArr.count];

            [self.tabView reloadData];
            if (self.dateArr.count == 0) {
                [self.tabView removeFromSuperview];
                [self.foot removeFromSuperview];
                self.footItem = NO;
                tabBar.tabBarItem.badgeValue = nil;
                [self data];

            }
        }
    }
}

- (void)jiesuan{

    BFZFViewController *bfzf = [[BFZFViewController alloc]init];
    bfzf.modelArr = _selectGoods;
    bfzf.removeBlock = ^(){
        
        [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
        self.dateArr = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
        if (self.dateArr.count == 0) {
            [self.tabView removeFromSuperview];
            [self data];
        }

    };
    [self.navigationController pushViewController:bfzf animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{

    [self.backV removeFromSuperview];
    self.userInfo = [BFUserDefaluts getUserInfo];
    if (self.userInfo == nil) {
        self.footItem = NO;
        [self data];
        [self other];

    }else{
    [[CXArchiveShopManager sharedInstance]initWithUserID:self.userInfo.ID ShopItem:nil];
    self.dateArr = [[[CXArchiveShopManager sharedInstance]screachDataSourceWithMyShop] mutableCopy];
    
    if (self.dateArr.count == 0) {
        self.footItem = NO;
        [self data];
        [self other];
    }else{
        self.footItem = YES;
        [_empty removeFromSuperview];
        [self initWithTableView];
        [self.tabView reloadData];
        [self other];
    }
    }
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.selectGoods removeAllObjects];
    self.isEdits = NO;
    self.header.allSeled.selected = NO;
    self.foot.money.text = [NSString stringWithFormat:@"合计:¥ 0.00"];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (BFEmptyView *)empty{
    if (!_empty) {
        if (self.footItem == NO){
            self.empty = [[BFEmptyView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.other.height-115)];
        }
    }
    return _empty;
}

- (BFOtherView *)other{
    if (!_other) {
        if (self.footItem == NO) {
            _other = [[BFOtherView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.tabBarController.tabBar.frame)-kScreenWidth/4-115, kScreenWidth, kScreenWidth/4+50)];
            
            [self.view addSubview:_other];
        }else{
            _other = [[BFOtherView alloc]init];
            
        }
        self.other.otherDelegate = self;
        self.other.backgroundColor = [UIColor whiteColor];
    }
    return _other;
}


- (NSMutableArray *)dateArr{
    if (!_dateArr) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}

- (NSMutableArray *)selectGoods{
    if (!_selectGoods) {
        _selectGoods = [NSMutableArray array];
    }
    return _selectGoods;
}

//-(void)hideKeyboard:(NSNotification *)noti{
//    
//    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
//    //键盘弹起的时间
//    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
//    CGRect bottomViewFrame = _tabView.frame;
//    bottomViewFrame.origin.y = self.view.frame.size.height-bottomViewFrame.size.height-50;
//    [UIView animateWithDuration:duration delay:0 options:option animations:^{
//        _tabView.frame = bottomViewFrame;
//    } completion:nil];
//    //为了显示动画
//    [self.view layoutIfNeeded];
//    
//}
//-(void)showKeyboard:(NSNotification *)noti{
//    //NSLog(@"userInfo %@",noti.userInfo);
//    //键盘出现后的位置
//    CGRect endframe = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
//    //键盘弹起时的动画效果
//    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
//    //键盘弹起的时间
//    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
//    CGRect bottomViewFrame = _tabView.frame;
//    bottomViewFrame.origin.y = endframe.origin.y - bottomViewFrame.size.height-50;
//    [UIView animateWithDuration:duration delay:0 options:option animations:^{
//        _tabView.frame = bottomViewFrame;
//    } completion:nil];
//    [self.view layoutIfNeeded];
//}
//
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    if ([text isEqualToString:@"\n"]) {
//        
//        [textView resignFirstResponder];
//        
//        return NO;
//        
//    }
//    
//    return YES;
//    
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    
//    self.navigationController.navigationBar.translucent = NO;
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    self.tabBarController.tabBar.hidden = YES;
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
