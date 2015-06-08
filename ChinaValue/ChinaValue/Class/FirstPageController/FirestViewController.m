//
//  FirestViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/21.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//  首页看到的第一个页面

#import "FirestViewController.h"
#import "UIBarButtonItem+ZX.h"
#import "UserCenterController.h"
#import "HunterServerController.h"
#import "MyServerViewController.h"
#import "UserCenterController.h"
#import "DemandManagerController.h"
#import "UserInformationView.h"

#import "ExplainText.h"
#import "ChinaValueInterface.h"
#import "GetKspListModel.h"
#import "UIImageView+WebCache.h"
#import "NSData+ZXAES.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "DemandDetailController.h"
#import "ServerDemandViewController.h"
#import "PublishServerTableViewController.h"


#define TOKEN @"chinavaluetoken=abcdefgh01234567"
#define KPageSize 6   //每页六条数据






@interface FirestViewController ()<UserCenterDelegate,DemandManagerDelagate,UIScrollViewDelegate,MyserverViewDelegate,MBProgressHUDDelegate>{
    HunterServerController *_hunterServerController;
    MyServerViewController *_myServerViewController;
    UserCenterController *_userCenterViewController;
    DemandManagerController *_demandManagerController;
    UIScrollView *_scrollView;
    NSMutableDictionary *_dic;
    NSMutableArray *_kspList;
      
    MBProgressHUD *HUD;
    
    NSMutableArray *viewArray;
    NSMutableArray *dateArray;
    
    NSInteger currentIndex;
    
}
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageController;
//@property(nonatomic,strong)NSMutableArray *viewArray;

@end

@implementation FirestViewController

//- (void)loadView{
//    [super loadView];
//    //状态栏的高度
//    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
//    // 导航栏（navigationbar）
//    CGRect rectNav = self.navigationController.navigationBar.frame;
//    CGFloat Y=rectStatus.size.height+rectNav.size.height;
//    CGFloat W= self.view.frame.size.width;
//    CGFloat H=self.view.frame.size.height-Y;
//    self.view.frame=CGRectMake(0, Y, W, H);
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dic=[[NSMutableDictionary alloc]init];
    viewArray = [[NSMutableArray alloc]init];
    dateArray = [[NSMutableArray alloc]init];
    
    [self loadBaseSetter];
    //createScrollerView
    [self createScrollerView];
    _kspList=[[NSMutableArray alloc]init];
//
//    if (_hunterServerController==nil) {
//        _hunterServerController=[[HunterServerController alloc]init];
//        
//        
//    }
//
//    if (_myServerViewController==nil) {
//        _myServerViewController=[[MyServerViewController alloc]init];
//        _myServerViewController.delegate=self;
//    }
//    if (_userCenterViewController==nil) {
//        _userCenterViewController=[[UserCenterController alloc]init];
//        _userCenterViewController.delegate=self;
//    }
//    if (_demandManagerController==nil) {
//        _demandManagerController=[[DemandManagerController alloc]init];
//        _demandManagerController.delegate=self;
//    }
    
  
       // _dic=[NSDictionary dictionaryWithObject:@"first_04.png" forKey:@"image"];
//        _dic=[NSDictionary dictionaryWithObjectsAndKeys:@"first_04.png",@"image",@"reay",@"name",@"112",@"serverPrice",@"中国深圳",@"address",@"3",@"comentPeople",@"zhang",@"publisherName",nil,nil];
        
    
        //[_dic setObject:@"nihao" forKey:@"hello"];
        

    
    
    
    //add ScrollerView
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNetData:3 PageIndex:0 Key:nil];
}


