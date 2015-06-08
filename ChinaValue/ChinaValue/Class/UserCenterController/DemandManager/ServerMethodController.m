//
//  ServerMethodController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/28.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//    服务方式页面选择

#import "ServerMethodController.h"
#import "UIBarButtonItem+ZX.h"
#import "ServerMethodCell.h"

@interface ServerMethodController (){
    NSArray *_textArray;
    NSMutableDictionary *_cellDic;//保存当前选中的行
    NSMutableArray *_array;
}

@end

@implementation ServerMethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_textArray==nil) {
        _textArray=@[@"线上服务",@"当面服务"];
    }
    //初始化cellDic
    if (_cellDic==nil) {
        _cellDic=[[NSMutableDictionary alloc]init];
    }
    if (_array==nil) {
        _array=[[NSMutableArray alloc]init];
    }
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"服务方式"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    //去掉底部没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    
}


#pragma mark barButtonItem的监听事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _textArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dicServiceType setValue:@(!indexPath.row) forKey:@"ServiceType"];
    [self.navigationController popViewControllerAnimated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    cell.tag=indexPath.row;
    cell.textLabel.text=_textArray[indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.0f]];
    cell.selectionStyle=UITableViewCellAccessoryNone;
    if ((!indexPath.row) == [[self.dicServiceType objectForKey:@"ServiceType"] integerValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
@end
