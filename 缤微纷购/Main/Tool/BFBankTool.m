//
//  BFBankTool.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFBankTool.h"
#import "BFBankModel.h"
@implementation BFBankTool
+ (NSString *)convertNameIntoIDWithName:(NSString *)name array:(NSArray *)array {
    for (BFBankModel *model in array) {
        if ([name isEqualToString:model.name]) {
            return model.ID;
        }
    }
    return @"";
}
@end
