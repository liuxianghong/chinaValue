//
//  OtherServerDetailController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//服务详情（从服务方管理里面进去的）

#import "OtherServerDetailController.h"
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
#import "BiddingApplyController.h"
#import "DeliverReportViewController.h"
#import "UIImageView+WebCache.h"



#import "ExplainText.h"
#import "ChinaValueInterface.h"
#import "GetKspListModel.h"
#import "UIImageView+WebCache.h"
#import "NSData+ZXAES.h"
#import "KspReqListModel.h"
#import "UserModel.h"
#import "MyServerDataDetailController.h"

#import "KspApplyViewModel.h"
#import "KspApplyCancelModel.h"
#import "MBProgressHUD.h"
#import "ServerDadaDetailController.h"
#import "KspReportViewModel.h"
#define TOKEN @"chinavaluetoken=abcdefgh01234567"


#import "GetINdustryModel.h"
#import "ServerDetailCell.h"




@interface OtherServerDetailController ()<MBProgressHUDDelegate,UIAlertViewDelegate,EvaluateControllerDelegate>{
    DemandDetailController *_demandDetailController;
    ServerDemandViewController *_serverDemandViewController;
    HunterServerController *_hunterServerController;
    LookUpApply *_lookUpApply;
    MyCompetitiveBiddDetailController *_myCompetitiveBiddDetailController;
    WriteServerPageController *_writeServerPageController;
    EvaluateController *_evaluateController;
    CheckServerPageController *_checkSercerPageController;
    BiddingApplyController *_biddingApplyController;
    DeliverReportViewController *_deleverReportViewController;
    MBProgressHUD *HUD;
    MBProgressHUD *DialogHUD;
    ServerDadaDetailController *_serverDadaDetailController;
    
    NSMutableDictionary *dicData;
    
}
@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;
@property (nonatomic,strong) UIDocumentInteractionController *fileSeeVc;
@end

@implementation OtherServerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
//    if (_demandDetailController==nil) {
//        _demandDetailController=[[DemandDetailController alloc]init];
//    }
//    //初始化ServerDemandViewController
//    if (_serverDemandViewController==nil) {
//        _serverDemandViewController=[[ServerDemandViewController alloc]init];
//    }
//    //初始化HunterServerController
//    if (_hunterServerController==nil) {
//        _hunterServerController=[[HunterServerController alloc]init];
//    }
//    //初始化LookUpApply
//    if (_lookUpApply==nil) {
//        _lookUpApply=[[LookUpApply alloc]init];
//    }
//    //初始化MyCompetitiveBiddDetailController
//    if (_myCompetitiveBiddDetailController==nil) {
//        _myCompetitiveBiddDetailController=[[MyCompetitiveBiddDetailController alloc]init];
//    }
//    //初始化WriteServerPageController
//    if (_writeServerPageController==nil) {
//        _writeServerPageController=[[WriteServerPageController alloc]init];
//    }
//    //初始化EvaluateController
//    if (_evaluateController==nil) {
//        _evaluateController=[[EvaluateController alloc]init];
//        _evaluateController.delegate=self;
//    }
//    //初始化CheckServerPageController
//    if (_checkSercerPageController==nil) {
//        _checkSercerPageController=[[CheckServerPageController alloc]init];
//    }
//    if (_biddingApplyController==nil) {
//        _biddingApplyController=[[BiddingApplyController alloc]init];
//    }
//    //初始化提交咨询报告
//    if (_deleverReportViewController==nil) {
//        _deleverReportViewController=[[DeliverReportViewController alloc]init];
//    }
//    if (_serverDadaDetailController==nil) {
//        _serverDadaDetailController=[[ServerDadaDetailController alloc]init];
//    }
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    dicData = [[NSMutableDictionary alloc]init];
    [self loadNetLoad];
}


-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"看看是第几步了:%@",self.kspReqDetailModel.Desc);
}


