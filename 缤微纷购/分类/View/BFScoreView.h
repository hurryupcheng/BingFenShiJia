//
//  BFScoreView.h
//  缤微纷购
//
//  Created by 郑洋 on 16/3/28.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFScoreView : UIView<UITextFieldDelegate>

@property (nonatomic,retain)UITextField *price;
@property (nonatomic,assign)NSInteger height;

@property (nonatomic,copy)void (^scoreBlock)(NSString *str);

- (instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num;
@end
