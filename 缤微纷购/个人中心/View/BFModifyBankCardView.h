//
//  BFModifyBankCardView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFModifyBankDetailInfoView.h"

typedef enum {
    BFChooseButtonTypeBank,//选择银行按钮
    BFChooseButtonTypeProvince,//选择省份按钮
    BFChooseButtonTypeCity,//选择城市按钮
    BFChooseButtonTypeBranch//选择支行按钮
}BFChooseButtonType;

@protocol BFModifyBankCardViewDelegate <NSObject>

- (void)modifyBankInfomation;

@end

@interface BFModifyBankCardView : UIView


@property (nonatomic, strong) BFModifyBankDetailInfoView *detailInfo;
/**代理*/
@property (nonatomic, weak) id<BFModifyBankCardViewDelegate>delegate;

@end
