//
//  MyCompetitiveBiddDetailController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//我的竞标详情页面
//

#import "MyCompetitiveBiddDetailController.h"
#import "UIBarButtonItem+ZX.h"

@interface MyCompetitiveBiddDetailController(){
    NSArray *_textArray;
    NSArray *_accessoryTextArray;
}

@end

@implementation MyCompetitiveBiddDetailController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"我的竞标详情"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    //初始化Array
    if (_textArray==nil) {
        _textArray=@[@"Ray",@"公司:",@"职位:",@"邮箱地址:",@"手机:",@"座机:",@"QQ:",@"微信:",@"跟人账户中的账户余额后面的提现功能去掉，支出铭记就发生纠纷拉萨发生飞机上啦的风景撒离开飞机上啦的弗萨里的法律撒的方式发了快的方式"];
    }
    if (_accessoryTextArray==nil) {
        _accessoryTextArray=@[@"香港黑马营销有限公司",@"项目经理",@"123456789qq.com",@"12345678901",@"23456789",@"123456789",@"23456789@qq.com"];
    }
    
    
    
    
    //把多余的表格行隐藏掉
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
}

#pragma mark leftBarButton的监听
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    if (indexPath.row==0) {
        [cell.imageView setImage:[UIImage imageNamed:@"first_04.png"]];
       
    }
    
    [cell.textLabel setTextColor:[UIColor grayColor]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
     [cell.textLabel setText:_textArray[indexPath.row]];
   
    
    
    if (indexPath.row!=0 ) {
        if (indexPath.row!=8) {
            //添加uilabel作为accessoryView
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
            [lable setText:_accessoryTextArray[indexPath.row-1]];
            [lable setTextAlignment:NSTextAlignmentRight];
            [lable setTextColor:[UIColor grayColor]];
            cell.accessoryView=lable;
            
           
            
        }
       
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 80;
    }
    if (indexPath.row==8) {
        return 120;
        
       
    }
    
    return 44;
    
}




@end
