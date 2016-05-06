//
//  BFPersonInformationController.m
//  缤微纷购
//
//  Created by 程召华 on 16/3/5.
//  Copyright © 2016年 xinxincao. All rights reserved.
//

#import "BFPersonInformationController.h"
#import "BFAddressController.h"
#import "BFHeadSelectionView.h"
#import "BFMyBusinessCardController.h"
#import "BFModifyNicknameController.h"
#import "BFBindPhoneNumberController.h"

@interface BFPersonInformationController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, BFHeadSelectionViewDelegate>
/**图片data*/
@property (nonatomic, strong)  NSData *imgData;
/**头像图片*/
@property (nonatomic, strong)UIImageView *imageView;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**手机注册用户的信息*/
@property (nonatomic, strong) BFUserInfo *userInfo;
@end

@implementation BFPersonInformationController

- (BFUserInfo *)userInfo {
    if (!_userInfo) {
        _userInfo = [BFUserDefaluts getUserInfo];
    }
    return _userInfo;
}


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
                UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-BF_ScaleHeight(90), BF_ScaleHeight(10), BF_ScaleHeight(60), BF_ScaleHeight(60))];
                headImageView.backgroundColor = BFColor(0xffffff);
                headImageView.layer.borderWidth = 1;
                headImageView.layer.borderColor = BFColor(0xffffff).CGColor;
                self.imageView = headImageView;
                if (self.userInfo.app_icon.length != 0) {
                    [headImageView sd_setImageWithURL:[NSURL URLWithString: self.userInfo.app_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
                }else {
                    [headImageView sd_setImageWithURL:[NSURL URLWithString: self.userInfo.user_icon] placeholderImage:[UIImage imageNamed:@"head_image"]];
                }
                
                headImageView.layer.cornerRadius = BF_ScaleHeight(30);
                headImageView.layer.masksToBounds = YES;
                //headImageView.backgroundColor = [UIColor redColor];
                headImageView.contentMode = UIViewContentModeScaleAspectFill;
                [cell addSubview:headImageView];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                BFLog(@"%@",NSStringFromCGRect(headImageView.frame));
                break;
            }
            case 1:
                cell.textLabel.text = @"  推荐人";
                if (self.userInfo.parent_proxy != nil && ![self.userInfo.parent_proxy isEqualToString:@"0"]) {
                    cell.detailTextLabel.text = self.userInfo.p_username.length != 0 ? self.userInfo.p_username : [NSString stringWithFormat:@"bingo_%@", self.userInfo.parent_proxy];
                }
                
                break;
            case 2:
                cell.textLabel.text = @"  昵称";
                if (self.userInfo.nickname != nil) {
                    cell.detailTextLabel.text = self.userInfo.nickname;
                }else {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"bingo_%@", self.userInfo.ID];
                }
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
        }
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"  广告主";
        UISwitch *switchButton = [[UISwitch alloc] init];
        switchButton.userInteractionEnabled = NO;
        switchButton.onTintColor = BFColor(0x0977ca);
        switchButton.tintColor = BFColor(0xBABABA);
        cell.accessoryView = switchButton;
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"  地址管理";
                UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_blue"]];
                //headImageView.backgroundColor = [UIColor redColor];
                headImageView.frame = CGRectMake(ScreenWidth-BF_ScaleHeight(45), BF_ScaleHeight(10), BF_ScaleHeight(18), BF_ScaleHeight(24));
                headImageView.contentMode = UIViewContentModeScaleAspectFit;
                [cell addSubview:headImageView];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                break;
            }
            case 1:{
                cell.textLabel.text = @"  我的名片";
                UIImageView *qrCode = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QRcode"]];
                //qrCode.backgroundColor = [UIColor redColor];
                qrCode.frame = CGRectMake(ScreenWidth-BF_ScaleHeight(45), BF_ScaleHeight(10), BF_ScaleHeight(18), BF_ScaleHeight(24));
                qrCode.contentMode = UIViewContentModeScaleAspectFit;
                [cell addSubview:qrCode];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;                break;
            }
            case 2:
                cell.textLabel.text = @"  绑定手机";
                if (self.userInfo.tel.length != 0) {
                    cell.detailTextLabel.text = self.userInfo.tel;
                }else {
                    cell.detailTextLabel.text =  @"  未绑定";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                break;
        }
    }else {
        cell.textLabel.text = @"  余额";
        UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(BF_ScaleWidth(90), 0, BF_ScaleWidth(200), BF_ScaleHeight(44))];
        balanceLabel.textColor = BFColor(0xFD8727);
        balanceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(15)];
        balanceLabel.text = [NSString stringWithFormat:@"¥ %@", self.userInfo.user_account];;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:balanceLabel.text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:BF_ScaleFont(19)] range:NSMakeRange(2,balanceLabel.text.length-5)];
        balanceLabel.attributedText = attributedString;
        
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
            return BF_ScaleHeight(80);
        }
    }
    return BF_ScaleHeight(44);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BFLog(@"点击头像");

            [self changeHeadIcon];
            
        }else if (indexPath.row == 2) {

            BFModifyNicknameController *modifyNicknameVC = [[BFModifyNicknameController alloc] init];
            modifyNicknameVC.block = ^(BFUserInfo *userInfo) {
                self.userInfo = userInfo;
                [BFUserDefaluts modifyUserInfo:userInfo];
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:modifyNicknameVC animated:YES];
            
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            BFAddressController *addressVC = [BFAddressController new];
            [self.navigationController pushViewController:addressVC animated:YES];
            BFLog(@"地址管理");
        }else if (indexPath.row == 1) {
            BFMyBusinessCardController *myBusinessCardVC = [[BFMyBusinessCardController alloc] init];
            [self.navigationController pushViewController:myBusinessCardVC animated:YES];
        }else {
            if (self.userInfo.tel.length != 0) {
                return;
            }else {
                    BFBindPhoneNumberController *bindPhoneNumberVC = [[BFBindPhoneNumberController alloc] init];
                    bindPhoneNumberVC.block = ^(BFUserInfo *userInfo) {
                        self.userInfo = userInfo;
                        [BFUserDefaluts modifyUserInfo:userInfo];
                        [self.tableView reloadData];
                    };
                    [self.navigationController pushViewController:bindPhoneNumberVC animated:YES];
                
            }
        }
    }
}

