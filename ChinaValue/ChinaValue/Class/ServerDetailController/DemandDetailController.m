//
//  DemandDetailController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//需求详情页面

#import "DemandDetailController.h"
#import "UIBarButtonItem+ZX.h"
#import "DemandDetailHeader.h"
#import "UIImageView+WebCache.h"
#import "ChinaValueInterface.h"
#import "UserModel.h"
#import "ExplainText.h"
#import "BiddingApplyController.h"
#import "BiddingApplyTableViewController.h"
#import "CreditEvaluationViewControler.h"

@interface DemandDetailController(){
    NSArray *_textArray;
    NSString *Industry;
    NSString *Function;
}
@property(nonatomic,strong)GetReqDetailModel *getReqDetailModel;
@end

@implementation DemandDetailController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"需求详情"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    _textArray=@[@"需求编号",@"开始时间",@"截至时间",@"服务方式",@"所属分类",@"行业类别",@"薪酬范围",@"服务地点",@"内容"];
    
    
    //把多余的表格行隐藏掉
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //去掉表格的分割线
  //  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
    
    NSString *reqID=self.reqID;
    
    NSString *enReqID=[NSData AES256Encrypt:reqID key:TOKEN];
    
    NSString *uid=[UserModel sharedManager].userID;
    
    NSString *enUID=[NSData AES256Encrypt:uid key:TOKEN];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    NSLog(@"ReqID is :%@",reqID);
    NSLog(@"Uid is :%@",uid);
    
    [dic setObject:enReqID forKey:@"ReqID"];
    
    [dic setObject:enUID forKey:@"UID"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    //加载网络数据
    [ChinaValueInterface GetReqDetailParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"-------------------------------getReqDetail is :%@",responseObject);
        NSDictionary *dic=[ExplainText explainDataWith:responseObject];
        
        GetReqDetailModel *reqDetail=[[GetReqDetailModel alloc]initWitDic:dic];
        
        //把加载好的数据传给UserDataDetail
        self.getReqDetailModel=reqDetail;
        
        
        NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
        [dic2 setObject:[NSData AES256Encrypt:self.getReqDetailModel.Industry key:TOKEN] forKey:@"ID"];
        [ChinaValueInterface GetIndustryParameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            Industry = @"";
            NSArray *array = responseObject[@"ChinaValue"];
            for (NSDictionary *dic in array) {
                Industry = [Industry stringByAppendingString:dic[@"Name"]];
                Industry = [Industry stringByAppendingString:@" "];
            }
            
            NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
            [dic3 setObject:[NSData AES256Encrypt:self.getReqDetailModel.Function key:TOKEN] forKey:@"ID"];
            [ChinaValueInterface KnowGetFunctionParameters:dic3 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                Function = @"";
                NSArray *array = responseObject[@"ChinaValue"];
                for (NSDictionary *dic in array) {
                    Function = [Function stringByAppendingString:dic[@"Name"]];
                    Function = [Function stringByAppendingString:@" "];
                }
                [hud hide:YES];
                [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                ;
                [hud hide:YES];
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
            [hud hide:YES];
        }];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load data failure");
        [hud hide:YES];
    }];
}

#pragma mark leftBarButton的监听
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnClick:(UIButton *)btn
{
    if(btn.tag==1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        BiddingApplyTableViewController* vc = (BiddingApplyTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BiddingApply"];
        vc.rID = self.getReqDetailModel.ReqID;
        //来到资料修改页面
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==2)
    {
        [self getGUANXI];
    }
    else if (btn.tag==3)
    {
        CreditEvaluationViewControler *vc = [[CreditEvaluationViewControler alloc]init];
        vc.uid = self.getReqDetailModel.PublisherID;
        vc.userName = self.getReqDetailModel.PublisherName;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)getGUANXI
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    NSString *reqID=self.PublisherID;
    
    NSString *enReqID=[NSData AES256Encrypt:reqID key:TOKEN];
    
    NSString *uid=[UserModel sharedManager].userID;
    
    NSString *enUID=[NSData AES256Encrypt:uid key:TOKEN];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:enReqID forKey:@"ToUID"];
    [dic setObject:enUID forKey:@"FromUID"];
    [ChinaValueInterface UserGetConnectionParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = dic[@"Name"];
        [HUD hide:YES afterDelay:1.5f];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = error.domain;
        [HUD hide:YES afterDelay:1.5f];
    }];
}
#pragma mark -tableview数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    if (indexPath.row>0) {
        cell.textLabel.text=_textArray[indexPath.row-1];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, cell.frame.size.height)];
        label.textColor=[UIColor grayColor];
        [label setTextAlignment:NSTextAlignmentRight];
        [label setNumberOfLines:0];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setFont:[UIFont systemFontOfSize:15.0]];
        GetReqDetailModel *model = self.getReqDetailModel;
        if (indexPath.row==1) {
            label.text=self.getReqDetailModel.ReqID;
        }else if(indexPath.row==2){
            label.text=self.getReqDetailModel.AddTime;
        }else if(indexPath.row==3){
            label.text=self.getReqDetailModel.EndTime;
        }else if(indexPath.row==4)
        {
            label.text=self.getReqDetailModel.ServiceType;
        }
        else if(indexPath.row==5)
        {
            label.text=Industry;//self.getReqDetailModel.ButtonText;
        }else if (indexPath.row==6){
            label.text=Function;//self.getReqDetailModel.IndustryName;
        }else if(indexPath.row==7){
        
            label.text=[NSString stringWithFormat:@"%@ 元",self.getReqDetailModel.Price];
        }else if (indexPath.row==8){
            NSString *address=[NSString stringWithFormat:@"%@%@",self.getReqDetailModel.ReqCountry,self.getReqDetailModel.ReqCity];
            label.text=address;
        }else{
            label.text=self.getReqDetailModel.Desc;
        }
        
        cell.accessoryView=label;
    }else{
        cell.textLabel.text=self.getReqDetailModel.Title;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        DemandDetailHeader *firstSection=[[DemandDetailHeader alloc]init];
        //        [firstSection.contentView setBackgroundColor:[UIColor whiteColor]];
        firstSection.name.text=self.getReqDetailModel.PublisherName;
      
        [firstSection.headerView setImageWithURL:[NSURL URLWithString:self.getReqDetailModel.PublisherAvatar] placeholderImage:[UIImage imageNamed:@"service_unselect.png"]];
        
        firstSection.headerView.layer.cornerRadius = firstSection.headerView.height/2;
        firstSection.headerView.layer.borderWidth = 0;
        firstSection.headerView.layer.borderColor = [[UIColor grayColor] CGColor];
        firstSection.headerView.layer.masksToBounds = YES;
        firstSection.btn1.tag = 1;
        [firstSection.btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        firstSection.btn2.tag = 2;
        [firstSection.btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        firstSection.btn3.tag = 3;
        [firstSection.btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        return firstSection;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    [view setBackgroundColor:[UIColor colorWithRed:247.0/255.f green:247.0/255.f blue:247.0/255.f alpha:1]];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 125;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==9) {
        return 88;
    }
    return 44;
}


@end
