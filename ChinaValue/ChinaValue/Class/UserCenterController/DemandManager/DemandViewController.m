//
//  DemandViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/27.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//  需求管理页面

#import "DemandViewController.h"
#import "UIBarButtonItem+ZX.h"
#import "DemandManagerController.h"
#import "ServerDetailController.h"
#import "DemandCell.h"

@interface DemandViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    DemandManagerController *_demandManagerController;
    UIButton *_button;
    ServerDetailController *_serverDetailController;
}
@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;
@end

@implementation DemandViewController
{
    NSMutableArray *tableArray;
    
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    NSMutableArray *array4;
    
    NSInteger index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //初始化tableView
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]init];
        _tableView.frame=CGRectMake(10, 44,self.view.frame.size.width-20, self.view.frame.size.height-44-64);
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
    }
//    if (_demandManagerController==nil) {
//        _demandManagerController=[[DemandManagerController alloc]init];
//    }
//    
//    if (_serverDetailController==nil) {
//        _serverDetailController=[[ServerDetailController alloc]init];
//    }
    // 设置tableview的数据源和代理
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _tableView.separatorInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    }
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"需求管理"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    //addDock
    [self addDock];
    
    //addTableView
    [self.view addSubview:_tableView];
    
    tableArray = [[NSMutableArray alloc]init];
    array1 = [[NSMutableArray alloc]init];
    array2 = [[NSMutableArray alloc]init];
    array3 = [[NSMutableArray alloc]init];
    array4 = [[NSMutableArray alloc]init];
    [self loadData];

}

