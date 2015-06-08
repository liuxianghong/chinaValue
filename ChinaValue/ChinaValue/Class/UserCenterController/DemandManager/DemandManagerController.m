//
//  DemandManagerController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "DemandManagerController.h"
#import "MyCell.h"
#import "UIBarButtonItem+ZX.h"
#import "DemandViewController.h"
#import "ServerDemandViewController.h"
#import "CreditEvaluationViewControler.h"

@interface DemandManagerController (){
    NSArray *_textArray;
    NSArray *_imageArray;
    DemandViewController *_demandViewController;
    ServerDemandViewController *_serverDemandViewController;
    CreditEvaluationViewControler *_creditEvaluationViewCOntroler;
}

@end

@implementation DemandManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_textArray==nil) {
        _textArray=@[@"需求管理",@"发布需求",@"我的信用评价"];
    }
    if (_imageArray==nil) {
        _imageArray=@[@"service_manage_logo.png",@"demand_09.png",@"service_manage_start.png"];
    }
//    if (_demandViewController==nil) {
//        _demandViewController=[[DemandViewController alloc]init];
//    }
//    if (_serverDemandViewController==nil) {
//        _serverDemandViewController=[[ServerDemandViewController alloc]init];
//    }
//    if (_creditEvaluationViewCOntroler==nil) {
//        _creditEvaluationViewCOntroler=[[CreditEvaluationViewControler alloc]init];
//    }
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //去掉没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"需求方管理"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;

}


#pragma mark barButtonItem的监听事件
-(void)backAction{
    //通知userCenterConttroller让homeController把dock添加回来
    [self.delegate demandManagerNeedToAddDock];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _textArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    MyCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    [cell.imageView setImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
     cell.textLabel.text=_textArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self.navigationController pushViewController:[[DemandViewController alloc]init] animated:YES];
    }
    if (indexPath.row==1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"severVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==2) {
        CreditEvaluationViewControler *vc = [[CreditEvaluationViewControler alloc] init];
        vc.uid = [UserModel sharedManager].userID;
        vc.userName = @"我";
        [self.navigationController pushViewController:vc animated:YES];
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

@end
