//
//  ServerViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//   服务管理页面

#import "ServerViewController.h"
#import "UIBarButtonItem+ZX.h"
#import "ServerManagerCell.h"
#import "OtherServerDetailController.h"
#import "KspReqListModel.h"

#import "KspReqDetailModel.h"
#import "ExplainText.h"
#import "ChinaValueInterface.h"
#import "GetKspListModel.h"
#import "UIImageView+WebCache.h"
#import "NSData+ZXAES.h"
#import "MBProgressHUD.h"
#import "UserModel.h"
#import "MyServerDataDetailController.h"

#import "GetINdustryModel.h"

#define TOKEN @"chinavaluetoken=abcdefgh01234567"

@interface ServerViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    UITableView *_tableView;
    UIButton *_button;
    OtherServerDetailController *_otherServerDetailController;
    NSInteger flag;//用来标记点击了查看哪个选项的按钮
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) IBOutlet UITableViewCell *customCell;

@end

@implementation ServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    flag=0;//默认选中第一个按钮
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"服务管理"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(leftBackAction)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    //初始化tableView
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]init];
        _tableView.frame=CGRectMake(10, 44,self.view.frame.size.width-20, self.view.frame.size.height-108);
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
    }
    self.tableView=_tableView;
    
    //初始化ServerDetailController
    if (_otherServerDetailController==nil) {
        _otherServerDetailController=[[OtherServerDetailController alloc]init];
    }
    // 设置tableview的数据源和代理
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }

    
    //添加Dock
    [self addDock];
    
    //add tableview
    [self.view addSubview:_tableView];
    
    self.allList=[[NSMutableArray alloc]init];
    [self loadServerManageData];
}



