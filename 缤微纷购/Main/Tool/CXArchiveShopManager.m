//
//  CXArchiveShopManager.m
//  2016_Project_TextDemo
//
//  Created by daohe on 16/3/17.
//  Copyright (c) 2016年 CX. All rights reserved.
//

#import "CXArchiveShopManager.h"
#import "BFStorage.h"

/*
     本地化内容
     [对所有key(userID)进行本地化]  [所有商品信息 存放入数组  对数组进行归档  对归档data进行本地化]
     增,删需要对两个本地化同时操作
     好处: 数据操作只需要操作当前用户,减少内存消耗.
     每次开启应用之后保证初始化一次即可.
     [self updateDataSource]  当前数据更新为实时更新,若需要多操作则增加内存损耗,根据需要修改,注释掉本句代码，手动更新.
 
 */
@interface CXArchiveShopManager(){
    NSUserDefaults * _userDefault;
}


/**当前用户id*/
@property (nonatomic,strong) NSString * userID;
/**当前操作用户商品信息*/
@property (nonatomic,strong) BFStorage * shopItem;
/**所有用户ID本地化*/
@property (nonatomic,strong) NSArray * allUserDefaultKeys;
/**当前操作用户的商品信息集合*/
@property (nonatomic,strong) NSArray * itemArray;
@end

@implementation CXArchiveShopManager
SYNTHESIZE_SINGLETON_FOR_CLASS(CXArchiveShopManager);

-(NSUserDefaults *)userDefault{
    _userDefault = [NSUserDefaults standardUserDefaults];
    return _userDefault;
}
-(NSData *)getItemArrayWithUserDefault{
    [self userDefault];
   return [_userDefault objectForKey:_userID];
}
-(void)setItmeArratWithUserDefault:(NSData *)dataSource{
    [self userDefault];
    [_userDefault setObject:dataSource forKey:_userID];
    [_userDefault synchronize];
}
-(NSArray *)getAllUserKeys{
   [self userDefault];
    return [_userDefault objectForKey:@"ARCHIVE_DATA_KEY"];
}
-(void)saveAllUserIDKeys:(NSArray *)array{
    [self userDefault];
    [_userDefault setObject:array forKey:@"ARCHIVE_DATA_KEY"];
    [_userDefault synchronize];
}

#pragma mark -- updateUserKeys
-(NSArray *)updateUserIDkeys{
   
    NSMutableArray * array = [NSMutableArray arrayWithArray:_allUserDefaultKeys];
    if (![array containsObject:_userID]) {
        [array addObject:_userID];
        _allUserDefaultKeys = [array copy];
    }
    return _allUserDefaultKeys;
}
-(void)removeAllKeys{
    [self userDefault];
    [_userDefault removeObjectForKey:@"ARCHIVE_DATA_KEY"];
}
-(void)removeOneUserID:(NSString *)userID{

    if (_allUserDefaultKeys && _allUserDefaultKeys.count) {
        
        NSMutableArray * array = [NSMutableArray arrayWithArray:_allUserDefaultKeys];
        if ([array containsObject:userID]) {
            [array removeObject:userID];
            [self userDefault];
            _allUserDefaultKeys = [array copy];
            [self saveAllUserIDKeys:[array copy]];
        }
    }
}

#pragma mark -- Manager Public Methods
-(void)initWithUserID:(NSString *)userId ShopItem:(BFStorage *)item{

    if(nil == userId && [userId isEqualToString:@""]){
        BFLog(@"----归档出错----用户ID不能为空!!!");
    }
    if (item) {
         self.shopItem = item;  
    }
    self.userID = userId;
 
}
-(void)startArchiveShop{

    if ([self getItemArrayWithUserDefault]) {
        
        if (![self storeChangeShopMunmber:_shopItem.shopID ctrl:YES Num:_shopItem.numbers]) {
          [self insertKeyWithUserIdToDataSource];
        }
    }else{
        
        _allUserDefaultKeys = [self getAllUserKeys];
        [self updateUserIDkeys];
        [self saveAllUserIDKeys:_allUserDefaultKeys];
        
       [self addKeyWithserIDToDataSource];
    }
    
    [self updateDataSource];
}
- (void)shoppingCartChangeNumberWithShopID:(NSString *)shopID ctrl:(BOOL)ctrl num:(NSString *)num{
    if ([self storeChangeShopunmber:shopID ctrl:ctrl Num:[num integerValue]]) {
        [self updateDataSource];
        
    }else{
        BFLog(@"----数据归档出错--- 修改商品数量时为获取到商品信息对象!!!");
    }

}