#pragma mark -- 点击更换头像
- (void)changeHeadIcon{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    BFHeadSelectionView *headSelectionView = [BFHeadSelectionView headSelectionView];
    headSelectionView.delegate = self;
    [window addSubview:headSelectionView];
}

#pragma mark -- 相机和相册按钮代理
- (void)clickToChooseModeWithType:(BFHeadSelectionViewButtonType)type {
    switch (type) {
        case BFHeadSelectionViewButtonTypeCamera:
            [self openCamera];
            break;
        case BFHeadSelectionViewButtonTypeAlbum:
            [self openAlbum];
            break;
        default:
            break;
    }
}

#pragma mark -- 退出按钮
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BF_ScaleHeight(60))];
        //footerView.backgroundColor = [UIColor redColor];
        UIButton *exitButton = [UIButton buttonWithFrame:CGRectMake(BF_ScaleWidth(90), BF_ScaleHeight(15), BF_ScaleWidth(140), BF_ScaleHeight(40)) title:@"退出登录" image:nil font:BF_ScaleFont(15) titleColor:BFColor(0xffffff)];
        exitButton.layer.cornerRadius = BF_ScaleHeight(20);
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
        [BFUserDefaluts removeUserInfo];
        [self.navigationController popToRootViewControllerAnimated:YES];
        UITabBarController *tabBar = [self.tabBarController viewControllers][1];
        tabBar.tabBarItem.badgeValue = nil;
    }];
}


#pragma mark -- 打开相机
- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark -- 打开相册
- (void)openAlbum
{

    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // info中就包含了选择的图片
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self changeHeadIcon:image];
    
    
    // 添加图片到头像中
    self.imageView.image = image;
}

#pragma mark -- 网络请求
- (void)changeHeadIcon:(UIImage *)image {
    BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NET_URL stringByAppendingPathComponent:@"/index.php?m=Json&a=header_ico"];
    // 2.拼接请求参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = userInfo.ID;
    parameter[@"token"] = userInfo.token;
    
    // 3.发送请求
    [mgr POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"header_ico" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        BFLog(@"%@", responseObject);
        if (responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"上传成功"]) {
                [BFProgressHUD MBProgressFromView:self.navigationController.view rightLabelText:@"头像更换成功"];
                BFUserInfo *userInfo = [BFUserDefaluts getUserInfo];
                userInfo.app_icon = responseObject[@"img"];
                BFLog(@"%@,,%@",userInfo.app_icon, responseObject[@"img"]);
                [BFUserDefaluts modifyUserInfo:userInfo];
            }else {
                [BFProgressHUD MBProgressFromView:self.navigationController.view wrongLabelText:@"头像更换失败"];
                
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BFLog(@"%@", error);

    }];
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
