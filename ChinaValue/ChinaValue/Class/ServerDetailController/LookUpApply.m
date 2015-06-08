//
//  LookUpApply.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//查看申请竞标的服务方页面
//


#import "LookUpApply.h"
#import "UIBarButtonItem+ZX.h"
#import "LookApplyCell.h"
#import "MyServerDataDetailController.h"

@interface LookUpApply(){
    
}
@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;
@end
@implementation LookUpApply
{
    NSArray *tableArray;
    
    NSString *price;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"查看申请竞标的服务方"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    //把多余的表格行隐藏掉
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //去掉表格的分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    [self loadData];
}

-(void)loadData
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:self.reid key:TOKEN] forKey:@"ReqID"];
    if (self.type) {
        [dic setObject:[NSData AES256Encrypt:@"1" key:TOKEN] forKey:@"Type"];
    }
    [ChinaValueInterface KnowKsbCompetitorParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        tableArray = responseObject[@"ChinaValue"];//dicData
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
    return [tableArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LookApplyCell" owner:self options:nil];
    LookApplyCell *celll = nil;
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        celll = cell = self.customCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
    }
    NSDictionary *dic = [tableArray objectAtIndex:indexPath.row];
    celll.name.text = dic[@"UserName"];
    celll.label1.text = [dic[@"Status"] integerValue]?@"已中标":@"已投标";
    celll.label2.text = [NSString stringWithFormat:@"%@元",dic[@"Price"]];
    celll.label3.text = [NSString stringWithFormat:@"%@小时",dic[@"Duration"]];
    celll.label4.text = dic[@"City"];
    celll.label5.text = dic[@"Reason"];
    [celll.btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [celll.btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    celll.btn1.tag = celll.btn2.tag = indexPath.row;
    return cell;
}

-(void)btn1Click:(UIButton *)btn
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:self.reid key:TOKEN] forKey:@"ReqID"];
    
    NSDictionary *dic2 = [tableArray objectAtIndex:btn.tag];
    [dic setObject:[NSData AES256Encrypt:dic2[@"ApcID"] key:TOKEN] forKey:@"ApcID"];
    [ChinaValueInterface KnowKsbSetKspInitParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData
        price = dic[@"Price"];
        UIAlertView *aview = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"需求标题：%@",dic[@"ReqTitle"]] message:[NSString stringWithFormat:@"服务费用：%@元",dic[@"Price"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"余额支付",@"微信支付", nil];
        aview.tag = btn.tag;
        [aview show];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
    }];
}

-(void)btn2Click:(UIButton *)btn
{
    NSDictionary *dic2 = [tableArray objectAtIndex:btn.tag];
    MyServerDataDetailController *vc = [[MyServerDataDetailController alloc]init];
    vc.uid = dic2[@"UID"];
    vc.userName = dic2[@"UserName"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
        [dic setObject:[NSData AES256Encrypt:self.reid key:TOKEN] forKey:@"ReqID"];
        
        NSDictionary *dic2 = [tableArray objectAtIndex:alertView.tag];
        [dic setObject:[NSData AES256Encrypt:dic2[@"ApcID"] key:TOKEN] forKey:@"ApcID"];
        [dic setObject:[NSData AES256Encrypt:price key:TOKEN] forKey:@"Price"];
        [ChinaValueInterface KnowKsbSetKspByBalanceParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData

            if ([dic[@"Result"] isEqualToString:@"True"]) {
                [hud hide:YES];
            }
            else
            {
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabelText = dic[@"Msg"];
                [hud hide:YES afterDelay:1.5];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = error.domain;
            [hud hide:YES];
        }];
    }
    else if(buttonIndex==2)
    {
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.customCell.frame.size.height;
}

@end
