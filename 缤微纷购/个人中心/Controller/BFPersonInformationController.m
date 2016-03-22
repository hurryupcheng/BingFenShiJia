//
//  BFPersonInformationController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPersonInformationController.h"
#import "BFAddressController.h"

@interface BFPersonInformationController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIActionSheetDelegate>
/**图片data*/
@property (nonatomic, strong)  NSData *imgData;
/**头像图片*/
@property (nonatomic, strong)UIImageView *imageView;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BFPersonInformationController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self.view addSubview:self.tableView];
}

#pragma mark -- datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 3;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    
    cell.accessoryView.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:BF_ScaleFont(14)];
    cell.detailTextLabel.textColor = BFColor(0x959698);
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"  头像";
                UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-BF_ScaleHeight(70), BF_ScaleHeight(10), BF_ScaleHeight(40), BF_ScaleHeight(40))];
                [headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.user_icon] placeholderImage:[UIImage imageNamed:@"head"]];
                headImageView.layer.cornerRadius = BF_ScaleHeight(20);
                headImageView.layer.masksToBounds = YES;
                headImageView.backgroundColor = [UIColor redColor];
                headImageView.contentMode = UIViewContentModeScaleAspectFill;
                [cell addSubview:headImageView];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                BFLog(@"%@",NSStringFromCGRect(headImageView.frame));
                break;
            }
            case 1:
                cell.textLabel.text = @"  推荐人";
                cell.detailTextLabel.text = userInfo.p_username;
                break;
            case 2:
                cell.textLabel.text = @"  昵称";
                cell.detailTextLabel.text = userInfo.nickname;
                break;
        }
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"  广告主";
        cell.accessoryView = [[UISwitch alloc] init];
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"  地址管理";
                UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
                headImageView.backgroundColor = [UIColor redColor];
                headImageView.frame = CGRectMake(ScreenWidth-BF_ScaleHeight(45), BF_ScaleHeight(10), BF_ScaleHeight(15), BF_ScaleHeight(24));
                headImageView.contentMode = UIViewContentModeScaleAspectFit;
                [cell addSubview:headImageView];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                break;
            }
            case 1:
                cell.textLabel.text = @"  我的名片";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;                break;
            case 2:
                cell.textLabel.text = @"  绑定手机";
                cell.detailTextLabel.text = @"  未绑定";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
        }
    }else {
        cell.textLabel.text = @"  余额";
        UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(90), 0, BF_ScaleWidth(200), 44)];
        balanceLabel.textColor = BFColor(0xFD8727);
        balanceLabel.text = @"¥00.00";
        [cell addSubview:balanceLabel];
        
    }
    return cell;
}


#pragma mark -- delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return BF_ScaleHeight(60);
        }
    }
    return BF_ScaleHeight(44);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BFLog(@"点击头像");
        [self changeHeadIcon];
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            BFAddressController *addressVC = [BFAddressController new];
            [self.navigationController pushViewController:addressVC animated:YES];
            BFLog(@"地址管理");
        }
    }
}

- (void)changeHeadIcon{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加取消按钮
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击");
        
    }];
    
    //添加从手机相册选择
    UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *pc = [UIImagePickerController new];
        //获取图片以后，图片会从代理中回传给我们
        pc.delegate = self;
        // 开启编辑状态
        pc.allowsEditing = YES;
        
        [self presentViewController:pc animated:YES completion:nil];
    }];
    
    //添加拍照
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *pc = [UIImagePickerController new];
        //获取图片以后，图片会从代理中回传给我们
        pc.delegate = self;
        //数据的获取源，模式是相册
        pc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pc animated:YES completion:nil];
        
    }];
    
    [alertC addAction:cancleAction];
    [alertC addAction:pictureAction];
    [alertC addAction:phoneAction];
    
    // [alertC showDetailViewController:[HUAMyInformationViewController new] sender:nil];
    
    [self presentViewController:alertC animated:YES completion:nil];
    
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(60))];
        //footerView.backgroundColor = [UIColor redColor];
        UIButton *exitButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(90), BF_ScaleHeight(15), BF_ScaleWidth(140), BF_ScaleHeight(40)) title:@"退出登录" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
        exitButton.backgroundColor = BFColor(0xFD8727);
        [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:exitButton];
        return footerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return BF_ScaleHeight(90);
    }
    return 0;
}
//推出登录
- (void)exit {
    
    [BFProgressHUD MBProgressFromWindowWithLabelText:@"退出登录" dispatch_get_main_queue:^{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserInfo"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}



#pragma mark - UIImagePickerControllerDelegate
//相片选取控制器 不会把本身消失掉，需要我们在回调中处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
        
        self.imgData = UIImageJPEGRepresentation(image, 0.01);
        
        NSLog(@"您选择了图片");
        NSLog(@"%lu", self.imgData.length);
        //  获取原始视图
        self.imageView.image = info[UIImagePickerControllerOriginalImage];
        //  获取编辑状态的视图
        self.imageView.image = info[UIImagePickerControllerEditedImage];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
}

//修正照片方向(手机转90度方向拍照)
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}






- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