#pragma  mark -加载服务方管理页面的数据
-(void)loadServerManageData{
    //Type为空的时候是全部，type为0是已投标，type为1是已中标
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *userID=[UserModel sharedManager].userID;
    NSString *enUID=[NSData AES256Encrypt:userID key:TOKEN];
    
    NSString *entype0=[NSData AES256Encrypt:@"0" key:TOKEN];
    NSString *entype1=[NSData AES256Encrypt:@"1" key:TOKEN];
    
//    //加载全部
//    [dic setObject:enUID forKey:@"UID"];
//    [ChinaValueInterface KspReqListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
//            self.allList=[[NSMutableArray alloc]init];
//            
//            for (NSDictionary *dic in dataArray) {
//                KspReqListModel *kspModel=[[KspReqListModel alloc]initWithDic:dic];
//                [self.allList addObject:kspModel];
//                
//                
//            }
//            sleep(1);
//            NSLog(@"看看有多少条数据:%lu",(unsigned long)self.allList.count);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //  [_tableView reloadData];
//                [self.tableView reloadData];
//                
//                //[HUD hide:YES];
//                
//                
//                
//            });
//        });
//        
//        
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"load KspReaList Data is failure");
//    }];
    
    //加载已投标
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:enUID forKey:@"UID"];
    [dic1 setObject:entype0 forKey:@"Type"];
    [ChinaValueInterface KspReqListParameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
        self.bidList=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataArray){
            KspReqListModel *kspModel=[[KspReqListModel alloc]initWithDic:dic];
            
            [self.bidList addObject:kspModel];
            [self.allList addObject:kspModel];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Load kspReaList data is failure");
    }];
    
    
    //加载已中标
    NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
    [dic2 setObject:enUID forKey:@"UID"];
    [dic2 setObject:entype1 forKey:@"Type"];
    [ChinaValueInterface KspReqListParameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
        self.competiveBidList=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataArray){
            KspReqListModel *kspModel=[[KspReqListModel alloc]initWithDic:dic];
            [self.competiveBidList addObject:kspModel];
            [self.allList addObject:kspModel];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Load kspReaList data is failure");
    }];
    
    
    
}
#pragma mark addDock
-(void)addDock{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44)];
    view.backgroundColor=[UIColor colorWithRed:242/255 green:242/255 blue:242/255 alpha:0.1];
    CGFloat width=100;
    UIButton *allButton=[UIButton buttonWithType:UIButtonTypeCustom];
    allButton.frame=CGRectMake(35, 5, width, 35);
    [allButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_07.png"] forState:UIControlStateNormal];
    [allButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_01.png"] forState:UIControlStateSelected];
    [allButton setTitle:@"全部" forState:UIControlStateNormal];
    allButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    allButton.tag=0;
    [allButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
    [allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [allButton addTarget:self action:@selector(buttonClickActionWith:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:allButton];
    
    //默认选中第一个
    NSInteger count=view.subviews.count;
    if (count==1) {
        [self buttonClickActionWith:allButton];
    }
    
    UIButton *bidButton=[UIButton buttonWithType:UIButtonTypeCustom];
    bidButton.frame=CGRectMake(35+width, 5, width, 35);
    [bidButton setTitle:@"已投标" forState:UIControlStateNormal];
    [bidButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_02.png"] forState:UIControlStateNormal];
    [bidButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_05.png"] forState:UIControlStateSelected];
    bidButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    bidButton.tag=1;
    [bidButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
    [bidButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [bidButton addTarget:self action:@selector(buttonClickActionWith:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bidButton];
    
    
    UIButton *haveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    haveButton.frame=CGRectMake(35+width*2, 5, width, 35);
    [haveButton setTitle:@"已中标" forState:UIControlStateNormal];
    [haveButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_03.png"] forState:UIControlStateNormal];
    [haveButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_09.png"] forState:UIControlStateSelected];
    haveButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    haveButton.tag=2;
    [haveButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
    [haveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [haveButton addTarget:self action:@selector(buttonClickActionWith:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:haveButton];
    
    
    [self.view addSubview:view];
    
}

-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -顶部dock栏按钮的监听事件
-(void)buttonClickActionWith:(UIButton *)button{
    [self buttonSelectedFrom:_button.tag to:button.tag];
    //取消当前选中
    _button.selected=NO;
    //设置选中
    button.selected=YES;
    _button=button;
    
    if (button.tag==0) {
        flag=0;
        [_tableView reloadData];
    }
    if (button.tag==1) {
        flag=1;
         [_tableView reloadData];
    }
    if (button.tag==2) {
        flag=2;
         [_tableView reloadData];
    }
    
}
#pragma mark 从哪个按钮跳到哪个按钮
-(void)buttonSelectedFrom:(int)from to:(int)to{
    //根据tag来控制按钮之间的切换
    NSLog(@"%d from to %d",from,to);
    
}


#pragma mark -实现tableview的协议和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (flag==0) {
        return self.allList.count;
    }
    if (flag==1) {
        return self.bidList.count;
    }
    return self.competiveBidList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ServerManagerCell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
    }
    //获取数据源中_person数组中的元素，对应每一个cell
    //通过tag值来获取控件
    UILabel *headText=(UILabel *)[cell.contentView viewWithTag:1];
    UILabel *statuesText=(UILabel *)[cell.contentView viewWithTag:2];
    UILabel *numberText=(UILabel *)[cell.contentView viewWithTag:3];
    UILabel *releaseTime=(UILabel *)[cell.contentView viewWithTag:4];
    UILabel *deadTime=(UILabel *)[cell.contentView viewWithTag:5];
    UIButton *detail=(UIButton *)[cell.contentView viewWithTag:6];
   
    
    //再设置
    if (flag==0) {
        KspReqListModel *ksp=_allList[indexPath.row];
        [headText setText:ksp.Title];
        [statuesText setText:ksp.Status];
        [numberText setText:ksp.ReqID];
        [releaseTime setText:ksp.AddTime];
        [deadTime setText:ksp.EndTime];
        detail.tag=[ksp.ReqID intValue];
    }
    if (flag==1) {
        KspReqListModel *ksp=_bidList[indexPath.row];
        [headText setText:ksp.Title];
        [statuesText setText:ksp.Status];
        [numberText setText:ksp.ReqID];
        [releaseTime setText:ksp.AddTime];
        [deadTime setText:ksp.EndTime];
        detail.tag=[ksp.ReqID intValue];
    }
    if (flag==2) {
        KspReqListModel *ksp=_competiveBidList[indexPath.row];
        [headText setText:ksp.Title];
        [statuesText setText:ksp.Status];
        [numberText setText:ksp.ReqID];
        [releaseTime setText:ksp.AddTime];
        [deadTime setText:ksp.EndTime];
        detail.tag=[ksp.ReqID intValue];
    }


    
    [detail setTitle:@"查看详情" forState:UIControlStateNormal];
    [detail addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.customCell.frame.size.height;
}


#pragma mark －查看详情按钮的监听事件
-(void)detailAction:(UIButton *)button{
    
  //  NSLog(@"button 的 tag 是什么呢：%ld",button.tag);
    //[self showHUD];
    //加载数据
    //[self loadNetLoad:button.tag];
    
    OtherServerDetailController *vc = [[OtherServerDetailController alloc]init];
    vc.rID = [NSString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:vc animated:YES];
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
