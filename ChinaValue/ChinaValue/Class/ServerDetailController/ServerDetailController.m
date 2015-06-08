//
//  ServerDetailController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

//   服务详情页面（需求管理里面进去的）

#import "ServerDetailController.h"
#import "UIBarButtonItem+ZX.h"
#import "ServerDetailHeader.h"
#import "DemandDetailController.h"
#import "ServerDemandViewController.h"
#import "HunterServerController.h"
#import "LookUpApply.h"
#import "MyCompetitiveBiddDetailController.h"
#import "WriteServerPageController.h"
#import "EvaluateController.h"
#import "CheckServerPageController.h"
#import "UIImageView+WebCache.h"
#import "ServerDetailCell.h"
#import "PublishServerTableViewController.h"
#import "MyServerDataDetailController.h"
#import "ServerOrderTableViewController.h"
#import "FileSeeViewController.h"

#import <UIKit/UIDocumentInteractionController.h>

@interface ServerDetailController()<UIDocumentInteractionControllerDelegate>
{
    DemandDetailController *_demandDetailController;
    ServerDemandViewController *_serverDemandViewController;
    HunterServerController *_hunterServerController;
    LookUpApply *_lookUpApply;
    MyCompetitiveBiddDetailController *_myCompetitiveBiddDetailController;
    WriteServerPageController *_writeServerPageController;
    EvaluateController *_evaluateController;
    CheckServerPageController *_checkSercerPageController;
    
}
@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;
@property(nonatomic,strong)IBOutlet UITableViewCell *noButtonCell;
@property (nonatomic,strong) UIDocumentInteractionController *fileSeeVc;
@end

@implementation ServerDetailController
{
    NSMutableDictionary *dicData;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    _fileSeeVc = [[UIDocumentInteractionController alloc]init];
//    _fileSeeVc.delegate = self;
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"服务详情"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    //把多余的表格行隐藏掉
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //去掉表格的分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    //初始化DemandDetailController
    if (_demandDetailController==nil) {
        _demandDetailController=[[DemandDetailController alloc]init];
    }
    //初始化ServerDemandViewController
    if (_serverDemandViewController==nil) {
        _serverDemandViewController=[[ServerDemandViewController alloc]init];
    }
    //初始化HunterServerController
    if (_hunterServerController==nil) {
        _hunterServerController=[[HunterServerController alloc]init];
    }
    //初始化LookUpApply
    if (_lookUpApply==nil) {
        _lookUpApply=[[LookUpApply alloc]init];
    }
    //初始化MyCompetitiveBiddDetailController
    if (_myCompetitiveBiddDetailController==nil) {
        _myCompetitiveBiddDetailController=[[MyCompetitiveBiddDetailController alloc]init];
    }
    //初始化WriteServerPageController
    if (_writeServerPageController==nil) {
        _writeServerPageController=[[WriteServerPageController alloc]init];
    }
    //初始化EvaluateController
    if (_evaluateController==nil) {
        _evaluateController=[[EvaluateController alloc]init];
    }
    //初始化CheckServerPageController
    if (_checkSercerPageController==nil) {
        _checkSercerPageController=[[CheckServerPageController alloc]init];
    }
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    dicData = [[NSMutableDictionary alloc]init];
    [self loadData];
}

