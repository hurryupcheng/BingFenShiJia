//
//  BFPayoffHeader.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/15.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPayoffHeader : UIView

@property (nonatomic,assign)NSInteger height;
@property (nonatomic,retain)UILabel *number;

//状态label
@property (nonatomic, strong) UILabel *now;
//我们已收到订单label
@property (nonatomic, strong) UILabel *name;
//尽快处理label
@property (nonatomic, strong) UILabel *title;
//状态图片
@property (nonatomic, strong) UIImageView *right;


- (instancetype)initWithFrame:(CGRect)frame timeNum:(NSString *)time img:(NSMutableArray *)imgArr;

@end
