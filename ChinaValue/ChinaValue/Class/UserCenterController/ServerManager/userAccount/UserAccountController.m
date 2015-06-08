//
//  UserAccountController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "UserAccountController.h"
#import "UIBarButtonItem+ZX.h"
#import "MyCell.h"
#import "UserAcconutCell.h"
#import "CostDetailViewController.h"
#import "UserModel.h"
#import "ChinaValueInterface.h"
#import "NSData+ZXAES.h"
#import "TradeLogModel.h"
#import "UserModel.h"
#import "ExplainText.h"


#define TOKEN @"chinavaluetoken=abcdefgh01234567"

@interface UserAccountController (){
    NSArray *_textArray;
    NSArray *_imageArray;
    UILabel *_accountMoney;//用来显示账户余额
    CostDetailViewController *_costDetailViewController;
}

@end

@implementation UserAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_textArray==nil) {
        _textArray=@[@"账户余额",@"收支明细"];
    }
    if (_imageArray==nil) {
        _imageArray=@[@"person_account_logo.PNG",@"personal_manage_money.png"];
    }
    if (_costDetailViewController==nil) {
        _costDetailViewController=[[CostDetailViewController alloc]init];
    }
    
   
    
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //去掉没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"个人账户"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    [self loadData];

}

#pragma mark addLabelOfAccount
-(void)addLabelOfAccount:(NSString *)str{
    //显示账户余额的label
    if (_accountMoney==nil) {
        _accountMoney=[[UILabel alloc]init];
    }
    _accountMoney.frame=CGRectMake(0, 0, 100, 40);
    _accountMoney.text=str;
    _accountMoney.textColor=[UIColor grayColor];
    _accountMoney.textAlignment = NSTextAlignmentRight;
    _accountMoney.font=[UIFont systemFontOfSize:13.0];

}

#pragma mark barButtonItem的监听事件
-(void)backAction{
    //给userCenter发信息，让homeController把dock加载回来
    [self.delegate userAccountNeedToAddDock];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UserAcconutCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[UserAcconutCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    [cell.imageView setImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
    cell.textLabel.text=_textArray[indexPath.row];
    if (indexPath.row==0) {
       
       cell.accessoryView=_accountMoney;
        
    }
    if (indexPath.row==1) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
       
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        //加载数据
        //[self reloadTradeLog];
        //push出收支详情页面
        [self.navigationController pushViewController:[[CostDetailViewController alloc]init] animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    //必须得进入这个页面的时候再设置显示
    if ([UserModel sharedManager].balanceModel.balance==nil) {
        [self addLabelOfAccount:@"获取中"];
    }else{
        NSString *balance=[UserModel sharedManager].balanceModel.balance;
        NSString *balanceMutable=[NSString stringWithFormat:@"¥  %@",balance];
        [self addLabelOfAccount:balanceMutable];
    }
    [self.tableView reloadData];
}



-(void)loadData{
    //加载账户余额数据
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *userID=[UserModel sharedManager].userID;
    //加密
    NSString *enData=[NSData AES256Encrypt:userID key:TOKEN];
    [dic setValue:enData forKey:@"UID"];
    [ChinaValueInterface GetBalanceParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //解密
        NSDictionary *dic=[self explainDataWith:responseObject];
        
        [UserModel sharedManager].balanceModel=[[BalanceModel alloc]initBalanceWithDic:dic];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load user balance is failure");
    }];
}

#pragma mark -解密数据
-(NSDictionary *)explainDataWith:(id)responseObject{
    NSDictionary *dict=responseObject;
    NSArray  *dataArray=[dict objectForKey:@"ChinaValue"];
    
    NSLog(@"dict is %@",dataArray);
    NSDictionary *dataDic=dataArray[0];
    
    return dataDic;
}
@end