#pragma mark -创建scrollerView
-(void)createScrollerView{
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-198, self.view.frame.size.width, 84)];
   // [scroll setBackgroundColor:[UIColor redColor]];
    NSInteger width=scroll.bounds.size.width;
    NSInteger height=scroll.bounds.size.height;
    for (NSInteger i=1;i<4;i++) {
        NSInteger x=(i-1)*width;
        UserInformationView *view=[[UserInformationView alloc]initWithFrame:CGRectMake(x, 0, width,height)];
        [view initTextWithDic:_dic];
        //NSLog(@"_dic is %@",[_dic objectForKey:@"hello"]);
        [scroll addSubview:view];
        [viewArray addObject:view];
    }
    [scroll setBounces:NO];
    scroll.delegate=self;
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setContentSize:CGSizeMake(3*width, height)];
    [scroll setPagingEnabled:YES];
    
    
    //添加scollView的点击事件
    scroll.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGuesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollClickAction)];
    tapGuesture.numberOfTapsRequired=1;
    tapGuesture.numberOfTouchesRequired=1;
    [scroll addGestureRecognizer:tapGuesture];
    
    _scrollView=scroll;
    [self.view addSubview:scroll];
    
    UIPageControl *myPageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(15, self.view.frame.size.height-100, self.view.frame.size.width-30, 30)];
    
    myPageControl.backgroundColor = [UIColor clearColor];
    myPageControl.numberOfPages = 3;
    myPageControl.currentPage = 0;
    [myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageController=myPageControl;
    currentIndex = 0;
    
    [self.view addSubview:myPageControl];
    
  
    
}

