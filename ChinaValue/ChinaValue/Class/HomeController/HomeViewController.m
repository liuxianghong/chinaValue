//
//  HomeViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/21.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//这是一个navigation用来管理后面所有的controller

#import "HomeViewController.h"
#import "WBNavigationViewController.h"
#import "Dock.h"
#import "ServerManagerController.h"
#import "HunterServerController.h"
#import "MyServerViewController.h"
#import "HunterServerController.h"
#import "MBProgressHUD.h"
#import "ChinaValueInterface.h"
#import "GetKspListModel.h"
#import "NSData+ZXAES.h"
#import "ExplainText.h"

#define KPageSize 6   //每页六条数据

#define TOKEN @"chinavaluetoken=abcdefgh01234567"

#define kDockHeight 51.5
@interface HomeViewController ()<DockDelegate,HunterServerDelegate,MBProgressHUDDelegate>{
    FirestViewController *_firstViewController;
    WBNavigationViewController *_nav;
    UserCenterController *_userCenterController;
    WBNavigationViewController *_userNV;
    ServerManagerController *_serverManagerController;
    WBNavigationViewController *_serverNV;
    Dock *dock;
    HunterServerController *_hunterServerController;
    MyServerViewController *_myServerViewController;
    NSInteger i;
    NSInteger j;
    MBProgressHUD *HUD;
    NSMutableArray *_kspList;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i=0;
    j=0;
    // Do any additional setup after loading the view.
//    if (_firstViewController==nil) {
//        _firstViewController=[[FirestViewController alloc]init];
//        [_firstViewController setDelegate:self];
//    }
//    
//    if (_nav==nil) {
//        _nav=[[WBNavigationViewController alloc]initWithRootViewController:_firstViewController];
//    }
//    [self addChildViewController:_nav];
//    [self.view addSubview:_nav.view];
//    
//    //dock
//
//    if (_userCenterController==nil) {
//        _userCenterController=[[UserCenterController alloc]init];
//        _userCenterController.delegate=self;
//       
//    }
//    if (_userNV==nil) {
//        _userNV=[[WBNavigationViewController alloc]initWithRootViewController:_userCenterController];
//        [self addChildViewController:_userNV];
//    }
//    
//    if (_serverManagerController==nil) {
//        _serverManagerController=[[ServerManagerController alloc]init];
//       
//    }
//    
//    if (_serverNV==nil) {
//        _serverNV=[[WBNavigationViewController alloc]initWithRootViewController:_serverManagerController];
//        [self addChildViewController:_serverNV];
//    }
//    
//    
//    if (_hunterServerController==nil) {
//        _hunterServerController=[[HunterServerController alloc]init];
//        _hunterServerController.delegate=self;
//        
//    }
//    if (_myServerViewController==nil) {
//        _myServerViewController=[[MyServerViewController alloc]init];
//    }
    //[self addDock];
    dock=[[Dock alloc]init];
    [self createDock];
    
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self recoverDock];
}


//#pragma mark -添加dock
-(void)createDock{
    dock.frame=CGRectMake(0, self.view.frame.size.height-kDockHeight,self.view.frame.size.width, kDockHeight);
    dock.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"first_buttom_bg.PNG"]];
    [dock setDelegate:self];
    [self.view addSubview:dock];
    [dock addDockItem:@"home_unselect.png" title:@"首页"];
    [dock addDockItem:@"require_unselect.png" title:@"我有需求"];
    [dock addDockItem:@"service_unselect.png" title:@"我来服务"];
    [dock addDockItem:@"search_service_manage_unselect.png" title:@"找服务方"];
    [dock addDockItem:@"personal_unselect.PNG" title:@"个人中心"];
    //[self recoverDock];
    
}

#pragma mark 移除dock
-(void)removeDock{
    //不从屏幕中删除，只移到屏幕能看到的区域外
    dock.frame=CGRectMake(0, self.view.frame.size.height+kDockHeight,self.view.frame.size.width, kDockHeight);
}
-(void)recoverDock{
    //从屏幕外移回来
    dock.frame=CGRectMake(0, self.view.frame.size.height-kDockHeight,self.view.frame.size.width, kDockHeight);

}
-(void)deleteDock{
    //移除dock
    [dock removeFromSuperview];
   
}


