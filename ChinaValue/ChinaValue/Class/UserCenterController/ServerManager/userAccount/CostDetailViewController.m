//
//  CostDetailViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/30.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "CostDetailViewController.h"
#import "UIBarButtonItem+ZX.h"
#import "CostDetailHeader.h"
#import "CostDetailCell.h"
#import "UserModel.h"
#import "CostDetailHeader.h"

@interface CostDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    UIButton *_button;
    //NSMutableArray *_headerList;
    NSMutableArray *modelArray;
    //CostDetailHeader *_costDetailHeader;
    
    NSMutableArray *allArray;
    NSMutableArray *oneArray;
    NSMutableArray *twoArray;
    
    NSInteger index;
   
}
@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;


@end

@implementation CostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //初始化tableView
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]init];
        _tableView.frame=CGRectMake(0, 44,self.view.frame.size.width, self.view.frame.size.height-114);
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
        //设置section的高
        [_tableView setSectionHeaderHeight:64];
    }
    // 设置tableview的数据源和代理
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _tableView.separatorInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    }
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"收支明细"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
//    
//    if (_modelList==nil) {
//        _modelList=[[NSMutableArray alloc]init];
//    }
//    if (_costDetailHeader==nil) {
//        _costDetailHeader=[[CostDetailHeader alloc]init];
//    }
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
//    //初始化_headerList
//    if (_headerList==nil) {
//        _headerList=[[NSMutableArray alloc]init];
//    }
    
//    for (NSInteger i=0; i<2; i++) {
//        CostDetailHeader *header=[[CostDetailHeader alloc]init];
//        header.name.text=@"hello";
//        header.date.text=@"2014/2/2";
//        header.price.text=@"123";
//        [header.imageView setImage:[UIImage imageNamed:@"02.png"]];
//        [_headerList addObject:header];
//    }

    
    [self addDock];
    [self.view addSubview:_tableView];
    
    [self reloadTradeLog];
}


#pragma mark barButtonItem的监听事件
-(void)backAction{
     [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark addView实现对View的点击监听
-(void)addView{
    UIView *buttonView=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,64)];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickActionDo)];
    
    [buttonView addGestureRecognizer:tapGesture];
}
//buttonView的事件监听
-(void)clickActionDo{
    NSLog(@"button view is function");
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
    [bidButton setTitle:@"收入金额" forState:UIControlStateNormal];
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
    [haveButton setTitle:@"支出金额" forState:UIControlStateNormal];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -顶部dock栏按钮的监听事件
-(void)buttonClickActionWith:(UIButton *)button{
    
    
    index = button.tag;
    //取消当前选中
    _button.selected=NO;
    //设置选中
    button.selected=YES;
    _button=button;
    
    if (index==0) {
        modelArray = allArray;
    }
    else if (index==1) {
        modelArray = oneArray;
    }
    else if (index==2) {
        modelArray = twoArray;
    }
    [_tableView reloadData];
}







#pragma mark -tableView的代理方法和协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [modelArray count];;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //CostDetailHeader *header=_headerList[section];
    TradeLogModel *model = [modelArray objectAtIndex:section];
    if (model.extend) {
        return 1;
    }else{
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CostDetailCell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
    }
    TradeLogModel *model = [modelArray objectAtIndex:indexPath.section];
    UILabel *transformName=(UILabel *)[cell.contentView viewWithTag:1];
    transformName.text=model.ReqTitle;
    
    UILabel *date=(UILabel *)[cell.contentView viewWithTag:2];
    date.text=model.DateTime;
    
    UILabel *transformType=(UILabel *)[cell.contentView viewWithTag:3];
    transformType.text=model.TypeName;
    
    UILabel *transformFee=(UILabel *)[cell.contentView viewWithTag:4];
    transformFee.text=model.Fee;

    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CostDetailHeader *header=[[CostDetailHeader alloc]init];
    // header.name.text=[UserModel sharedManager].basicUserInformation.userName;
    TradeLogModel *model = [modelArray objectAtIndex:section];
    header.date.text=model.DateTime;
    NSString *price=[NSString stringWithFormat:@"¥ %@",model.Fee];
    header.price.text=price;
    header.frame=CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 64);
    header.tag=section;

    //添加对header的监听
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerCilckAction:)];
    [header addGestureRecognizer:tapGesture];
    
    if (!model.extend) {
        [header.imageView setImage:[UIImage imageNamed:@"sectionClick_02"]];
    }else{
        [header.imageView setImage:[UIImage imageNamed:@"sectionClick_01"]];
    }
    return header;
    
}

#pragma mark header的点击事件监听
-(void)headerCilckAction:(UITapGestureRecognizer *)gesture{
    CostDetailHeader *header=(CostDetailHeader*)gesture.view;
    TradeLogModel *model = [modelArray objectAtIndex:header.tag];
    NSLog(@"button is click%ld",header.tag);
    model.extend = !model.extend;
    if (!model.extend) {
        [header.imageView setImage:[UIImage imageNamed:@"sectionClick_02"]];
    }else{
        [header.imageView setImage:[UIImage imageNamed:@"sectionClick_01"]];
    }
    NSLog(@"头部headerView%ld被点击了",header.tag);
    
    //刷新
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:header.tag] withRowAnimation:UITableViewRowAnimationFade];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.customCell.frame.size.height;
}


#pragma mark -加载收支详情数据
-(void)reloadTradeLog{
    //先获取全部的，包括收入和支出
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    //UID
    NSString *enID=[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN];
    //type 不传时是全部的
    [dic setObject:enID forKey:@"UID"];
    
    [ChinaValueInterface GetTradeLogParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);//ChinaValue
        NSArray *array = responseObject[@"ChinaValue"];
        
        //_headerList=[[NSMutableArray alloc]init];
        //modelArray = [[NSMutableArray alloc]init];
        allArray = [[NSMutableArray alloc]init];
        oneArray = [[NSMutableArray alloc]init];
        twoArray = [[NSMutableArray alloc]init];
        // NSLog(@"传递过来的值是：%@",self.tradeLogModel.DateTime);
        for (NSDictionary *dic in array) {
            TradeLogModel *model = [[TradeLogModel alloc]initWitDic:dic];
            [allArray addObject:model];
            if ([model.Type integerValue]==0) {
                [oneArray addObject:model];
            }
            else
            {
                [twoArray addObject:model];
            }
            //CostDetailHeader *header=[[CostDetailHeader alloc]init];
            // header.name.text=[UserModel sharedManager].basicUserInformation.userName;
            //header.date.text=model.DateTime;
            //NSString *price=[NSString stringWithFormat:@"¥ %@",model.Fee];
            //header.price.text=price;
            
            //header的折叠图标
            //[header.imageView setImage:[UIImage imageNamed:@"sectionClick_02"]];
            //_costDetailHeader=header;
            
            //[_headerList addObject:header];
        }
        if (index==0) {
            modelArray = allArray;
        }
        else if (index==1) {
            modelArray = oneArray;
        }
        else if (index==2) {
            modelArray = twoArray;
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get the TradeLog is failure");
    }];
}
@end
