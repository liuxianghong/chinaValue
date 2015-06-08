//
//  PersonalDetailController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//  我的资料页面


#import "PersonalDetailController.h"
#import "UIBarButtonItem+ZX.h"
#import "UpdateInformationController.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "PDTableViewCell.h"
#import "EditeInformationTableViewController.h"

@interface PersonalDetailController (){
    NSArray *_textArray;
    NSArray *_accessoryArray;
    UpdateInformationController *_updateInformationController;
    
    UIImageView *imageView;

}

@end

@implementation PersonalDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    if (_updateInformationController==nil) {
//        _updateInformationController=[[UpdateInformationController alloc]init];
//    }
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //去掉没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    


    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"我的资料"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(leftBackAction)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithRightIcon:@"personcal_detail.png" highLight:nil target:self action:@selector(rightButtonAction)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    imageView.layer.cornerRadius = 20;//imageView.height/2;
    imageView.layer.borderWidth = 0;
    imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    imageView.layer.masksToBounds = YES;
    
    
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
    
    //加密
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
    NSString *idEN=[NSData AES256Encrypt:userID key:TOKEN];
    [dictionary setValue:idEN forKey:@"UID"];
    //加载用户基本信息
    [ChinaValueInterface GetUserBasicInfoParameters:dictionary  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic=[ExplainText explainDataWith:responseObject];
        NSLog(@"用户基本信息:%@",dic);
        //  BasicUserInformation *userInfo=[[BasicUserInformation alloc]initWithDic:dic];
        [UserModel sharedManager].basicUserInformation=[[BasicUserInformation alloc]initWithDic:dic];
        
        NSLog(@"userInfo is :%@",[UserModel sharedManager].basicUserInformation.userName);
        
        //[self.view addSubview:_homeVC.view];
        if (_textArray==nil) {
            //        _textArray=@[@"Ray",@"性别:",@"工作单位:",@"职务:",@"现居:",@"个人账户中的余额后面的提现功能去掉，支出明细应为［收支]明细，明细列表无需显示姓名，因为就是当前用户，只显示交易时间，交易项目，金额，交易类"];
            _textArray=@[[UserModel sharedManager].basicUserInformation.userName,@"性别:",@"工作单位:",@"职务:",@"现居:",[UserModel sharedManager].basicUserInformation.About];
        }
        //if (_accessoryArray==nil)
        {
            //        _accessoryArray=@[@"男",@"深圳腾沐科技有限公司",@"UI设计",@"深圳 罗湖"];
            _accessoryArray=@[[UserModel sharedManager].basicUserInformation.Sex,[UserModel sharedManager].basicUserInformation.CompanyName,[UserModel sharedManager].basicUserInformation.DutyName,[UserModel sharedManager].basicUserInformation.City];
        }
        [self.tableView reloadData];
        imageView.layer.cornerRadius = 20;//imageView.height/2;
        imageView.layer.borderWidth = 0;
        imageView.layer.borderColor = [[UIColor grayColor] CGColor];
        imageView.layer.masksToBounds = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load data is failure");
    }];
}

#pragma mark barButtonItem的监听事件
-(void)leftBackAction{
    [self.delegate personnalDetailNeedToAddDock];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonAction{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EditeInformationTableViewController* vc = (EditeInformationTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"EditeInformation"];
    //来到资料修改页面
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _textArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    PDTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[PDTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cell.textLabel setNumberOfLines:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text=_textArray[indexPath.row];
    if(indexPath.row==0){
        //加载网络图片
        [cell.imageView setImageWithURL:[NSURL URLWithString:[UserModel sharedManager].basicUserInformation.Avatar] placeholderImage:[UIImage imageNamed:@"credit_05.png"]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }

    if (indexPath.row==1) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        label.text=_accessoryArray[indexPath.row-1];
        label.font=[UIFont systemFontOfSize:13.0];
          label.textAlignment=NSTextAlignmentRight;
        cell.accessoryView=label;
    }
    if (indexPath.row==2) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        label.text=_accessoryArray[indexPath.row-1];
        label.font=[UIFont systemFontOfSize:13.0];
        label.textAlignment=NSTextAlignmentRight;
        cell.accessoryView=label;
    }
    if (indexPath.row==3) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        label.text=_accessoryArray[indexPath.row-1];
        label.font=[UIFont systemFontOfSize:13.0];
          label.textAlignment=NSTextAlignmentRight;
        cell.accessoryView=label;
    }
    if (indexPath.row==4) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        label.text=_accessoryArray[indexPath.row-1];
        label.font=[UIFont systemFontOfSize:13.0];
          label.textAlignment=NSTextAlignmentRight;
        cell.accessoryView=label;
    }
       return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return  88;
    }
    if (indexPath.row==5) {
        return 132;

    }
    return 44;
   }

@end
