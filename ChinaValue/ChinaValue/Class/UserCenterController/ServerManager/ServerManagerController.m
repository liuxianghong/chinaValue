//
//  ServerManagerController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/22.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

//服务方管理页面

#import "ServerManagerController.h"
#import "MyCell.h"
#import "UIBarButtonItem+ZX.h"
#import "ServerViewController.h"
#import "PersonalDetailController.h"
#import "CreditEvaluationViewControler.h"
#import "CertificateController.h"

#import "ExplainText.h"
#import "ChinaValueInterface.h"
#import "GetKspListModel.h"
#import "UIImageView+WebCache.h"
#import "NSData+ZXAES.h"
#import "MBProgressHUD.h"
#import "KspReqListModel.h"
#import "UserModel.h"
#import "MyServerDataDetailController.h"
#import "KspServiceGetModel.h"
#import "KspHonorListModel.h"



#define TOKEN @"chinavaluetoken=abcdefgh01234567"

@interface ServerManagerController ()<MBProgressHUDDelegate>{
    NSArray *_textArray;
    NSArray *_imageArray;
    ServerViewController *_serverVireController;
    PersonalDetailController *_personalDetailController;
    CreditEvaluationViewControler *_creditEvaluationViewController;
    CertificateController *_certificateController;
    MBProgressHUD *HUD;
    MyServerDataDetailController *_myServerDataDetailController;
    
    NSMutableArray *_honorList;
    
}

@end

@implementation ServerManagerController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_textArray==nil) {
        _textArray=@[@"服务管理",@"我的服务资料",@"我的荣誉/资质/证书",@"我的信用评价"];
    }
    if (_imageArray==nil) {
        _imageArray=@[@"service_manage_logo.png",@"service_manage_update.PNG",@"service_manage_book.PNG",@"service_manage_start.png"];
    }
//    if (_serverVireController==nil) {
//        _serverVireController=[[ServerViewController alloc]init];
//    }
//    if (_personalDetailController==nil) {
//        _personalDetailController=[[PersonalDetailController alloc]init];
//    }
//    if(_creditEvaluationViewController==nil){
//        _creditEvaluationViewController=[[CreditEvaluationViewControler alloc]init];
//    }
//    if (_certificateController==nil) {
//        _certificateController=[[CertificateController alloc]init];
//    }
//    if (_myServerDataDetailController==nil) {
//        _myServerDataDetailController=[[MyServerDataDetailController alloc]init];
//    }
    
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //去掉没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"服务方管理"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
   
}

