//
//  BFBankButton.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/9.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBankButton.h"

@interface BFBankButton()

@end

@implementation BFBankButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.buttonTitle = [[UILabel alloc]initWithFrame:CGRectMake(BF_ScaleWidth(5), 0, self.width-BF_ScaleHeight(30), self.height)];
        self.buttonTitle.font = [UIFont systemFontOfSize:BF_ScaleFont(12)];
        self.buttonTitle.textColor = BFColor(0x454545);
        self.buttonTitle.textAlignment = NSTextAlignmentLeft;
        //self.buttonTitle.backgroundColor = [ UIColor blueColor];
        [self addSubview:self.buttonTitle];
 

        
    }
    return self;
}

@end
