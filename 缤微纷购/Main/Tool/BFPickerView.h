//
//  BFPickerView.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFBankButton.h"

@protocol BFPickerViewDelegate <NSObject>

- (void)changeButtonStatus;

@end

@interface BFPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

+ (instancetype)pickerView;

@property (nonatomic, copy)void (^block)(NSString *string);
/**数据*/
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id<BFPickerViewDelegate>delegate;

@end
