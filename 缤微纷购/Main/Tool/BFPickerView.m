//
//  BFPickerView.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/10.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#define navigationViewHeight 44.0f
#define pickViewViewHeight 200.0f
#define buttonWidth 60.0f
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

#import "BFPickerView.h"

@interface BFPickerView()
/**包括导航视图和地址选择视图*/
@property (nonatomic, strong) UIView *bottomView;
/**选择视图*/
@property (nonatomic, strong) UIPickerView *pickView;
/**上面的工具条*/
@property (nonatomic, strong) UIView *tabBarView;
///**数据*/
//@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation BFPickerView

//- (NSArray *)dataArray {
//    if (!_dataArray) {
//        _dataArray = @[@"背景",@"shanghai",@"广州",@"深圳",@"武汉",@"重庆"];
//    }
//    return _dataArray;
//}

+ (instancetype)pickerView {
    static BFPickerView *pickerView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pickerView = [[BFPickerView alloc] init];
    });
    [pickerView showBottomView];
    return pickerView;

}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self _addTapGestureRecognizerToSelf];
        [self _createView];
    }
    return self;
    
}

-(void)_addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}

-(void)_createView
{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenWidth, ScreenHeight, navigationViewHeight+pickViewViewHeight)];
    [self addSubview:_bottomView];
    //工具条
    _tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, navigationViewHeight)];
    _tabBarView.backgroundColor = [UIColor lightGrayColor];
    [_bottomView addSubview:_tabBarView];
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapTabBarView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    [_tabBarView addGestureRecognizer:tapTabBarView];
    NSArray *buttonTitleArray = @[@"取消",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*(ScreenWidth-buttonWidth), 0, buttonWidth, navigationViewHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [_tabBarView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, navigationViewHeight, ScreenWidth, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    _pickView.dataSource = self;
    _pickView.delegate =self;
    [_bottomView addSubview:_pickView];
    
    
}

-(void)tapButton:(UIButton*)button
{
    //点击确定回调block
    if (button.tag == 1) {
        
        NSString *string = [self.dataArray objectAtIndex:[_pickView selectedRowInComponent:0]];

        _block(string);
        
    }
    
    [self hiddenBottomView];
    
    
}



-(void)showBottomView
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.y = ScreenHeight -navigationViewHeight-pickViewViewHeight;
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.y = ScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:16.0f];
    lable.text = [self.dataArray objectAtIndex:row];
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat pickViewWidth = ScreenWidth;
    
    return pickViewWidth;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _dataArray[row];
}

@end
