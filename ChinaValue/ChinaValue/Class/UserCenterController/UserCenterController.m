//
//  UserCenterController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/22.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "UserCenterController.h"
#import "UIImage+ZX.h"
#import "MyCell.h"
#import "WBNavigationViewController.h"
#import "ServerManagerController.h"
#import "DemandManagerController.h"
#import "UserAccountController.h"
#import "AppDelegate.h"
#import "PersonalDetailController.h"
#import "HunterServerController.h"
#import "UIBarButtonItem+ZX.h"
#import "FirestViewController.h"
#import "ChinaValueInterface.h"
#import "NSData+ZXAES.h"
#import "UserModel.h"
#import "BalanceModel.h"
#import "Dock.h"
#import "MyServerViewController.h"
#import "LoginViewController.h"
#import "ServerDemandViewController.h"
#import "PublishServerTableViewController.h"


#define TOKEN @"chinavaluetoken=abcdefgh01234567"
#define kDockHeight 51.5
@interface UserCenterController ()<ServerManagerDelegate,DemandManagerDelagate,UserAccountDelegate,PersonalDetailDelegate>{
    NSArray *_imageArray;//保存图片的路径
    NSArray *_textArray; //保存文字信息
    WBNavigationViewController *_navigation;
    ServerManagerController *_serverController;
    DemandManagerController *_demanController;
    UserAccountController *_userAccountController;
    PersonalDetailController *_personalDetailController;
    HunterServerController *_hunterServerController;
    FirestViewController *_firstViewController;
    
    Dock *dock;
}

@end

@implementation UserCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242 green:242 blue:242 alpha:1]];
    //设置视图的title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"个人中心"];
    [label setTextColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:label];
    
    
    if (_imageArray==nil) {
        _imageArray=@[@"service_manage.png",@"require_manage.png",@"personal_manage",@"personal_detail_lin.png",@"leave_logo.png"];
    }
    if (_textArray==nil) {
        _textArray=@[@"服务方管理",@"需求方管理",@"个人账户",@"个人资料",@"注销"];
    }

    dock=[[Dock alloc]init];
    [self createDock];
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //去掉没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //隐藏左baritem
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc]initWithLeftIcon:nil highLight:nil target:nil action:nil];
    self.navigationItem.leftBarButtonItem=leftBarItem;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"forget_04.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=leftButton;

}

#pragma mark -按钮监听事件
-(void)backAction{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self recoverDock];
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
    return _imageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
     MyCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=_textArray[indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
//    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
//    [cell loadImageView:imageView];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
           //通知父视图删除dock
           //[self.delegate deliverThisTitleWith:_textArray[indexPath.row]];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
            //[self loadData];
            [self.navigationController pushViewController:[[ServerManagerController alloc]init] animated:YES];
            
        }
        else
        {
            LoginViewController *VC = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
            [self presentViewController:nav animated:YES completion:nil];
        }
      
        
//        //改变根视图
//        UIApplication *app=[UIApplication sharedApplication];
//        AppDelegate *app2=app.delegate;
//        app2.window.rootViewController=_firstController;
//        [_firstController.view addSubview:_serverController.view];
        
    }
    if(indexPath.row==1){
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
            //[self loadData];
            [self.navigationController pushViewController:[[DemandManagerController alloc]init] animated:YES];
        }
        else
        {
            LoginViewController *VC = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
    if (indexPath.row==2) {
        //[self.delegate deliverThisTitleWith:_textArray[indexPath.row]];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
            //[self loadData];
            [self.navigationController pushViewController:[[UserAccountController alloc]init] animated:YES];
        }
        else
        {
            LoginViewController *VC = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
            [self presentViewController:nav animated:YES completion:nil];
        }
        //先加载网络数据再push出页面
        
         //刷新即将进入的视图
       // [_userAccountController reloadTableData];
        
    }
    if (indexPath.row==3) {
        [self.delegate deliverThisTitleWith:_textArray[indexPath.row]];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
            [self.navigationController pushViewController:[[PersonalDetailController alloc]init] animated:YES];
        }
        else
        {
            LoginViewController *VC = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    }
    if (indexPath.row==4) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UID"];
        LoginViewController *VC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
#pragma mark loadData获取网络数据
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load user balance is failure");
    }];
}

#pragma mark serverManager的协议方法
- (void)recoverDockAgain{
    NSLog(@"recover again");
   // [self addDock];
    
    //通知HomeViewController重新加载回dock
    [self.delegate addDockAgain];
}
#pragma mark demandManager的协议方法
-(void)demandManagerNeedToAddDock{
    //通知HomeViewController重新加载回dock
    [self.delegate addDockAgain];

}

#pragma mark userAccounrController的协议方法
-(void)userAccountNeedToAddDock{
    //通知HomeViewController重新加载回dock
    [self.delegate addDockAgain];
}
#pragma mark personalDetailController的协议方法
-(void)personnalDetailNeedToAddDock{
    //通知HomeViewController重新加载回dock
    [self.delegate addDockAgain];
}



#pragma mark- 成员方法
- (void)popViewControllerToFirstViewController{
    NSLog(@"this pop method is function");
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FirestViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
   // [self.navigationController popViewControllerAnimated:YES];

}



#pragma mark -解密数据
-(NSDictionary *)explainDataWith:(id)responseObject{
    NSDictionary *dict=responseObject;
    NSArray  *dataArray=[dict objectForKey:@"ChinaValue"];
    
    NSLog(@"dict is %@",dataArray);
    NSDictionary *dataDic=dataArray[0];
    
    return dataDic;
}



-(void)createDock{
    dock.frame=CGRectMake(0, self.view.frame.size.height-kDockHeight,self.view.frame.size.width, kDockHeight);
    dock.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"first_buttom_bg.PNG"]];
    [dock setDelegate:self];
    [self.view addSubview:dock];
    [dock addDockItem:@"home_unselect.png" title:@"首页"];
    [dock addDockItem:@"require_unselect.png" title:@"我有需求"];
    [dock addDockItem:@"service_unselect.png" title:@"我来服务"];
    [dock addDockItem:@"search_service_manage_unselect.png" title:@"找服务方"];
    //[dock addDockItem:@"personal_unselect.PNG" title:@"个人中心"];
    //[self recoverDock];
}

#pragma mark 移除dock
-(void)recoverDock{
    //从屏幕外移回来
    dock.frame=CGRectMake(0, self.view.frame.size.height-kDockHeight,self.view.frame.size.width, kDockHeight);
    
}


#pragma mark dock的协议方法
- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to{
    NSLog(@"the dock is form %d to %d",from,to);
    
    if (to==0) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if (to==1) {
        //[self deleteDock];
        
        //[self showHUD];
        //加载数据
        //[self loadNetData:KPageSize PageIndex:1 Key:nil];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PublishServerTableViewController* vc = (PublishServerTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"severVC"];
        [self.navigationController pushViewController:vc animated:YES];
        //[self.navigationController pushViewController:[[ServerDemandViewController alloc]init] animated:YES];
    }
    if(to==2){//我来服务

        [self.navigationController pushViewController:[[MyServerViewController alloc]init] animated:YES];
    }
    if (to==3) {
//        [self deleteDock]; //先移除dock
//        
        [self.navigationController pushViewController:[[HunterServerController alloc]init] animated:YES];
//        i=0;
//        j=0;
    }

}

@end
