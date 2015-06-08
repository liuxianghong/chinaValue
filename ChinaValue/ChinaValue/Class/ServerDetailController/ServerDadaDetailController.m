//
//  ServerDadaDetailController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/18.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//服务方资料s
#import "ServerDadaDetailController.h"
#import "UIBarButtonItem+ZX.h"
@interface ServerDadaDetailController(){
    NSArray *_textArray;
}

@end

@implementation ServerDadaDetailController

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
        _textArray=@[@"姓名",@"手机",@"邮箱",@"微信"];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    [cell.textLabel setTextColor:[UIColor grayColor]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    [cell.textLabel setText:_textArray[indexPath.row]];
   
    
    
    
    return cell;
}




@end
