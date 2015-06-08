//
//  HunterServerController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "HunterServerController.h"
#import "UIBarButtonItem+ZX.h"
#import "UIImage+ZX.h"
#import "UISearchBar+ZX.h"
#import "HomeViewController.h"
#import "UIImage+ZX.h"
#import "ServerDemandViewController.h"
#import "ExplainText.h"
#import "ChinaValueInterface.h"
#import "GetKspListModel.h"
#import "UIImageView+WebCache.h"
#import "NSData+ZXAES.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "UserDataDetail.h"
#import "PublishServerTableViewController.h"
#import "NSString+ZX.h"

#define KPageSize 6   //每页六条数据

#define TOKEN @"chinavaluetoken=abcdefgh01234567"

#define MJDuration 2

@interface HunterServerController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UIWebViewDelegate>{
    UISearchBar *_searchBar;
    UITableView *_tableView;
    ServerDemandViewController *_serverDemandViewController;
    NSMutableArray *_kspList;
    GetKspListModel *_ksp;
    NSInteger KpageIndex;
    
    UserDataDetail *_userDataDetail;
    
    MBProgressHUD *HUD;
    IBOutlet UIWebView *webViews;
    
    
}
@property(nonatomic,strong)IBOutlet UITableViewCell *searchCell;

@end

@implementation HunterServerController
{
    NSInteger pageIndex;
    NSInteger lastCount;
    
    UIButton *publishButton;
    
    BOOL add;
    
    NSString *searchKey;
    
    BOOL isfirst;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    KpageIndex=1;
    _kspList = [[NSMutableArray alloc]init];
   
    
    //初始化界面数据
    [self createView];
    [self addRefresh];

    //[self loadNetData:8 PageIndex:KpageIndex Key:@""];
    isfirst = YES;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    publishButton.frame=CGRectMake(10, self.view.height-50, self.view.frame.size.width-20, 44);
    if (isfirst) {
        [self.tableView.legendHeader beginRefreshing];
        isfirst = NO;
    }
}


#pragma mark 初始化界面数据
-(void)createView{
    if (_searchBar==nil) {
        _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0.0, 0.0)];//随便设置，已设置默认的frame
        _searchBar.delegate=self;
        [_searchBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"search_bg.9.png"]]];
        //修改内部左侧提示图标
        //[_searchBar setImage:[UIImage imageNamed:@"search_logo.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        
    }
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]init];
        _tableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    [self.view addSubview:_tableView];
    self.tableView=_tableView;
    
//    if (_serverDemandViewController==nil) {
//        _serverDemandViewController=[[ServerDemandViewController alloc]init];
//    }
//    if (_ksp==nil) {
//        _ksp=[[GetKspListModel alloc]init];
//    }
//    
//    if (_userDataDetail==nil) {
//        _userDataDetail=[[UserDataDetail alloc]init];
//    }
    
    
    // 设置title,此处的title是一个搜索框
    self.navigationItem.titleView=_searchBar;
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc]initWithText:@"搜索" target:self action:@selector(rightButtonAction)];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
    
    
    //隐藏没有内容的表格行