-(void)loadData
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:@"10" key:TOKEN] forKey:@"Type"];
    [ChinaValueInterface KnowKsbReqListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"ChinaValue"];
        [array1 addObjectsFromArray:array];
        [tableArray addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    [dic setObject:[NSData AES256Encrypt:@"20" key:TOKEN] forKey:@"Type"];
    [ChinaValueInterface KnowKsbReqListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"ChinaValue"];
        [array2 addObjectsFromArray:array];
        [tableArray addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    [dic setObject:[NSData AES256Encrypt:@"30" key:TOKEN] forKey:@"Type"];
    [ChinaValueInterface KnowKsbReqListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"ChinaValue"];
        [array3 addObjectsFromArray:array];
        [tableArray addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    [dic setObject:[NSData AES256Encrypt:@"99" key:TOKEN] forKey:@"Type"];
    [ChinaValueInterface KnowKsbReqListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"ChinaValue"];
        [array4 addObjectsFromArray:array];
        [tableArray addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
#pragma mark addDock
-(void)addDock{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44)];
    view.backgroundColor=[UIColor colorWithRed:242/255 green:242/255 blue:242/255 alpha:0.1];
    CGFloat width=60;
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(35, 5, width, 35);
    [button1 setBackgroundImage:[UIImage imageNamed:@"sercerManager_07.png"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"sercerManager_01.png"] forState:UIControlStateSelected];
    [button1 setTitle:@"全部" forState:UIControlStateNormal];
    button1.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    button1.tag=0;
    [button1 addTarget:self action:@selector(buttonClickActionWith:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [view addSubview:button1];
    
    NSInteger count=view.subviews.count;
    //默认要选中第5个item
    if(count==1){
        //相当于默认点击了第1个item
        [self buttonClickActionWith:button1];
    }

    
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(35+width, 5, width, 35);
    [button2 setTitle:@"竞标中" forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"sercerManager_02.png"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"sercerManager_05.png"] forState:UIControlStateSelected];
    button2.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    button2.tag=1;
    [button2 addTarget:self action:@selector(buttonClickActionWith:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
     [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [view addSubview:button2];
    
    
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame=CGRectMake(35+width*2, 5, width, 35);
    [button3 setTitle:@"交易中" forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage imageNamed:@"sercerManager_02.png"] forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage imageNamed:@"sercerManager_05.png"] forState:UIControlStateSelected];
    button3.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    button3.tag=2;
    [button3 addTarget:self action:@selector(buttonClickActionWith:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
     [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [view addSubview:button3];
    
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame=CGRectMake(35+width*3, 5, width, 35);
    [button4 setTitle:@"交易完成" forState:UIControlStateNormal];
    [button4 setBackgroundImage:[UIImage imageNamed:@"sercerManager_02.png"] forState:UIControlStateNormal];
    [button4 setBackgroundImage:[UIImage imageNamed:@"sercerManager_05.png"] forState:UIControlStateSelected];
    button4.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    button4.tag=3;
    [button4 addTarget:self action:@selector(buttonClickActionWith:) forControlEvents:UIControlEventTouchUpInside];
    [button4 setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
     [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [view addSubview:button4];
    
    
    UIButton *button5=[UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame=CGRectMake(35+width*4, 5, width, 35);
    [button5 setTitle:@"已过期" forState:UIControlStateNormal];
    [button5 setBackgroundImage:[UIImage imageNamed:@"sercerManager_03.png"] forState:UIControlStateNormal];
    [button5 setBackgroundImage:[UIImage imageNamed:@"sercerManager_09.png"] forState:UIControlStateSelected];
    button5.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    button5.tag=4;
    [button5 addTarget:self action:@selector(buttonClickActionWith:) forControlEvents:UIControlEventTouchUpInside];
    [button5 setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
     [button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [view addSubview:button5];
    
    
    
    
    [self.view addSubview:view];
    
}


#pragma mark barButtonItem的监听事件
-(void)backAction{
   // [self.navigationController popViewControllerAnimated:YES];
    //跳转到指定的controller
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[DemandManagerController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}
#pragma mark -按钮的监听事件
-(void)buttonClickActionWith:(UIButton *)button{
    //取消当前选中
    _button.selected=NO;
    //设置选中
    button.selected=YES;
    _button=button;
    index = button.tag;
    [_tableView reloadData];
    
}

#pragma mark －uitableview的协议方法和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (index) {
        case 0:
            return [tableArray count];
            break;
            
        case 1:
            return [array1 count];
            break;
            
        case 2:
            return [array2 count];
            break;
            
        case 3:
            return [array3 count];
            break;
            
        case 4:
            return [array4 count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemandCell" owner:self options:nil];
    DemandCell *cell2 = nil;
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
        cell2 = self.customCell;
    }
    
    NSLog(@"%@",cell);
    NSDictionary *dic = nil;
    switch (index) {
        case 0:
            dic = [tableArray objectAtIndex:indexPath.row];
            break;
            
        case 1:
            dic = [array1 objectAtIndex:indexPath.row];
            break;
            
        case 2:
            dic = [array2 objectAtIndex:indexPath.row];
            break;
            
        case 3:
            dic = [array3 objectAtIndex:indexPath.row];
            break;
            
        case 4:
            dic = [array4 objectAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    //获取数据源中_person数组中的元素，对应每一个cell
    //通过tag值来获取控件
    UIButton *detail=cell2.button;
    
    //再设置
        [detail setTitle:@"查看详情" forState:UIControlStateNormal];
    //[detail setTitle:dic[@"Status"] forState:UIControlStateNormal];
    [detail addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    detail.tag = indexPath.row;
    cell2.label1.text = dic[@"Title"];
    cell2.label2.text = dic[@"Status"];
    cell2.label3.text = dic[@"ReqID"];
    cell2.label4.text = dic[@"Competitors"];
    cell2.label5.text = dic[@"AddTime"];
    cell2.label6.text = dic[@"EndTime"];

    return cell;
}

#pragma mark 按钮的监听事件
-(void)detailAction:(UIButton *)btn
{
    NSDictionary *dic = nil;
    switch (index) {
        case 0:
            dic = [tableArray objectAtIndex:btn.tag];
            break;
            
        case 1:
            dic = [array1 objectAtIndex:btn.tag];
            break;
            
        case 2:
            dic = [array2 objectAtIndex:btn.tag];
            break;
            
        case 3:
            dic = [array3 objectAtIndex:btn.tag];
            break;
            
        case 4:
            dic = [array4 objectAtIndex:btn.tag];
            break;
            
        default:
            break;
    }

    ServerDetailController *vc = [[ServerDetailController alloc]init];
    vc.dic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.customCell.frame.size.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
