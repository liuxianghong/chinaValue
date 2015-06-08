//
//  DeliverReportViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//   提交咨询报告页面

#import "DeliverReportViewController.h"
#import "UIBarButtonItem+ZX.h"

@interface DeliverReportViewController ()

@end

@implementation DeliverReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@" 提交咨询报告"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;

    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    //createView
    [self createView];
    
}
-(void)createView{
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.view.frame.size.width-30, 44)];
    title.text=@"服务已完成，咨询报告只可以查看，不可以进行修改";
    [title setFont:[UIFont systemFontOfSize:13.0f]];
    [title setTextColor:[UIColor grayColor]];
    [self.view addSubview:title];
    
    UIButton *addReportButton=[UIButton buttonWithType:UIButtonTypeSystem];
    addReportButton.frame=CGRectMake(15, 54, self.view.frame.size.width-30, 40);
    [addReportButton setTitle:@"添加报告" forState:UIControlStateNormal];
    [addReportButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addReportButton setBackgroundImage:[UIImage imageNamed:@"resign_02.png"] forState:UIControlStateNormal];
    [addReportButton addTarget:self action:@selector(clickButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addReportButton];
    
}

#pragma mark leftBarButton的监听
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 添加报告按钮的监听
-(void)clickButtonAction{
    NSLog(@"添加咨询报告");
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