//    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)]];
    
    //    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    //    [view setBackgroundColor:[UIColor whiteColor]];
    
    
    //添加发布需求按钮
    publishButton=[UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame=CGRectMake(10, self.view.height-50, self.view.frame.size.width-20, 44);
    [publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishButton setBackgroundImage:[UIImage resiedImage:@"serverManager_select_11.png"] forState:UIControlStateNormal];
    [publishButton setTitle:@"发布需求" forState:UIControlStateNormal];
    publishButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    [publishButton addTarget:self action:@selector(publishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    // [view addSubview:publishButton];
    // [_tableView.tableFooterView addSubview:view];
    [self.view addSubview:publishButton];

}



#pragma mark -上下拉刷新

-(void)removeRefresh
{
    if (add) {
        [self.tableView removeHeader];
        [self.tableView removeFooter];
        add = NO;
    }
}

-(void)addRefresh{
    if (add) {
        return;
    }
    add = YES;
    __weak typeof(self) weakSelf = self;
    
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    
    
    
    
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    //[self.tableView.legendHeader beginRefreshing];
    
    
    
}


#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    //    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.data addObject:MJRandomData];
    //    }
    if ([_kspList count]!=KpageIndex*8) {
        [self.tableView.footer endRefreshing];
        return;
    }
    KpageIndex=KpageIndex+1;
    
    [self loadNetData:8 PageIndex:KpageIndex Key:searchKey];
    
    
    
    
    //    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 刷新表格
    //
    //    });
}


#pragma mark 下拉刷新数据
- (void)loadNewData
{
    //    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.data insertObject:MJRandomData atIndex:0];
    //    }
    KpageIndex=1;
    
    //先把两个数组全部清空，防止重复加载
    
    //[_reqListModelArray removeAllObjects];
    
    //加载数据
    [self loadNetData:8 PageIndex:KpageIndex Key:searchKey];//每页多少条数据，当前页码
    //    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 刷新表格
    //        [self.tableView reloadData];
    //
    //        // 拿到当前的下拉刷新控件，结束刷新状态
    //        [self.tableView.header endRefreshing];
    //    });
}


#pragma mark barButtonItem的监听事件
-(void)backAction{
    
    //要通知homeviewController隐藏Dock
  //  [self.delegate HunterNeedHomeHelpToRemoveDock];

    [self.navigationController popViewControllerAnimated:YES];
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[FirestViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    
    
    
    
}

#pragma mark 搜索按钮的监听事件
-(void)rightButtonAction{
    
    
    //点击search后
    [self showHUD];
    searchKey = _searchBar.text;
    //[self loadNetData:KPageSize PageIndex:KpageIndex Key:searchKey];
    //[_tableView reloadData];
    
    //关闭键盘
    [_searchBar endEditing:YES];
    [self loadNewData];
    
    NSLog(@"_search text is :%@",_searchBar.text);
}

#pragma mark publishButton按钮的监听
-(void)publishButtonAction{
    NSLog(@"publish button is function");
    //跳转到服务需求页面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"severVC"];
    [self.navigationController pushViewController:vc animated:YES];
//    [self.navigationController pushViewController:[[PublishServerTableViewController alloc]init] animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.kspList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.searchCell = [nib objectAtIndex:0];
        cell = self.searchCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
    }
    
         GetKspListModel *ksp=self.kspList[indexPath.row];
        
        UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:1];
        [imageView setImageWithURL:[NSURL URLWithString:ksp.Avatar] placeholderImage:[UIImage imageNamed:@"serverDetail_02.PNG"]];
        
        UILabel *name=(UILabel *)[cell.contentView viewWithTag:2];
        name.text=ksp.UserName;
        
        UILabel *company=(UILabel *)[cell.contentView viewWithTag:3];
        company.text=ksp.CompanyName;
        
        UILabel *dutyName=(UILabel *)[cell.contentView viewWithTag:4];
        dutyName.text=ksp.DutyName;
        
        
        UILabel *about=(UILabel *)[cell.contentView viewWithTag:5];
        about.text=ksp.About;
        

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserDataDetail *vc = [[UserDataDetail alloc]init];
    GetKspListModel *ksp=self.kspList[indexPath.row];
    vc.uid = ksp.UID;
    vc.userName = ksp.UserName;
    [self.navigationController pushViewController:vc animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.searchCell.frame.size.height;
}


//点击键盘的Search触发的事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search button clisk:%@",searchBar.text);
    
    KpageIndex = 1;
    //点击search后
     [self showHUD];
    searchKey = searchBar.text;
    [self loadNewData];
    //[self loadNetData:KPageSize PageIndex:KpageIndex Key:searchBar.text];
    //[_tableView reloadData];
    
    //关闭键盘
    [searchBar endEditing:YES];
    //[self exitKeyboard:searchBar];
}







//#pragma mark -上下拉刷新
//-(void)addRefresh{
//    __weak typeof(self) weakSelf = self;
//    
//    // 添加传统的上拉刷新
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    [_tableView addLegendFooterWithRefreshingBlock:^{
//        [weakSelf loadMoreData];
//    }];
//    
//    
//    
//    
//    
//    // 添加传统的下拉刷新
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    [_tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakSelf loadNewData];
//    }];
//    
//    // 马上进入刷新状态
//    [_tableView.legendHeader beginRefreshing];
//    
//    
//    
//}
//
//
//#pragma mark 上拉加载更多数据
//- (void)loadMoreData
//{
//    //    // 1.添加假数据
//    //    for (int i = 0; i<5; i++) {
//    //        [self.data addObject:MJRandomData];
//    //    }
//    KpageIndex=KpageIndex+1;
//    
//
//    [self loadNetData:KPageSize PageIndex:KpageIndex Key:_searchBar.text];//传入的Key为searchBar的输入内容
//    
//    
//    
//    
//    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [_tableView reloadData];
//        
//        // 拿到当前的上拉刷新控件，结束刷新状态
//        [_tableView.footer endRefreshing];
//    });
//}
//
//
//#pragma mark 下拉刷新数据
//- (void)loadNewData
//{
//    //    // 1.添加假数据
//    //    for (int i = 0; i<5; i++) {
//    //        [self.data insertObject:MJRandomData atIndex:0];
//    //    }
//    
//    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [_tableView reloadData];
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [_tableView.header endRefreshing];
//    });
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
    if ([key length]>1) {
        [dic setObject:enKey forKey:@"Key"];
    }
    
    //_hunterServerController.kspList=[[NSMutableArray alloc]init];
    //[self.kspList removeAllObjects];//先清空
    
//    if ([key length]>1) {
//        [self addRefresh];
//    }
//    else
//    {
//        [self removeRefresh];
//    }
    [ChinaValueInterface GetKspListPatameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (KpageIndex==1) {
            [_kspList removeAllObjects];
        }
        
        NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
        for (NSDictionary *dic in dataArray) {
            GetKspListModel *ksp=[[GetKspListModel alloc]initWithDic:dic];
            NSLog(@"dic is %@",dic);
            //[_kspList addObject:ksp];
            [self.kspList addObject:ksp];
        }
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
        [_tableView reloadData];
        
        [HUD hide:YES];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@" load KspListData is failure");
        [HUD hide:YES];
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    }];
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -loading页面
-(void)showHUD{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [_tableView addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
}




@end
