//
//  BFBankModel.h
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFBranchList;
@interface BFBankModel : NSObject
/**省ID*/
@property (nonatomic, strong) NSString *sheng_id;
/**市ID*/
@property (nonatomic, strong) NSString *shi_id;
/**银行id*/
@property (nonatomic, strong) NSString *bank_id;
/**支行ID*/
@property (nonatomic, strong) NSString *bank_branch;
/**银行id*/
@property (nonatomic, strong) NSArray<BFBranchList *> *bank;
@end

@interface BFBranchList : NSObject
/**name*/
@property (nonatomic, strong) NSString *ID;
/**name*/
@property (nonatomic, strong) NSString *name;
@end