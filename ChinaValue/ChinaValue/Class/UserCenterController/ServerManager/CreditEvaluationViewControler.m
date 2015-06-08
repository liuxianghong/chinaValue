//
//  CreditEvaluationViewControler.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "CreditEvaluationViewControler.h"
#import "UIBarButtonItem+ZX.h"
#import "UIImageView+WebCache.h"

@interface CreditEvaluationViewControler ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}
@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;

@end

@implementation CreditEvaluationViewControler
{
    UIButton *givenButton;
    UIButton *receivedButton;
    
    NSMutableArray *givenArray;
    NSMutableArray *receiveArray;
    
    NSInteger type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:[NSString stringWithFormat:@"%@的信用评价",self.userName]];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    givenArray = [[NSMutableArray alloc]init];
    receiveArray = [[NSMutableArray alloc]init];
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    //初始化tableView
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]init];
        _tableView.frame=CGRectMake(10, 44,self.view.frame.size.width-20, self.view.frame.size.height-104);
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
    }
    //addTableView
    [self.view addSubview:_tableView];
    
    // 设置tableview的数据源和代理
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //addDOck
    [self addDock];
    
    [self loadDataR];
    [self loadDataG];
}

#pragma mark addDock
-(void)addDock{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44)];
    view.backgroundColor=[UIColor colorWithRed:242/255 green:242/255 blue:242/255 alpha:0.1];
    CGFloat width=150;
    receivedButton=[UIButton buttonWithType:UIButtonTypeCustom];
    receivedButton.frame=CGRectMake(35, 5, width, 35);
    [receivedButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_07.png"] forState:UIControlStateNormal];
    [receivedButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_01.png"] forState:UIControlStateSelected];
    [receivedButton setTitle:@"收到的评价" forState:UIControlStateNormal];
    [receivedButton setTitle:@"收到的评价" forState:UIControlStateSelected];
    receivedButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    [receivedButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
    [receivedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    receivedButton.selected = YES;

    receivedButton.tag = 1;
    [receivedButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:receivedButton];
    
    givenButton=[UIButton buttonWithType:UIButtonTypeCustom];
    givenButton.frame=CGRectMake(35+width, 5, width, 35);
    [givenButton setTitle:@"给出的评价" forState:UIControlStateNormal];
    [givenButton setTitle:@"给出的评价" forState:UIControlStateSelected];
    [givenButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_03.png"] forState:UIControlStateNormal];
    [givenButton setBackgroundImage:[UIImage imageNamed:@"sercerManager_09.png"] forState:UIControlStateSelected];
    givenButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    [givenButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
    [givenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    givenButton.tag =2;
    [givenButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:givenButton];
    
    [self.view addSubview:view];
    
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 1) {
        receivedButton.selected = YES;
        givenButton.selected = NO;
        type = 0;
    }
    else
    {
        receivedButton.selected = NO;
        givenButton.selected =  YES;
        type = 1;
    }
    [_tableView reloadData];
}

-(void)loadDataR
{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.uid key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:@"0" key:TOKEN] forKey:@"Type"];
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    //加载网络数据
    [ChinaValueInterface KnowCreditViewParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray=[responseObject objectForKey:@"ChinaValue"];
        NSLog(@"%@",dataArray);
        for (NSDictionary *dic in dataArray) {
            [receiveArray addObject:dic];
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load data failure");
        //[hud hide:YES];
    }];
}

-(void)loadDataG
{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.uid key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:@"1" key:TOKEN] forKey:@"Type"];
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    //加载网络数据
    [ChinaValueInterface KnowCreditViewParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray=[responseObject objectForKey:@"ChinaValue"];
        NSLog(@"%@",dataArray);
        for (NSDictionary *dic in dataArray) {
            [givenArray addObject:dic];
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load data failure");
        //[hud hide:YES];
    }];
}
#pragma mark barButtonItem的监听事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -实现tableview的协议和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (type==0) {
        return [receiveArray count];
    }
    else
        return [givenArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CreditCell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
    }
    //获取数据源中_person数组中的元素，对应每一个cell
    //通过tag值来获取控件
    UIImageView *star1=(UIImageView *)[cell.contentView viewWithTag:1];
    UIImageView *star2=(UIImageView *)[cell.contentView viewWithTag:2];
    UIImageView *star3=(UIImageView *)[cell.contentView viewWithTag:3];
    UIImageView *star4=(UIImageView *)[cell.contentView viewWithTag:4];
    UIImageView *star5=(UIImageView *)[cell.contentView viewWithTag:5];
    UILabel *days=(UILabel *)[cell.contentView viewWithTag:6];
    UILabel *detailText=(UILabel *)[cell.contentView viewWithTag:7];
    UIImageView *headImage=(UIImageView *)[cell.contentView viewWithTag:8];
    UILabel *userName=(UILabel *)[cell.contentView viewWithTag:9];
    UILabel *workStyle=(UILabel *)[cell.contentView viewWithTag:10];

    NSArray *tableArray = nil;
    if (type==0) {
        tableArray = receiveArray;
    }
    else
    {
        tableArray = givenArray;
    }
    NSDictionary *dic = [tableArray objectAtIndex:indexPath.row];
    days.text = dic[@"AddTime"];
    userName.text = dic[@"UserName"];
    [headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"Avatar"]]];
    detailText.text = dic[@"Content"];
    workStyle.text = dic[@"ReqTitle"];
    
    //再设置
//    [headText setText:@"H5与原生差异化研究"];
//    [statuesText setText:@"已中标"];
//    [numberText setText:@"12312"];
//    [releaseTime setText:@"2013-02-12"];
//    [deadTime setText:@"2014-03-12"];
//    [detail setTitle:@"查看详情" forState:UIControlStateNormal];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.customCell.frame.size.height;
}



@end
