//
//  BFCountView.h
//  缤微纷购
//
//  Created by 程召华 on 16/4/12.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFProductDetialModel.h"

@interface BFCountView : UIView
/**数量*/
@property (nonatomic, strong) UITextField *countTX;
/**模型*/
@property (nonatomic, strong) BFProductDetialModel *model;
@end
