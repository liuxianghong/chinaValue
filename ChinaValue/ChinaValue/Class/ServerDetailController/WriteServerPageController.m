//
//  WriteServerPageController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//填写服务详单页面
//
#import "WriteServerPageController.h"
#import "UIBarButtonItem+ZX.h"
#import "MyCell.h"
@interface WriteServerPageController(){
    NSArray *_textArray;
    NSArray *_imageArray;
}
@end
@implementation WriteServerPageController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"填写服务详单"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    //初始化Array
    if (_textArray==nil) {
        _textArray=@[@"服务时间",@"服务时长",@"服务费用"];
    }
    if (_imageArray==nil) {
        _imageArray=@[@"writeServerDetail__03.PNG",@"writeServerDetail__02.PNG",@"writeServerDetail_01.PNG"];
    }
    
    //把多余的表格行隐藏掉
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(-10, 0, 0, 0);
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    MyCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    [cell.imageView setImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
    [cell.textLabel setText:_textArray[indexPath.row]];
    
    return cell;
}


@end