-(BOOL)storeChangeShopunmber:(NSString *)shopID ctrl:(BOOL)ctrl Num:(NSInteger)index{
    
    BFStorage * storage = [self screachDataSourceWithItem:shopID];
    if (storage) {
        
        if (ctrl) {
            storage.numbers = index;
        }
        [self changeStroage:storage];
        return YES;
    }
    return NO;
}


-(void)shoppingCartChangeNumberWithShopID:(NSString *)shopID ctrl:(BOOL)ctrl{
   
    if ([self storeChangeShopMunmber:shopID ctrl:ctrl Num:1]) {
        [self updateDataSource];
        
    }else{
        BFLog(@"----数据归档出错--- 修改商品数量时为获取到商品信息对象!!!");
    }
}

-(BOOL)storeChangeShopMunmber:(NSString *)shopID ctrl:(BOOL)ctrl Num:(NSInteger)index{

    BFStorage * storage = [self screachDataSourceWithItem:shopID];
    if (storage) {
        
        if (ctrl) {
            storage.numbers += index;
        }else{
            storage.numbers -= index;
        }
        [self changeStroage:storage];
        return YES;
    }
    return NO;
}

//替换元素
-(void)changeStroage:(BFStorage *)stroage{
    
  __block  BFStorage * store;
     [_itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         
         if ([[(BFStorage *)obj shopID] isEqualToString:stroage.shopID]) {
             store = (BFStorage *)obj;
             *stop = YES;
         }
         
     }];
    NSInteger index = [_itemArray indexOfObject:store];
    [[_itemArray mutableCopy] replaceObjectAtIndex:index withObject:stroage];
}

-(void)updateDataSource{
    if(![self setArchiveDataSource]){
        BFLog(@"----归档出错---- 数据源为空!!!");
    }
}
-(NSArray *)getDataSource{
    NSArray * array = [self getArchiveDataSource];
    if (!array || !array.count) {
        BFLog(@"----数据读取----- 此用户无商品!!!");
        return nil;
    }
    return array;
}

-(BOOL)setArchiveDataSource{
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:_itemArray];
    if(nil == data)
        return NO;
    [self setItmeArratWithUserDefault:data];
    return YES;
}

-(NSArray *)getArchiveDataSource{
    
    NSData * data = [self getItemArrayWithUserDefault];
    if(nil == data)
        return nil;
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _itemArray = [array copy];
    return array;
}
#pragma mark -- 修改数据
-(void)addKeyWithserIDToDataSource{
    
    NSArray * array = [NSArray arrayWithObject:_shopItem];
    _itemArray = [array copy];
}
-(void)insertKeyWithUserIdToDataSource{
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:[self getDataSource]];
    [array addObject:_shopItem];
    _itemArray = [array copy];
}
#pragma mark -- 查询数据
-(BFStorage *)screachDataSourceWithItem:(NSString *)shopID{
   
    BFStorage * item = [self getDataSourceWithItem:shopID andArray:nil];
    return item;
}
-(NSArray *)screachDataSourceWithMyShop{
    _itemArray = [[self getDataSource] copy];
    return _itemArray;
}
#pragma mark -- 删除数据
-(void)removeItemKeyWithOneItem:(NSString *)shopID{

     NSArray * array = [self getDataSource];
    BFStorage * item = [self getDataSourceWithItem:shopID andArray:array];
    if (item) {
        NSMutableArray * mutableArr = [NSMutableArray arrayWithArray:array];
        [mutableArr removeObject:item];
        _itemArray = [mutableArr copy];
        [self updateDataSource];
    }else{
        BFLog(@"----删除数据出错----无此用户信息!!!");
    }
}
-(void)removeItemKeyOneDataSource:(NSString *)userID{
   
    [self removeOneUserID:userID];
    [self userDefault];
    [_userDefault removeObjectForKey:userID];
    [_userDefault synchronize];
    if ([userID isEqualToString:_userID]) {
        _itemArray = nil;
    }
}
-(void)removeAllKeysWithDataSource{

   [_allUserDefaultKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       [self removeOneUserID:obj];
   }];
    _allUserDefaultKeys = nil;
}

-(BFStorage *)getDataSourceWithItem:(NSString *)shopID andArray:(NSArray *)array{
    
    if (!array) {
           array = [self getDataSource];
        _itemArray = [array copy];
    }
    
    __block BFStorage * item = nil;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BFStorage * model = (BFStorage *)obj;

        if ([model.shopID isEqualToString:shopID]) {
            item = model;
            *stop = YES;
        }
    }];
    return item;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