-(void)loadData
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:self.dic[@"ReqID"] key:TOKEN] forKey:@"ReqID"];
    [ChinaValueInterface KnowKsbReqDetailParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"ChinaValue"];//dicData
        NSLog(@"%@",array);
        for (NSDictionary *dic in array) {
            [dicData setObject:dic forKey:dic[@"Step"]];
        }
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
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    
    NSDictionary *dic = [dicData objectForKey:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ServerDetailCell" owner:self options:nil];//ServerDetailNoButtonCell
    NSArray *nib1=[[NSBundle mainBundle] loadNibNamed:@"ServerDetailNoButtonCell" owner:self options:nil];
    ServerDetailCell *cellD = nil;
    if ([nib count]>0)
    {
        if (indexPath.row!=4) {
            self.customCell = [nib objectAtIndex:0];
            cellD = self.customCell;
            cell = self.customCell;
            cell.selectionStyle=UITableViewCellEditingStyleNone;
        }
        
    }
    if ([nib1 count]>0) {
        if (indexPath.row==4) {
            self.noButtonCell=[nib1 objectAtIndex:0];
             cell = self.noButtonCell;
            cellD = self.noButtonCell;
             cell.selectionStyle=UITableViewCellEditingStyleNone;
            
            //        UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
            //        [title setText:@"服务中"];
            //
            //        UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
            //        [detailText setText:@"如果服务过程已结束，请耐心等待服务方提交咨询报告."];
//            
//            UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
//            [title setText:@"服务中"];
//            
//            UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:8];
//            [detailText setText:@"如果服务过程已结束，请耐心等待服务方提交咨询报告."];
        }
    }
    
    cellD.detailText.text = dic[@"Desc"];
    cellD.title.text = dic[@"Name"];
    if ([dic[@"Status"] integerValue]==-1) {
        cellD.point.backgroundColor = [UIColor colorWithRed:66/255.0 green:91/255.0 blue:78/255.0 alpha:1];
        cellD.line.backgroundColor = [UIColor colorWithRed:66/255.0 green:91/255.0 blue:78/255.0 alpha:1];
    }else if ([dic[@"Status"] integerValue]==0) {
        cellD.point.backgroundColor = [UIColor colorWithRed:232/255.0 green:85/255.0 blue:37/255.0 alpha:1];
        cellD.line.backgroundColor = [UIColor colorWithRed:232/255.0 green:85/255.0 blue:37/255.0 alpha:1];
    }
    //66 91 78
    //232 85 37
    //获取数据源中_person数组中的元素，对应每一个cell
    //通过tag值来获取控件
    if ([dic[@"Status"] integerValue]!=1) {
        if (indexPath.row==0) {
            //        UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
            //        [title setText:@"需求等待审核"];
            //
            //        UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
            //        [detailText setText:@"审核通过后才能进入竞标阶段，您现在可以预览需求，或者修改需求"];
            
            //add Button
            UIButton *checkButton=[UIButton buttonWithType:UIButtonTypeSystem];//预览需求
            checkButton.frame=CGRectMake(cell.frame.size.width/2-10, cell.frame.size.height-30, 80, 25);
            [checkButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [checkButton setTitle:@"预览需求" forState:UIControlStateNormal];
            checkButton.tag=0;
            [checkButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [checkButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [checkButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:checkButton];
            
            //change Button
            UIButton *changeButton=[UIButton buttonWithType:UIButtonTypeSystem];
            changeButton.frame=CGRectMake(cell.frame.size.width/2+75, cell.frame.size.height-30, 80, 25);
            [changeButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [changeButton setTitle:@"修改需求" forState:UIControlStateNormal];
            changeButton.tag=1;
            [changeButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [changeButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [changeButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:changeButton];
            
            
            
            
            
            
            
        }else if(indexPath.row==1){
            
            //        UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
            //        [title setText:@"竞标中"];
            //
            //        UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
            //        [detailText setText:@"您可以查找服务方并发出邀请，或者查看申请竞标的服务方，从中选择服务方并支付服务费."];
            
            
            //change Button
            UIButton *searchServerButton=[UIButton buttonWithType:UIButtonTypeSystem];
            searchServerButton.frame=CGRectMake(cell.frame.size.width/7+13, cell.frame.size.height-30, 130, 25);
            [searchServerButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [searchServerButton setTitle:@"查找服务方并邀请" forState:UIControlStateNormal];
            [searchServerButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            searchServerButton.tag=2;
            [searchServerButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [searchServerButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:searchServerButton];
            
            //checkJB 查看竞标的服务方
            UIButton *checkJBButton=[UIButton buttonWithType:UIButtonTypeSystem];
            checkJBButton.frame=CGRectMake(cell.frame.size.width/7+148, cell.frame.size.height-30, 120, 25);
            [checkJBButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [checkJBButton setTitle:@"查看竞标的服务方" forState:UIControlStateNormal];
            checkJBButton.tag=3;
            [checkJBButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [checkJBButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [checkJBButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:checkJBButton];
            
            
        }else if (indexPath.row==2){
            
            //        UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
            //        [title setText:@"等待生成服务订单"];
            //
            //        UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
            //        [detailText setText:@"已选择服务方，现在您可以和服务方沟通服务时间及时长。沟通后请填写服务订单."];
            
            
            //select Button已选择服务方
            UIButton *selectServerButton=[UIButton buttonWithType:UIButtonTypeSystem];
            selectServerButton.frame=CGRectMake(cell.frame.size.width/7+13, cell.frame.size.height-30, 80, 25);
            [selectServerButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [selectServerButton setTitle:@"已选择服务方" forState:UIControlStateNormal];
            selectServerButton.tag=4;
            [selectServerButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [selectServerButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [selectServerButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:selectServerButton];
            
            
            //connection Button和服务方沟通
            UIButton *connectionButton=[UIButton buttonWithType:UIButtonTypeSystem];
            connectionButton.frame=CGRectMake(cell.frame.size.width/7+102, cell.frame.size.height-30, 80, 25);
            [connectionButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [connectionButton setTitle:@"和服务方沟通" forState:UIControlStateNormal];
            connectionButton.tag=5;
            [connectionButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [connectionButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [connectionButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:connectionButton];
            
            
            //write Button填写服务订单
            UIButton *writeButton=[UIButton buttonWithType:UIButtonTypeSystem];
            writeButton.frame=CGRectMake(cell.frame.size.width/7+187, cell.frame.size.height-30, 80, 25);
            [writeButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [writeButton setTitle:@"填写服务订单" forState:UIControlStateNormal];
            writeButton.tag=6;
            [writeButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [writeButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [writeButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:writeButton];
            
            
        }else if (indexPath.row==3){
            //        UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
            //        [title setText:@"等待服务开始"];
            //
            //        UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
            //        [detailText setText:@"服务订单已生成，您可以查看服务订单，并在约定的时间开始服务."];
            
            
            //checkServer Button查看服务单
            UIButton *checkServerButton=[UIButton buttonWithType:UIButtonTypeSystem];
            checkServerButton.frame=CGRectMake(cell.frame.size.width/2+55, cell.frame.size.height-30, 100, 25);
            [checkServerButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [checkServerButton setTitle:@"查看服务单" forState:UIControlStateNormal];
            checkServerButton.tag=7;
            [checkServerButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [checkServerButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [checkServerButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:checkServerButton];
            
        }else if(indexPath.row==4){
            
            
        }else if (indexPath.row==5){
            //        UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
            //        [title setText:@"确认服务结束"];
            //
            //        UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
            //        [detailText setText:@"服务方已提交报告，您可以查看咨询报告，无误后点击确认服务结束."];
            
            
            //checkAskButton查看咨询报告
            UIButton *checkAskButton=[UIButton buttonWithType:UIButtonTypeSystem];//预览需求
            checkAskButton.frame=CGRectMake(cell.frame.size.width/2-10, cell.frame.size.height-30, 80, 25);
            [checkAskButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [checkAskButton setTitle:@"查看咨询报告" forState:UIControlStateNormal];
            checkAskButton.tag=8;
            [checkAskButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [checkAskButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [checkAskButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:checkAskButton];
            
            //confirmOverButton确认服务结束
            UIButton *confirmOverButton=[UIButton buttonWithType:UIButtonTypeSystem];
            confirmOverButton.frame=CGRectMake(cell.frame.size.width/2+75, cell.frame.size.height-30, 80, 25);
            [confirmOverButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [confirmOverButton setTitle:@"确认服务结束" forState:UIControlStateNormal];
            confirmOverButton.tag=9;
            [confirmOverButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [confirmOverButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [confirmOverButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:confirmOverButton];
            
            
        }else{
            //        UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
            //        [title setText:@"服务完成"];
            //        
            //        UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
            //        [detailText setText:@"服务已完成，您可以给服务方提供的服务做出您的评价。"];
            
            
            //evaluateButton评价
            UIButton *evaluateButton=[UIButton buttonWithType:UIButtonTypeSystem];
            evaluateButton.frame=CGRectMake(cell.frame.size.width/2+75, cell.frame.size.height-30, 80, 25);
            [evaluateButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [evaluateButton setTitle:@"评价" forState:UIControlStateNormal];
            evaluateButton.tag=10;
            [evaluateButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [evaluateButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [evaluateButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:evaluateButton];
            
            
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        return self.noButtonCell.frame.size.height;
    }
     return  self.customCell.frame.size.height;
    
   
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     ServerDetailHeader *header=[[ServerDetailHeader alloc]init];
   
      header.frame=CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 70);
    //头像
    //[header.imageView setImage:[UIImage imageNamed:@"credit_05.png"]];
    [header.imageView sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"Avatar"]]  placeholderImage:[UIImage imageNamed:@"credit_05.png"]];
    
    header.imageView.layer.cornerRadius = header.imageView.height/2;
    header.imageView.layer.borderWidth = 0;
    header.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    header.imageView.layer.masksToBounds = YES;
    //标题
   
    [header.title setText:self.dic[@"Title"]];
    
    //日期
    
    [header.date setText:self.dic[@"AddTime"]];
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  70;
}

#pragma mark -服务详情里所有按钮的监听
-(void)clickWithButton:(UIButton *)button{
    NSLog(@"%ld button is clicked",button.tag);
    if (button.tag==0) {
        DemandDetailController *vc = [[DemandDetailController alloc]init];
        vc.reqID = self.dic[@"ReqID"];
        vc.PublisherID = [UserModel sharedManager].userID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag==1) {
        [self loadRe];
    }
    if (button.tag==2) {
        HunterServerController *vc = [[HunterServerController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag==3) {
        if (![self.dic[@"Competitors"] integerValue]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = @"无人竞标";
            [hud hide:YES afterDelay:1.5f];
        }
        else
        {
            LookUpApply *vc = [[LookUpApply alloc]init];
            vc.reid = self.dic[@"ReqID"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    if (button.tag==4) {
        LookUpApply *vc = [[LookUpApply alloc]init];
        vc.reid = self.dic[@"ReqID"];
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag==5) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
        [dic setObject:[NSData AES256Encrypt:self.dic[@"ReqID"] key:TOKEN] forKey:@"ReqID"];
        [dic setObject:[NSData AES256Encrypt:@"1" key:TOKEN] forKey:@"Type"];
        [ChinaValueInterface KnowKsbCompetitorParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData
            MyServerDataDetailController *vc = [[MyServerDataDetailController alloc]init];
            vc.uid = dic[@"UID"];
            vc.userName = dic[@"UserName"];
            vc.type = 2;
            [hud hide:YES];
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = error.domain;
            [hud hide:YES afterDelay:1.5f];
        }];
        
        
        //[self.navigationController pushViewController:_myCompetitiveBiddDetailController animated:YES];
    }
    if (button.tag==6) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ServerOrderTableViewController* vc = (ServerOrderTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ServerOrder"];
        vc.reid = self.dic[@"ReqID"];
        [self.navigationController pushViewController:vc animated:YES];
        //[self.navigationController pushViewController:_writeServerPageController animated:YES];
    }
    if(button.tag==7){
        CheckServerPageController *vc = [[CheckServerPageController alloc]init];
        vc.ReqID = self.dic[@"ReqID"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(button.tag==8){
        UIAlertView *aview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否下载咨询报告？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aview.tag = 112;
        [aview show];
    }
    if(button.tag==9){
        UIAlertView *aview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确认服务结束？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aview.tag = 111;
        [aview show];
    }
    
    if (button.tag==10) {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        HUD.mode = MBProgressHUDModeText;
        HUD.detailsLabelText = @"正在完善";
        [HUD hide:YES afterDelay:1.5f];
        //[self.navigationController pushViewController:_evaluateController animated:YES];
        //完成到评价页面
    }
}

-(void)loadRe
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.dic[@"ReqID"] key:TOKEN] forKey:@"ReqID"];
    [ChinaValueInterface KnowKsbReqGetParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
        if (![dic[@"IsAllowModify"] isEqualToString:@"True"]) {
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = dic[@"ModifyMsg"];
            [hud hide:YES afterDelay:1.5f];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PublishServerTableViewController* vc = (PublishServerTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"severVC"];
            vc.reID = self.dic[@"ReqID"];
            vc.dic = dic;
            [hud hide:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = error.domain;
        [hud hide:YES afterDelay:1.5f];
    }];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==111) {
        if (buttonIndex == 1) {
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
            [dic setObject:[NSData AES256Encrypt:self.dic[@"ReqID"] key:TOKEN] forKey:@"ReqID"];
            [ChinaValueInterface KnowKsbConfirmServiceEndParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
                HUD.mode = MBProgressHUDModeText;
                HUD.detailsLabelText = dic[@"Msg"];
                [HUD hide:YES afterDelay:1.5f];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                HUD.mode = MBProgressHUDModeText;
                HUD.detailsLabelText = error.domain;
                [HUD hide:YES afterDelay:1.5f];
            }];
        }
    }
    
    if (alertView.tag==112) {
        if (buttonIndex == 1) {
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
            [dic setObject:[NSData AES256Encrypt:self.dic[@"ReqID"] key:TOKEN] forKey:@"ReqID"];
            [ChinaValueInterface KnowKsbReportViewParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
                if ([dic[@"Result"] isEqualToString:@"True"]) {
                    NSString *urlString = dic[@"URL"];

                    NSString *fileName = [NSString stringWithFormat:@"%@_%@.doc",[UserModel sharedManager].userID,self.dic[@"ReqID"]];
                    NSString *fileUrl = [self DownloadTextFile:urlString fileName:fileName];

                    
                    self.fileSeeVc = [UIDocumentInteractionController
                                                          interactionControllerWithURL:[NSURL fileURLWithPath:fileUrl]];
                    [_fileSeeVc setDelegate:self];
                    [_fileSeeVc presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
//
                    [HUD hide:YES];

//                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    FileSeeViewController* vc = (FileSeeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FileSee"];
//                    vc.url = fileUrl;
//                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    HUD.mode = MBProgressHUDModeText;
                    HUD.detailsLabelText = dic[@"Result"];
                    [HUD hide:YES afterDelay:1.5f];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                HUD.mode = MBProgressHUDModeText;
                HUD.detailsLabelText = error.domain;
                [HUD hide:YES afterDelay:1.5f];
            }];
        }
    }
}


-(NSString*)DownloadTextFile:(NSString*)fileUrl   fileName:(NSString*)_fileName
{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES);//使用C函数NSSearchPathForDirectoriesInDomains来获得沙盒中目录的全路径。
    NSString *ourDocumentPath =[documentPaths objectAtIndex:0];
    NSString *sandboxPath = NSHomeDirectory();
    NSString *documentPath = [sandboxPath  stringByAppendingPathComponent:@"Documents"];//将Documents添加到sandbox路径上//TestDownImgZip.app
    NSString *FileName=[documentPath stringByAppendingPathComponent:_fileName];//fileName就是保存文件的文件名
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Copy the database sql file from the resourcepath to the documentpath
    if ([fileManager fileExistsAtPath:FileName])
    {
        return FileName;
    }
    else
    {
        NSURL *url = [NSURL URLWithString:fileUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:FileName atomically:YES];//将NSData类型对象data写入文件，文件名为FileName
    }
    return FileName;
}
@end
