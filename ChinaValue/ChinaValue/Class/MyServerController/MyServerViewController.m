//
//  MyServerViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/29.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//我来服务视图

#import "MyServerViewController.h"
#import "UIBarButtonItem+ZX.h"
#import "ChinaValueInterface.h"
#import "NSData+ZXAES.h"
#import "ExplainText.h"
#import "ReqListModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "UserDataDetail.h"
#import "UserModel.h"
#import "GetReqDetailModel.h"
#import "DemandDetailController.h"

#define TOKEN @"chinavaluetoken=abcdefgh01234567"
#define KCountData 8   //每页多少条数据

static const CGFloat MJDuration = 2.0;//刷新时间为两秒钟


@interface MyServerViewController ()<UserDataDetailDelegate>{
    NSMutableArray *_dataArray;//用保存解析出来的多条网络数据
    NSMutableArray *_reqListModelArray;//用来保存ReqListModel的数组
    NSInteger KpageIndex;//用来记录分页
    UserDataDetail *_userDataDetail;
    DemandDetailController *_demandDetailController;
    
    BOOL isFirst;
}
@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;
@end

@implementation MyServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"我来服务"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    if (_reqListModelArray==nil) {
        _reqListModelArray=[[NSMutableArray alloc]init];
    }
    if (_userDataDetail==nil) {
        _userDataDetail=[[UserDataDetail alloc]init];
        _userDataDetail.delegate=self;
    }
//    if (_demandDetailController==nil) {
//        _demandDetailController=[[DemandDetailController alloc]init];
//    }
    
    //把多余的表格行隐藏掉
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    }
    
    //把左item隐藏掉
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithIcon:nil highLight:nil target:nil action:nil];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    //初始化分页
    KpageIndex=1;
    
    //添加上拉刷新
    [self addRefresh];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"forget_04.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    isFirst = YES;
}

#pragma mark -按钮监听事件
-(void)backAction{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    //每次页面显示之后都只加载第一页的数据
    [super viewDidAppear:animated];
//    if (isFirst) {
//        isFirst = NO;
//        [self loadNewData];
//    }
    
   
    //刷新表格
    //[self.tableView reloadData];
    
}

//- (void)viewWillAppear:(BOOL)animated{
//    [_reqListModelArray removeAllObjects];
//    [_dataArray removeAllObjects];
//}

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
    return _reqListModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyServerCell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
        
    }
    if (indexPath.row==0) {
        //cell setBackgroundView:[UIImageView alloc]initWithImage:[UIImage imageNamed:@"]];
    }
    
    ReqListModel *reqListModel=_reqListModelArray[indexPath.row];
    UIImageView *headImage=(UIImageView *)[cell.contentView viewWithTag:1];
    [headImage setImageWithURL:[NSURL URLWithString:reqListModel.PublisherAvatar] placeholderImage:[UIImage imageNamed:@"serverDetail_02.PNG"]];
    
    UILabel *name=(UILabel *)[cell.contentView viewWithTag:2];
    name.text=reqListModel.Title;
    
    UILabel *price=(UILabel *)[cell.contentView viewWithTag:3];
    NSString *priceMut=[NSString stringWithFormat:@"¥ %@ 元",reqListModel.Price];
    price.text=priceMut;
    
    
   
    
    UILabel *address=(UILabel *)[cell.contentView viewWithTag:4];
    if ([reqListModel.ReqCountry isEqualToString:reqListModel.ReqProvince] ) {
        NSString *addressMutable=[NSString stringWithFormat:@" %@",reqListModel.ReqCountry];
        address.text=addressMutable;

    }else{
        if ([reqListModel.ReqProvince isEqualToString:reqListModel.ReqCity]) {
            NSString *addressMutable=[NSString stringWithFormat:@"%@ %@",reqListModel.ReqCountry,reqListModel.ReqProvince];
            address.text=addressMutable;
        }else{
            NSString *addressMutable=[NSString stringWithFormat:@"%@ %@ %@",reqListModel.ReqCountry,reqListModel.ReqProvince,reqListModel.ReqCity];
            address.text=addressMutable;
        }
       
    }
   
    
    //当前竞标人数
    UILabel *peopleCount=(UILabel *)[cell.contentView viewWithTag:5];
    peopleCount.text=reqListModel.Competitors;
    
    UILabel *publisher=(UILabel *)[cell.contentView viewWithTag:6];
    publisher.text=reqListModel.PublisherName;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //把dock隐藏（通知firstControler把dock隐藏）
    //[self.delegate myServerViewControllerNeedtoRemoveDock];
    
    ReqListModel *reqListModel=_reqListModelArray[indexPath.row];
  
    
    DemandDetailController *vc = [[DemandDetailController alloc]init];
    vc.reqID = reqListModel.ReqID;
    vc.PublisherID = reqListModel.PublisherID;
    [self.navigationController pushViewController:vc animated:YES];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.customCell.frame.size.height;
}

#pragma mark -加载网络数据
-(void)loadNetDataWithPageSize:(NSInteger)pageSize PageIndex:(NSInteger)pageIndex{
  
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    //pageSize
    NSString *pageSizeStr=[NSString stringWithFormat:@"%ld",(long)pageSize];
    NSString *enKCountData=[NSData AES256Encrypt:pageSizeStr key:TOKEN];
    
    //pageIndex
    NSString *pageIndexStr=[NSString stringWithFormat:@"%ld",(long)pageIndex];
    NSString *enPageData=[NSData AES256Encrypt:pageIndexStr key:TOKEN];
    
    [dic setObject:enKCountData forKey:@"PageSize"];
    [dic setObject:enPageData forKey:@"PageIndex"];
    
    [ChinaValueInterface GetReqListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray=[[ExplainText alloc]explainManyDataWith:responseObject];
        for (NSDictionary *dic in dataArray) {
            ReqListModel *reqListModel=[[ReqListModel alloc]initWithDic:dic];
            [_reqListModelArray addObject:reqListModel];
            NSLog(@"ReqListModel count is :%ld",_reqListModelArray.count);
        }
        //刷新表格数据
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load data is failure");
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    }];
    
}


#pragma mark -上下拉刷新
-(void)addRefresh{
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
    [self.tableView.legendHeader beginRefreshing];
    

    
}


#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
//    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.data addObject:MJRandomData];
//    }
    if ([_reqListModelArray count]<KpageIndex*KCountData) {
        [self.tableView.footer endRefreshing];
        return;
    }
    KpageIndex=KpageIndex+1;
    
    [self loadNetDataWithPageSize:KCountData PageIndex:KpageIndex];
    
    
    
    
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
    [_dataArray removeAllObjects];
    [_reqListModelArray removeAllObjects];
    
    //加载数据
    [self loadNetDataWithPageSize:KCountData PageIndex:KpageIndex];//每页多少条数据，当前页码
//    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [self.tableView.header endRefreshing];
//    });
}


#pragma mark -UserDataDetail的代理方法
-(void)MyserverViewControllerNeedToAddDock{
    //通知firstView，让firstView去通知HomeController恢复Dock
    [self.delegate myServerViewControllerNeedToRecoverDock];
}



@end
