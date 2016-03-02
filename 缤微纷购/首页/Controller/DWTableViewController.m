//
//  DWTableViewController.m
//  缤微纷购
//
//  Created by 郑洋 on 16/1/21.
//  Copyright © 2016年 xinxincao. All rights reserved.
//
#import "Header.h"
#import "DWTableViewController.h"

@interface DWTableViewController ()

@end

@implementation DWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市列表";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        return kScreenWidth/2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 26;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *str = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.backgroundColor = rgb(245, 245, 245, 1.0);
    if (section == 0) {
        imageV.frame = CGRectMake(0, 0, kScreenWidth, 40);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 30)];
        label.text = @"当前位置";
        
        [self.view addSubview:imageV];
        [imageV addSubview:label];
        return imageV;
    }else if(section == 1){
        imageV.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/2);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 30)];
        label.text = @"热门城市";
        
        [self.view addSubview:imageV];
        [imageV addSubview:label];
        return imageV;
    }else{
        return imageV;
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

@end
