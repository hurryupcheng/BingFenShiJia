//
//  BFBestSellingCell.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/11.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFBestSellingModel.h"

@protocol BFBestSellingCellDelegate <NSObject>
//加入购物车代理
- (void)addToShoppingCartWithButton:(UIButton *)button;
//没有登录登录的代理
- (void)gotoLogin;

@end


@interface BFBestSellingCell : UITableViewCell
/**自定义方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**代理*/
@property (nonatomic, weak) id<BFBestSellingCellDelegate>delegate;
/**BFBestSellingModel*/
@property (nonatomic, strong) BFBestSellingList *model;
/**商品标题*/
@property (nonatomic, strong) UIButton *shoppingCart;
@end