#pragma mark barButtonItem的监听事件
-(void)backAction{
    //给父视图通知，把dock重新加载回来
    //[self.delegate recoverDockAgain];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_textArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    MyCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    [cell.imageView setImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
     cell.textLabel.text=_textArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        //加载服务管理页面的数据
        //[self showHUD];
        //[self loadServerManageData];
        
        [self.navigationController pushViewController:[[ServerViewController alloc]init] animated:YES];
    }
    if (indexPath.row==1) {
        //加载用户联系方式数据
        //NSDictionary *dic2 = [tableArray objectAtIndex:btn.tag];
        MyServerDataDetailController *vc = [[MyServerDataDetailController alloc]init];
        vc.uid = [UserModel sharedManager].userID;
        vc.userName = @"我";
        [self.navigationController pushViewController:vc animated:YES];
        //[self.navigationController pushViewController:_myServerDataDetailController animated:YES];//页面跳转
       
    }
    if (indexPath.row==2) {//荣誉证书
        //[self showHUD];
        //加载荣誉证书数据
        //[self loadHonorList];
        CertificateController *vc = [[CertificateController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==3) {
        CreditEvaluationViewControler *vc = [[CreditEvaluationViewControler alloc]init];
        vc.uid = [UserModel sharedManager].userID;
        vc.userName = @"我";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma  mark -加载服务方管理页面的数据
-(void)loadServerManageData{
    //Type为空的时候是全部，type为0是已投标，type为1是已中标
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *userID=[UserModel sharedManager].userID;
    NSString *enUID=[NSData AES256Encrypt:userID key:TOKEN];
    
    NSString *entype0=[NSData AES256Encrypt:@"0" key:TOKEN];
    NSString *entype1=[NSData AES256Encrypt:@"1" key:TOKEN];
    
    //加载全部
    [dic setObject:enUID forKey:@"UID"];
    [ChinaValueInterface KspReqListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
            _serverVireController.allList=[[NSMutableArray alloc]init];

            for (NSDictionary *dic in dataArray) {
                KspReqListModel *kspModel=[[KspReqListModel alloc]initWithDic:dic];
                               [_serverVireController.allList addObject:kspModel];
            
               
            }
            sleep(1);
            NSLog(@"看看有多少条数据:%lu",(unsigned long)_serverVireController.allList.count);
            
            dispatch_async(dispatch_get_main_queue(), ^{
              //  [_tableView reloadData];
                [_serverVireController.tableView reloadData];
                
                [HUD hide:YES];
                
                
                
            });
        });

        
        
        
        
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load KspReaList Data is failure");
    }];
    
    //加载已投标
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:enUID forKey:@"UID"];
    [dic1 setObject:entype0 forKey:@"Type"];
    [ChinaValueInterface KspReqListParameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
         _serverVireController.bidList=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataArray){
            KspReqListModel *kspModel=[[KspReqListModel alloc]initWithDic:dic];
           
            [_serverVireController.bidList addObject:kspModel];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Load kspReaList data is failure");
    }];
    
    
    //加载已中标
    NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
    [dic2 setObject:enUID forKey:@"UID"];
    [dic2 setObject:entype1 forKey:@"Type"];
    [ChinaValueInterface KspReqListParameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
         _serverVireController.competiveBidList=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataArray){
            KspReqListModel *kspModel=[[KspReqListModel alloc]initWithDic:dic];
           
            [_serverVireController.competiveBidList addObject:kspModel];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Load kspReaList data is failure");
    }];
    

    
}

#pragma mark -加载用户联系方式数据
-(void)loadContactDataWithUser{
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    NSString *userID=[UserModel sharedManager].userID;
    NSString *enUID=[NSData AES256Encrypt:userID key:TOKEN];
    [dic1 setObject:enUID forKey:@"UID"];
    
    //获取联系方式
    [ChinaValueInterface GeContactPatameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic=[ExplainText explainDataWith:responseObject];
            GeContactModel *getContactModel=[[GeContactModel alloc]initWithDic:dic];
            _myServerDataDetailController.getContactModel=[[GeContactModel alloc]init];
            _myServerDataDetailController.getContactModel=getContactModel;
            
            
             //获取服务资料信息
             [ChinaValueInterface KspServiceGetParameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
                 NSDictionary *dic=[ExplainText explainDataWith:responseObject];
                 _myServerDataDetailController.kspServerGerModel=[[KspServiceGetModel alloc]initWithDic:dic];
                 NSLog(@"看看用户的服务资料:%@",dic);
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"kspServerGet is load failure");
             }];
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
              
                [_myServerDataDetailController.tableView reloadData];
                [HUD hide:YES];
            });
        });
        
        
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@" load contactData is failure");
    }];
    
}
#pragma mark -加载荣誉证书
-(void)loadHonorList{
    //首先要清空Honorlist
    [_certificateController.honorList removeAllObjects];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *userID=[UserModel sharedManager].userID;
    NSString *enUID=[NSData AES256Encrypt:userID key:TOKEN];
    [dic setObject:enUID forKey:@"UID"];
    if (_honorList==nil) {
        _honorList=[[NSMutableArray alloc]init];
    }
    
    [ChinaValueInterface KspHonorListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *dicArray=[[ExplainText alloc]explainManyDataWith:responseObject];
            for (NSDictionary *dic in dicArray) {
                KspHonorListModel *kspHonorModel=[[KspHonorListModel alloc]initWithDic:dic];
                [_honorList addObject:kspHonorModel];
            }
           _certificateController.honorList=[[NSMutableArray alloc]init];
            _certificateController.honorList=_honorList;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_certificateController.tableView reloadData];
                [HUD hide:YES];

            });
        });

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load Honordata is failure");
        
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


@end
