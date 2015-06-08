//
//  CheckServerPageController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/10.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//查看服务订单页面

#import "CheckServerPageController.h"
#import "UIBarButtonItem+ZX.h"
#import "MyCell.h"
@interface CheckServerPageController(){
    NSArray *_textArray;
    NSArray *_imageArray;
    NSArray *_accessoryText;
}
@end
@implementation CheckServerPageController
{
    NSDictionary *dicData;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"查看服务订单"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    //初始化Array
    if (_textArray==nil) {
        _textArray=@[@"服务时间",@"服务时长",@"服务费用"];
    }
    if (_imageArray==nil) {
        _imageArray=@[@"writeServerDetail__03.PNG",@"writeServerDetail__02.PNG",@"writeServerDetail_01.PNG"];
    }
//    if (_accessoryText==nil) {
//        _accessoryText=@[@"2014-05-23  14:23",@"0.5小时",@"5元"];
//    }
    
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
    
    [self loaddata];
}

-(void)loaddata
{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.uID?self.uID:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:self.ReqID key:TOKEN] forKey:@"ReqID"];
    [ChinaValueInterface KnowKsbOrderViewParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dicData = [responseObject[@"ChinaValue"] firstObject];
        //_accessoryText = @[dic[@"DateTime"],dic[@"Duration"],dic[@"Price"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
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
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setFont:[UIFont systemFontOfSize:13.0f]];
    if (dicData) {
        if (indexPath.row==0) {
            label.text=dicData[@"DateTime"];
        }
        if (indexPath.row==1) {
            label.text=label.text=[NSString stringWithFormat:@"%@ 小时",dicData[@"Duration"]];//dicData[@"Duration"];
            //label.text=[NSString stringWithFormat:@"%@ 小时",self.kspApplyViewMpdel.Duration];
        }
        if (indexPath.row==2) {
            label.text=[NSString stringWithFormat:@"%@ 元",dicData[@"Price"]];//dicData[@"Price"];
            //label.text=[NSString stringWithFormat:@"%@ 元",self.kspApplyViewMpdel.Price];
        }
        cell.accessoryView=label;
    }
    
    
    return cell;
}


@end