#pragma mark leftBarButton的监听
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  self.customCell.frame.size.height;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ServerDetailCell" owner:self options:nil];
    NSDictionary *dic = [dicData objectForKey:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];
    ServerDetailCell *cellD = nil;
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        cellD = cell = self.customCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
    }
    //获取数据源中_person数组中的元素，对应每一个cell
    //通过tag值来获取控件
    
    
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
        if (indexPath.row==0) {//9,2,1
//            UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
//            [title setText:@"竞标中"];
//            if ([self.kspReqDetailModel.Step isEqualToString:@"1"]) {
//                [title setTextColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1]];
//                UIView *view=(UIView *)[cell.contentView viewWithTag:2];
//                [view setBackgroundColor:[UIColor orangeColor]];
//                
//                UIView *line=(UIView *)[cell.contentView viewWithTag:1];
//                [line setBackgroundColor:[UIColor greenColor]];
//            }
//            
//            UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
//            [detailText setText:@"等待需求方选择，您现在可以查看需求以及提交的竞标申请，也可以选择取消竞标."];
            
            //checkDemandButton查看需求
            UIButton *checkDemandButton=[UIButton buttonWithType:UIButtonTypeSystem];
            checkDemandButton.frame=CGRectMake(cell.frame.size.width/7+13, cell.frame.size.height-30, 80, 25);
            [checkDemandButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [checkDemandButton setTitle:@"查看需求" forState:UIControlStateNormal];
            checkDemandButton.tag=0;
            [checkDemandButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [checkDemandButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [checkDemandButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:checkDemandButton];
            
            
            //biddingApplyButton竞标申请
            UIButton *biddingApplyButton=[UIButton buttonWithType:UIButtonTypeSystem];
            biddingApplyButton.frame=CGRectMake(cell.frame.size.width/7+102, cell.frame.size.height-30, 80, 25);
            [biddingApplyButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [biddingApplyButton setTitle:@"竞标申请" forState:UIControlStateNormal];
            biddingApplyButton.tag=1;
            [biddingApplyButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [biddingApplyButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [biddingApplyButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:biddingApplyButton];
            
            
            //cancelBiddingButton填写服务订单
            UIButton *cancelBiddingButton=[UIButton buttonWithType:UIButtonTypeSystem];
            cancelBiddingButton.frame=CGRectMake(cell.frame.size.width/7+187, cell.frame.size.height-30, 80, 25);
            [cancelBiddingButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [cancelBiddingButton setTitle:@"取消竞标" forState:UIControlStateNormal];
            cancelBiddingButton.tag=2;
            [cancelBiddingButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [cancelBiddingButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [cancelBiddingButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:cancelBiddingButton];
            
            
            
            
            
            
        }else if(indexPath.row==1){
            
            UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
            [title setText:@"已竞标"];
            
            UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
            [detailText setText:@"您可以主动和需求方沟通服务时间及时长，沟通后请需求方填写服务订单."];
            
            
            //connectionButton和需求方沟通
            UIButton *connectionButton=[UIButton buttonWithType:UIButtonTypeSystem];
            connectionButton.frame=CGRectMake(cell.frame.size.width/2+55, cell.frame.size.height-30, 100, 25);
            [connectionButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [connectionButton setTitle:@"和需求方沟通" forState:UIControlStateNormal];
            connectionButton.tag=3;
            [connectionButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [connectionButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [connectionButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:connectionButton];
            
        }else if (indexPath.row==2){
            
//            UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
//            [title setText:@"等待服务开始"];
//            
//            UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
//            [detailText setText:@"服务订单已生成，您可以查看服务订单，并在约定的时间开始服务."];
            
            //checkServerApplyButton查看服务订单
            UIButton *checkServerApplyButton=[UIButton buttonWithType:UIButtonTypeSystem];
            checkServerApplyButton.frame=CGRectMake(cell.frame.size.width/2+55, cell.frame.size.height-30, 100, 25);
            [checkServerApplyButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [checkServerApplyButton setTitle:@"查看服务订单" forState:UIControlStateNormal];
            checkServerApplyButton.tag=4;
            [checkServerApplyButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [checkServerApplyButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [checkServerApplyButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:checkServerApplyButton];
            
            
        }else if (indexPath.row==3){
//            UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
//            [title setText:@"服务中"];
//            
//            UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
//            [detailText setText:@"如果服务过程已结束，请提交咨询报告."];
            
            
            //deliverButton提交咨询报告
            UIButton *deliverButton=[UIButton buttonWithType:UIButtonTypeSystem];
            deliverButton.frame=CGRectMake(cell.frame.size.width/2+55, cell.frame.size.height-30, 100, 25);
            [deliverButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [deliverButton setTitle:@"提交咨询报告" forState:UIControlStateNormal];
            deliverButton.tag=5;
            [deliverButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [deliverButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [deliverButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:deliverButton];
            
        }else if(indexPath.row==4){
            
//            UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
//            [title setText:@"等待需求方确认"];
//            
//            UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
//            [detailText setText:@"咨询报告已提交，请耐心等待需求方确认，您也可以查看已提交的咨询报告."];
            
            
            //checkdeliverButton查看已提交的咨询报告
            UIButton *checkdeliverButton=[UIButton buttonWithType:UIButtonTypeSystem];
            checkdeliverButton.frame=CGRectMake(cell.frame.size.width/2, cell.frame.size.height-30, 155, 25);
            [checkdeliverButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [checkdeliverButton setTitle:@"查看已提交的咨询报告" forState:UIControlStateNormal];
            checkdeliverButton.tag=6;
            [checkdeliverButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [checkdeliverButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [checkdeliverButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:checkdeliverButton];
            
            
            
        }else{
//            UILabel *title=(UILabel *)[cell.contentView viewWithTag:9];
//            [title setText:@"服务完成"];
//            
//            UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:4];
//            [detailText setText:@"服务已完成，您可以给服务方提供的服务做出您的评价。"];
            
            
            //evaluateButton评价
            UIButton *evaluateButton=[UIButton buttonWithType:UIButtonTypeSystem];
            evaluateButton.frame=CGRectMake(cell.frame.size.width/2+75, cell.frame.size.height-30, 80, 25);
            [evaluateButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
            [evaluateButton setTitle:@"评价" forState:UIControlStateNormal];
            evaluateButton.tag=7;
            [evaluateButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [evaluateButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
            [evaluateButton addTarget:self action:@selector(clickWithButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:evaluateButton];
            
            
        }
    }
    

    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ServerDetailHeader *header=[[ServerDetailHeader alloc]init];
    
    header.frame=CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 70);
    //头像
   // [header.imageView setImage:[UIImage imageNamed:@"credit_05.png"]];
    [header.imageView setImageWithURL:[NSURL URLWithString:self.getReqDetailModel.PublisherAvatar] placeholderImage:[UIImage imageNamed:@"credit_05.png"]];
    //标题
    
    [header.title setText:self.getReqDetailModel.Title];
    
    //日期
    
    [header.date setText:self.getReqDetailModel.AddTime];
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  70;
}

#pragma mark -服务详情里所有按钮的监听
-(void)clickWithButton:(UIButton *)button{
    NSLog(@"%ld button is clicked",button.tag);
    if (button.tag==0) {
//        _demandDetailController.getReqDetailModel=[[GetReqDetailModel alloc]init];
//        _demandDetailController.getReqDetailModel=self.getReqDetailModel;
        DemandDetailController *vc = [[DemandDetailController alloc]init];
        vc.reqID = self.rID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag==1) {
        //[self showHUD];
        //加载数据
        //[self loadApplyData];
        BiddingApplyController *vc = [[BiddingApplyController alloc]init];
        vc.rID = self.rID;
        [self.navigationController pushViewController:vc animated:YES];
        
      
    }
    if (button.tag==2) {
        //弹出框
         [self ShowAlertView];
        //[self.navigationController pushViewController:_hunterServerController animated:YES];
    }
    if (button.tag==3) {//和需求方goutong
        //[self.navigationController pushViewController:_serverDadaDetailController animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
        [dic setObject:[NSData AES256Encrypt:self.rID key:TOKEN] forKey:@"ReqID"];
        [dic setObject:[NSData AES256Encrypt:@"1" key:TOKEN] forKey:@"Type"];
        [ChinaValueInterface GetReqDetailParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData
            MyServerDataDetailController *vc = [[MyServerDataDetailController alloc]init];
            vc.uid = dic[@"PublisherID"];
            vc.userName = dic[@"PublisherName"];
            vc.type = 2;
            [hud hide:YES];
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = error.domain;
            [hud hide:YES afterDelay:1.5f];
        }];
    }
    if (button.tag==4) {//查看服务订单
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
        [dic setObject:[NSData AES256Encrypt:self.rID key:TOKEN] forKey:@"ReqID"];
        [dic setObject:[NSData AES256Encrypt:@"1" key:TOKEN] forKey:@"Type"];
        [ChinaValueInterface GetReqDetailParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData
            CheckServerPageController *vc = [[CheckServerPageController alloc]init];
            vc.ReqID = self.rID;
//            [self.navigationController pushViewController:vc animated:YES];
//            MyServerDataDetailController *vc = [[MyServerDataDetailController alloc]init];
            vc.uID = dic[@"PublisherID"];
            [hud hide:YES];
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = error.domain;
            [hud hide:YES afterDelay:1.5f];
        }];
        
//        [self loadApplyData];
//        _checkSercerPageController.getReqDetailModel=[[GetReqDetailModel alloc]init];
//        _checkSercerPageController.getReqDetailModel=self.getReqDetailModel;
//        [_checkSercerPageController.tableView reloadData];
//        [self.navigationController pushViewController:_checkSercerPageController animated:YES];
    }
    if (button.tag==5) {
        //提交咨询报告
        DeliverReportViewController *vc = [[DeliverReportViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag==6) {
       // [self.navigationController pushViewController:_writeServerPageController animated:YES];
        //查看提交的咨询报告
        //[self loadDataWithReportview];
        UIAlertView *aview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否下载咨询报告？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aview.tag = 112;
        [aview show];
    }
    if(button.tag==7){
        
        MBProgressHUD *HUD2 = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        HUD2.mode = MBProgressHUDModeText;
        HUD2.detailsLabelText = @"正在完善";
        [HUD2 hide:YES afterDelay:1.5f];
//        _evaluateController.getReqDetailModel=[[GetReqDetailModel alloc]init];
//        _evaluateController.getReqDetailModel=self.getReqDetailModel;
//        [_evaluateController reloadDataWith:self.getReqDetailModel];
//        
//        [self.navigationController pushViewController:_evaluateController animated:YES];
    }
  }

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==112) {
        if (buttonIndex == 1) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
            [dic setObject:[NSData AES256Encrypt:self.rID key:TOKEN] forKey:@"ReqID"];
            [dic setObject:[NSData AES256Encrypt:@"1" key:TOKEN] forKey:@"Type"];
            [ChinaValueInterface GetReqDetailParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData
                NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
                [dic2 setObject:[NSData AES256Encrypt:dic[@"PublisherID"] key:TOKEN] forKey:@"UID"];
                [dic2 setObject:[NSData AES256Encrypt:self.rID key:TOKEN] forKey:@"ReqID"];
                [ChinaValueInterface KnowKsbReportViewParameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
                    if ([dic[@"Result"] isEqualToString:@"True"]) {
                        NSString *urlString = dic[@"URL"];
                        
                        NSString *fileName = [NSString stringWithFormat:@"%@_%@.doc",[UserModel sharedManager].userID,self.rID];
                        NSString *fileUrl = [self DownloadTextFile:urlString fileName:fileName];
                        
                        self.fileSeeVc = [UIDocumentInteractionController
                                          interactionControllerWithURL:[NSURL fileURLWithPath:fileUrl]];
                        [_fileSeeVc setDelegate:self];
                        [_fileSeeVc presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
                        //
                        [hud hide:YES];
                        
                        //                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        //                    FileSeeViewController* vc = (FileSeeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FileSee"];
                        //                    vc.url = fileUrl;
                        //                    [self.navigationController pushViewController:vc animated:YES];
                    }
                    else
                    {
                        hud.mode = MBProgressHUDModeText;
                        hud.detailsLabelText = dic[@"Result"];
                        [hud hide:YES afterDelay:1.5f];
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    hud.mode = MBProgressHUDModeText;
                    hud.detailsLabelText = error.domain;
                    [hud hide:YES afterDelay:1.5f];
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabelText = error.domain;
                [hud hide:YES afterDelay:1.5f];
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


#pragma mark -查看竞标详情,加载数据
-(void)loadApplyData{
    NSString *enUID=[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN];
    
   
    NSString *enReqID=[NSData AES256Encrypt:self.getReqDetailModel.ReqID key:TOKEN];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:enUID forKey:@"UID"];
    [dic setObject:enReqID forKey:@"ReqID"];
    
//    [dic setObject:enUID forKey:@"UID"];
//    [dic setObject:enReqID forKey:@"ReqID"];
    
    [ChinaValueInterface KspApplyViewParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
          
            NSDictionary *dic1=[ExplainText explainDataWith:responseObject];
            KspApplyViewModel *kspApplyViewModel=[[KspApplyViewModel alloc]initWithDic:dic1];
            
            _biddingApplyController.kspApplyViewModel=kspApplyViewModel;
            
            _checkSercerPageController.kspApplyViewMpdel=[[KspApplyViewModel alloc]init];
            _checkSercerPageController.kspApplyViewMpdel=kspApplyViewModel;

            
            sleep(1);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_biddingApplyController.tableView reloadData];
                [_checkSercerPageController.tableView reloadData];
                [HUD hide:YES];
            });
        });
        
        
        
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load data is failure");
    }];
    

}

#pragma mark -loading页面
-(void)showHUD{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
}
//出现几秒然后消失
-(void)showTextDialogWith:(NSString *)text{
    DialogHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:DialogHUD];
    DialogHUD.labelText = text;
    DialogHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的位置，不指定则在屏幕中间显示
    DialogHUD.yOffset = self.view.frame.size.height/3;
        DialogHUD.xOffset = 0.0f;
    
   
    
    
    [DialogHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [DialogHUD removeFromSuperview];
        DialogHUD = nil;
    }];
}


#pragma mark -取消竞标
-(void)cencelApply{
    
   
    NSString *enUID=[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN];
    
    
    NSString *enReqID=[NSData AES256Encrypt:self.getReqDetailModel.ReqID key:TOKEN];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:enUID forKey:@"UID"];
    [dic setObject:enReqID forKey:@"ReqID"];
    
//    [dic setObject:enUID forKey:@"UID"];
//    [dic setObject:enReqID forKey:@"ReqID"];
    [ChinaValueInterface KspApplyCancelParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSDictionary *dic=[ExplainText explainDataWith:responseObject];
            
            KspApplyCancelModel *kspCancelModel=[[KspApplyCancelModel alloc]initWithDic:dic];
            self.kspApplyCancelModel=kspCancelModel;
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                //弹出状态改变的提示框(toast)
                [self showTextDialogWith:kspCancelModel.Msg];
                NSLog(@"this is dialog text:%@",kspCancelModel.Msg);
                
            });
        });
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog( @"kspCancel is failure");
    }];
    
}

#pragma mark -下载查看咨询报告数据





#pragma mark -alertView

-(void)ShowAlertView{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"确认取消竞标" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate=self;
    [alertView show];
}
//alertView的监听方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag!=112) {
        if (buttonIndex==0) {
            NSLog(@"取消按钮响应");
        }
        if (buttonIndex==1) {
            NSLog(@"确定按钮响应");
            [self cencelApply];
        }
    }
    
    
}


#pragma mark -实现EvaluateController的代理方法，提示评价成功还是失败
-(void)deliverDataToOtherServerDetailController:(CreditEditModel *)credit{
    if ([credit.Result isEqualToString:@"True"]) {
         [self showTextDialogWith:@"评价成功"];
    }else{
        [self showTextDialogWith:@"评价失败"];
    }
    [self.tableView reloadData];
}



#pragma mark -加载数据
-(void)loadNetLoad{
    //传入UID和ReqID就可以获得需求详情
    
    NSString *enUID=[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN];
    
    NSString *reqIDString=self.rID;
    NSString *enReqID=[NSData AES256Encrypt:reqIDString key:TOKEN];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:enUID forKey:@"UID"];
    [dic setObject:enReqID forKey:@"ReqID"];
    
    
    
    [ChinaValueInterface KspReqDetailPatameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSDictionary *dic1=[ExplainText explainDataWith:responseObject];
        //self.kspReqDetailModel=[[KspReqDetailModel alloc]initWithDic:dic1];
        NSArray *array = responseObject[@"ChinaValue"];//dicData
        NSLog(@"%@",array);
        for (NSDictionary *dic in array) {
            [dicData setObject:dic forKey:dic[@"Step"]];
        }
        [self.tableView reloadData];
        
        
        //获取头像和标题以及发布时间：
        [ChinaValueInterface GetReqDetailParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic=[ExplainText explainDataWith:responseObject];
            
            GetReqDetailModel *reqDetail=[[GetReqDetailModel alloc]initWitDic:dic];
            //                _otherServerDetailController.getReqDetailModel=reqDetail;
            //通过getReqDetailModel里面的Industry获取行业名称
            [self loadIndustryWithID:reqDetail.Industry ReqDetail:reqDetail];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"get detail is failure");
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load KspReqDetail data is  failure");
    }];
}

#pragma mark -通过行业id获得行业名称

-(void)loadIndustryWithID:(NSString *)industry ReqDetail:(GetReqDetailModel *)reqDetail{
    NSString *enindustry=[NSData AES256Encrypt:industry key:TOKEN];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:enindustry forKey:@"ID"];
    [ChinaValueInterface GetIndustryParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=[ExplainText explainDataWith:responseObject];
        GetINdustryModel *getIndustrty=[[GetINdustryModel alloc]initWithDic:dic];
        
        reqDetail.IndustryName=getIndustrty.Name;
        self.getReqDetailModel=reqDetail;
        [self.tableView reloadData];
        NSLog( @" name is what:%@",reqDetail.IndustryName);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load industry data is failure");
    }];
    
}
@end