#pragma mark dock的协议方法
- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to{
    NSLog(@"the dock is form %d to %d",from,to);
   
    if (to==0) {
        [self deleteDock];
        NSLog(@"item0 is click");
        //点击之后相当于个人中心要pop操作
        if (i>=1) {
            [_firstViewController.navigationController popToRootViewControllerAnimated:YES];
            i=0;
            j=0;
        }
        else{
             [_firstViewController.navigationController popViewControllerAnimated:YES];
            i=0;
            j=0;
        }
       
    }
    if (to==1) {
        [self deleteDock];
        
        [self showHUD];
        //加载数据
        [self loadNetData:KPageSize PageIndex:1 Key:nil];
        
        [_firstViewController.navigationController pushViewController:_hunterServerController animated:YES];
        i=0;
        j=0;
    }
    if(to==2){//我来服务
        i=i+1;
        if (i==1) {
            [self removeDock];
            [_firstViewController.navigationController pushViewController:_myServerViewController animated:YES];
            [self recoverDock];
            j=0;
        }
        i=1;
        j=0;
    }
    if (to==3) {
        [self deleteDock]; //先移除dock
        
        [_firstViewController.navigationController pushViewController:_hunterServerController animated:YES];
        i=0;
        j=0;
    }
    
    if (i==1) { //i＝1的时候表明是从“我来服务”到“个人中心"
        if (to==4) {
            j=j+1;
            if (j==1) {
                //[_firstViewController.navigationController pushViewController:_userCenterController animated:YES];
                [_firstViewController.navigationController popViewControllerAnimated:YES];
                i=0;
            }
            j=1;
            
        }
    }
}
#pragma mark userCenter的协议方法 
-(void)deliverThisTitleWith:(NSString *)str{
//    _serverManagerController.title=str;
//
//    //删除userCenter视图，加载ServerManager视图
//    UIViewController *oldView=self.childViewControllers[1];
//    [oldView.view removeFromSuperview];
//    
//    UIViewController *newController=self.childViewControllers[2];
//    
//   // newController.view.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44);
//    [self.view addSubview:newController.view];
    
  
    
    
    //移除dock
    [self removeDock];
    

}
//-(void)addDockAgain{
//    //[self.view addSubview:dock];
//    [self recoverDock];
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark -firstViewController的协议方法实现
- (void)pushChildView{
//   //这里不是push出子视图,是添加——userNV
//    UIViewController *oldView=self.childViewControllers[0];
//    [oldView.view removeFromSuperview];
//    
//    UIViewController *newController=self.childViewControllers[1];
//   // newController.view.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44);
//       [self.view addSubview:newController.view];
//    //进入home界面的时候不用出现dock，所以在切换视图的时候加入dock在home里
//   // [self addDock];
     [self.view addSubview:dock];
  
  
    
    
}

- (void)userCenterNeedToRomoveDock{
    [self removeDock];
}

-(void)recovreDockToUserCenter{
    [self recoverDock];
}

-(void)addDockToHomeController{
    //[self addDock];
    [self.view addSubview:dock];
}


//#pragma mark -HunterViewController的协议方法
//- (void)HunterNeedHomeHelpToRemoveDock{
//    NSLog(@"hunter delegate is function");
//    [self removeDock];
//}


#pragma mark -加载网络数据
#pragma mark loadNetData加载网络数据
-(void)loadNetData:(NSInteger)PageSize PageIndex:(NSInteger)pageIndex Key:(NSString *)key{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *pagesize=[NSString stringWithFormat:@"%ld",PageSize];
    NSString *pageindex=[NSString stringWithFormat:@"%ld",pageIndex];
    
    NSString *enPageSize=[NSData AES256Encrypt:pagesize key:TOKEN];
    
    NSString *enpageIndex=[NSData AES256Encrypt:pageindex key:TOKEN];
    
    NSString *enKey=[NSData AES256Encrypt:key key:TOKEN];
    
    [dic setObject:enPageSize forKey:@"PageSize"];
    [dic setObject:enpageIndex forKey:@"PageIndex"];
    [dic setObject:enKey forKey:@"Key"];
    
    _hunterServerController.kspList=[[NSMutableArray alloc]init];
    
    [ChinaValueInterface GetKspListPatameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
            for (NSDictionary *dic in dataArray) {
                GetKspListModel *ksp=[[GetKspListModel alloc]initWithDic:dic];
                NSLog(@"dic is %@",dic);
                [_kspList addObject:ksp];
                [_hunterServerController.kspList addObject:ksp];
                
            }
            NSLog(@"ksp的数量到底有多少%ld",[_hunterServerController.kspList count]);
            sleep(1);
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_hunterServerController.tableView reloadData];
                [HUD hide:YES];
                
            });
            
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@" load KspListData is failure");
    }];
    
    
}



#pragma mark -loading页面
-(void)showHUD{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
}



@end