#pragma mark -scrollView的点击事件
-(void)scrollClickAction{
    NSLog(@"scroll is click");
    NSInteger page =self.pageController.currentPage;
    if ([dateArray count]<(page+1)) {
        return;
    }
    NSDictionary *dic = [dateArray objectAtIndex:page];
    ReqListModel *reqListModel=[[ReqListModel alloc]initWithDic:dic];
    DemandDetailController *vc = [[DemandDetailController alloc]init];
    vc.reqID = reqListModel.ReqID;
    vc.PublisherID = reqListModel.PublisherID;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -changPage事件的监听
-(void)changePage:(UIPageControl *)pageControl{
    NSLog(@"changePage is function");
   
    NSInteger page =self.pageController.currentPage;
    
    NSLog(@"%ld",page);
    //消息栏目更新
    if(page==0){
        NSLog(@"page is 0");
    }
    if(page==1){
        NSLog(@"page is 1");
    }
    if(page==2){
        NSLog(@"page is 2");
    }
    // update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    currentIndex = page;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark -scrollerView的协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    
    NSLog(@"%f %f",_scrollView.contentOffset.x,_scrollView.contentSize.width);
   int offset = _scrollView.contentOffset.x ;
    if (offset<1) {
        currentIndex = 0;
    }
    else if (offset<(_scrollView.frame.size.width*1+1)) {
        currentIndex = 1;
    }
    else
        currentIndex = 2;
    self.pageController.currentPage = currentIndex;
    

}
#pragma mark -基础控件设置
-(void)loadBaseSetter{
    //设置导航栏左右侧按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithLeftIcon:@"first_menu.png" highLight:nil target:self action:@selector(leftAction)];
    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithRightIcon:@"first_search.png" highLight:nil target:self action:@selector(rightItemAction)];
    //设施导航栏的title的图片
    UIImageView *titleImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weixin_login.png"]];
    titleImageView.frame=CGRectMake(160, 25, 25, 25);
    self.navigationItem.titleView=titleImageView;
    titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    //添加背景图片
    UIImageView *bgImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"first_bg.png"]];
    bgImageView.frame=self.view.bounds;
    [self.view addSubview:bgImageView];
     
    //我有需求
    UIButton *helpButton=[UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.frame=CGRectMake(20, self.view.frame.size.height/3-65,160, 160);
    [helpButton setBackgroundImage:[UIImage imageNamed:@"first_11.png"] forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(helpButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:helpButton];
    UILabel *label1=[[UILabel alloc]init];
    CGFloat labelY=helpButton.frame.origin.y+helpButton.frame.size.height;
    label1.frame=CGRectMake(65,labelY, helpButton.frame.size.width, 20);
    label1.text=@"我有需求";
    [label1 setTextColor:[UIColor whiteColor]];
    [self.view addSubview:label1];
    
    //我来服务
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(self.view.frame.size.width-180, self.view.frame.size.height/3-65,160, 160);
    [button setBackgroundImage:[UIImage imageNamed:@"click2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(myServerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label2=[[UILabel alloc]init];
    CGFloat label2Y=button.frame.origin.y+button.frame.size.height;
    label2.frame=CGRectMake(self.view.frame.size.width-135,label2Y, button.frame.size.width, 20);
    label2.text=@"我来服务";
    [label2 setTextColor:[UIColor whiteColor]];
    [self.view addSubview:label2];
    
    
    //scrollerView
    


}

#pragma mark -按钮监听

-(void)leftAction{
    NSLog(@"left Button Action");
    //[self.delegate pushChildView];
    [self.navigationController pushViewController:[[UserCenterController alloc]init] animated:YES];
}
-(void)rightItemAction{
    NSLog(@"rightItemButton is begin work");
    [self.navigationController pushViewController:_hunterServerController animated:YES];
}

-(void)helpButtonAction{
    
     //[self showHUD];
    
    
    //加载数据
    //[self loadNetData:KPageSize PageIndex:1 Key:nil];
  
    
    
    //进入我有需求页面
   
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PublishServerTableViewController* vc = (PublishServerTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"severVC"];
        [self.navigationController pushViewController:vc animated:YES];
        //[[ServerDemandViewController alloc]init]
    }
    else
    {
        LoginViewController *VC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
  
}

-(void)myServerButtonAction{
    //进入“我要服务”界面
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
        [self.navigationController pushViewController:[[MyServerViewController alloc]init] animated:YES];
        //[[ServerDemandViewController alloc]init]
    }
    else
    {
        LoginViewController *VC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    //然后要显示dock(通过协议通知上一层,显示dock)
    //[self.delegate addDockToHomeController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -成员方法
-(void)pushViewContrllerWithHunter{
    [self.navigationController pushViewController:_hunterServerController animated:YES];
}

#pragma mark -usercenter的协议方法
- (void)deliverThisTitleWith:(NSString *)str{
    //接收到usercenter 的消息后，再通知homecontroller要remove dock
    [self.delegate userCenterNeedToRomoveDock];
}

#pragma mark -demadManagerController的协议方法
//- (void)demandManagerNeedToAddDock{
//    //通知home去recoverDock
//  //  [self.delegate recovreDockToUserCenter];
//}
- (void)addDockAgain{
    [self.delegate recovreDockToUserCenter];
}


#pragma mark -MyServerViewController的代理方法
-(void)myServerViewControllerNeedtoRemoveDock{
    //接收到MyServerDetail 的消息后，再通知homecontroller要remove dock
    [self.delegate userCenterNeedToRomoveDock];

}

-(void)myServerViewControllerNeedToRecoverDock{
    //接收到MyServerDetail 的消息后，再通知homecontroller要recover dock
    [self.delegate recovreDockToUserCenter];
}


#pragma mark -加载网络数据
#pragma mark loadNetData加载网络数据
-(void)loadNetData:(NSInteger)PageSize PageIndex:(NSInteger)pageIndex Key:(NSString *)key{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *pagesize=[NSString stringWithFormat:@"%ld",PageSize];
    NSString *pageindex=[NSString stringWithFormat:@"%ld",pageIndex];
    
    NSString *enPageSize=[NSData AES256Encrypt:pagesize key:TOKEN];
    
    NSString *enpageIndex=[NSData AES256Encrypt:pageindex key:TOKEN];
    
    //NSString *enKey=[NSData AES256Encrypt:key key:TOKEN];
    
    [dic setObject:enPageSize forKey:@"PageSize"];
    [dic setObject:enpageIndex forKey:@"PageIndex"];
    //[dic setObject:enKey forKey:@"Key"];
    [ChinaValueInterface GetReqListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
        dateArray = [dataArray copy];
//        for (NSDictionary *dic in dataArray) {
//            GetKspListModel *ksp=[[GetKspListModel alloc]initWithDic:dic];
//            NSLog(@"dic is %@",dic);
//            [_kspList addObject:ksp];
//            
//        }
        NSLog(@"ksp的数量到底有多少%ld",[dataArray count]);
        [self reloadScrollData];
        //[HUD hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        HUD.mode = MBProgressHUDModeText;
//        HUD.labelText = error.domain;
//        [HUD hide:YES afterDelay:1.5f];
    }];
    
    
}

-(void)reloadScrollData
{
    for (int i=0; i<3&&i<[dateArray count]; i++) {
        UserInformationView *view = [viewArray objectAtIndex:i];
        NSDictionary *model = [dateArray objectAtIndex:i];
        [view initTextWithDic:model];
    }
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
