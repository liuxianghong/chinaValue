//
//  MyServerDataDetailController;.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/15.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
//   我的服务资料 页面

#import "MyServerDataDetailController.h"
#import "UIBarButtonItem+ZX.h"
#import "UpdateInformationController.h"
#import "MBProgressHUD.h"
#import "NSString+ZX.h"
#import "ServerEditeTableViewController.h"

@interface MyServerDataDetailController()<UITextViewDelegate,UpdateInformationControllerDelegate,MBProgressHUDDelegate>{
    UpdateInformationController *_updateInformationController;
    NSArray *_textArray1;
    NSArray *_textArray2;
    MBProgressHUD *DialogHUD;
    
    NSArray *_detailArray1;
    NSArray *_detailArray2;
    
    NSDictionary *dicMy;
}

@end

@implementation MyServerDataDetailController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //初始化控件
    if (_updateInformationController==nil) {
        _updateInformationController=[[UpdateInformationController alloc]init];
        _updateInformationController.delegate=self;
    }
    
    if (_textArray1==nil) {
        _textArray1=@[@"邮箱地址:",@"手机号码:",@"微信号:",@"QQ:",@"其他联系方式:"];
    }
    if (_textArray2==nil) {
        _textArray2=@[@"所在地区",@"行业类型",@"服务类型",@"服务领域关键字",@"现工作单位:",@"职务:",@"工作年限:",@"行业经验:",@"个人案列描述:",@"专业服务描述:"];
    }
    
    
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //去掉没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    
    
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:[NSString stringWithFormat:@"%@的服务资料",self.userName?self.userName:@""]];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(leftBackAction)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    
    if ([self.userName isEqualToString:@"我"]) {
        UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithRightIcon:@"personcal_detail.png" highLight:nil target:self action:@selector(rightButtonAction)];
        self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData1];
    if(self.type!=2)
        [self loadData2];
}
/*
if (_textArray1==nil) {
    _textArray1=@[@"邮箱地址:",@"手机号码:",@"微信号:",@"QQ:",@"其他联系方式:"];
}
if (_textArray2==nil) {
    _textArray2=@[@"所在地区",@"行业类型",@"服务类型",@"服务领域关键字",@"现工作单位:",@"职务:",@"工作年限:",@"行业经验:",@"个人案列描述:",@"专业服务描述:"];
}
 */
-(void)loadData1
{
    if(!self.uid)
        return;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.uid key:TOKEN] forKey:@"UID"];
    [ChinaValueInterface GeContactPatameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData
        _detailArray1 = @[dic[@"Email"],dic[@"Mobile"],dic[@"Wechat"],dic[@"QQ"],dic[@"Other"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)loadData2
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.uid key:TOKEN] forKey:@"UID"];
    [ChinaValueInterface KspServiceGetParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData
        dicMy = dic;
         _detailArray2 = @[NoNillString(dic[@"City"]),NoNillString(dic[@"IndustryName"]),NoNillString(dic[@"FunctionName"]),NoNillString(dic[@"FunctionKeyword"]),NoNillString(dic[@"CompanyName"]),NoNillString(dic[@"DutyName"]),NoNillString(dic[@"WorkYear"]),NoNillString(dic[@"IndustryExperience"]),NoNillString(dic[@"ServiceDesc"]),NoNillString(dic[@"PersonalCase"])];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark barButtonItem的监听事件
-(void)leftBackAction{
   // [self.delegate personnalDetailNeedToAddDock];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonAction{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ServerEditeTableViewController* vc = (ServerEditeTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"severEditeVC"];
    vc.dic = dicMy;
    //来到资料修改页面
    [self.navigationController pushViewController:vc animated:YES];//_updateInformationController
}


#pragma mark -tableView的数据源方法和代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.type==2) {
        return 1;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }
    return  10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.0]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    if (indexPath.section==0) {
        cell.textLabel.text=_textArray1[indexPath.row];
    }else{
        cell.textLabel.text=_textArray2[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 设置accessoryView
    UILabel *label= cell.detailTextLabel;
    label.numberOfLines = 0;
    [label setFont:[UIFont systemFontOfSize:13.0]];
    [label setTextColor:[UIColor grayColor]];
    if (indexPath.section==1) {
//        if (indexPath.row>7) {
//            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 50)];
//            [label setFont:[UIFont systemFontOfSize:13.0f]];
//            [label setTextColor:[UIColor grayColor]];
//            [label setTextAlignment:NSTextAlignmentRight];
//            if (indexPath.row==8) {
//                label.text=self.kspServerGerModel.PersonalCase;
//            }
//            if (indexPath.row==9) {
//                label.text=self.kspServerGerModel.ServiceDesc;
//            }
//            cell.accessoryView=label;
//        }else{
//            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 44)];
//            [label setFont:[UIFont systemFontOfSize:13.0f]];
//            [label setTextColor:[UIColor grayColor]];
//            [label setTextAlignment:NSTextAlignmentRight];
//            if (indexPath.row==0) {
//                label.text=self.kspServerGerModel.Province;
//            }else if (indexPath.row==1){
//                label.text=self.kspServerGerModel.INdustryName;
//            }else if(indexPath.row==2){
//                label.text=self.kspServerGerModel.FunctionName;
//            }else if (indexPath.row==3){
//                label.text=self.kspServerGerModel.FunctionKeyword;
//            }else if(indexPath.row==4){
//                label.text=self.kspServerGerModel.CompanyName;
//            }else if(indexPath.row==5){
//                label.text=self.kspServerGerModel.DutyName;
//            }else if(indexPath.row==6){
//                label.text=[NSString stringWithFormat:@"%@ 年",self.kspServerGerModel.WorkYear];
//            }else{
//                label.text=[NSString stringWithFormat:@"%@ 年",self.kspServerGerModel.IndustryExperience];
//            }
//            cell.accessoryView=label;
//        }
        if ([_detailArray2 count]>(indexPath.row)) {
            label.text = _detailArray2[indexPath.row];
        }
        
    }
    if (indexPath.section==0) {
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 44)];
//        [label setFont:[UIFont systemFontOfSize:13.0f]];
//        [label setTextColor:[UIColor grayColor]];
//        [label setTextAlignment:NSTextAlignmentRight];
//        if (indexPath.row==0) {
//            label.text=self.getContactModel.Email;
//        }else if(indexPath.row==1){
//            label.text=self.getContactModel.Mobile;
//        }else if(indexPath.row==2){
//            label.text=self.getContactModel.WeChat;
//        }else if(indexPath.row==3){
//            label.text=self.getContactModel.QQ;
//        }else if(indexPath.row==4){
//            label.text=self.getContactModel.Other;
//        }
//        
//        cell.accessoryView=label;
        if ([_detailArray1 count]>(indexPath.row)) {
            label.text = _detailArray1[indexPath.row];
        }
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tableView.frame.size.width, 44)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 150, 44)];
    [view setBackgroundColor:[UIColor colorWithRed:217.0/255.f green:217.0/255.f blue:217.0/255.f alpha:1]];
    label.font=[UIFont systemFontOfSize:13.0f];
    if (section==0) {
        label.text=@"联系方式";
    }else{
        label.text=@"服务内容";
    }
    [view addSubview:label];
    
    return view;
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"123"];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.0]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    if (indexPath.section==0) {
        cell.textLabel.text=_textArray1[indexPath.row];
    }else{
        cell.textLabel.text=_textArray2[indexPath.row];
    }
    
    // 设置accessoryView
    UILabel *label= cell.detailTextLabel;
    label.numberOfLines = 0;
    [label setFont:[UIFont systemFontOfSize:13.0]];
    
    
    if (indexPath.section==1) {
        if ([_detailArray2 count]>(indexPath.row)) {
            label.text = _detailArray2[indexPath.row];
        }
        
    }
    if (indexPath.section==0) {
        if ([_detailArray1 count]>(indexPath.row)) {
            label.text = _detailArray1[indexPath.row];
        }
    }
    [cell layoutSubviews];
    return (label.height+10)>44?(label.height+10):44;
//    if (indexPath.section==1) {
//        if (indexPath.row>7) {
//            return 88;
//        }
//    }
//    return 44;
}



#pragma mark -UpdateInformationController的代理方法
-(void)deliverThisdataToMySerVerDetail:(KspServiceEditModel *)kspServerEditMode{
    [self showTextDialogWith:kspServerEditMode.Result];
    NSLog( @" let me see this is what:@%",kspServerEditMode.Result);
    [self.tableView reloadData];
    
}


#pragma mark -MBProcessHUD
//出现几秒然后消失
-(void)showTextDialogWith:(NSString *)text{
    DialogHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:DialogHUD];
    DialogHUD.labelText = text;
    DialogHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的位置，不指定则在屏幕中间显示
    DialogHUD.yOffset = self.view.frame.size.height/3;
    DialogHUD.xOffset = 0.0f;
    
    
    
    
    [DialogHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [DialogHUD removeFromSuperview];
        DialogHUD = nil;
    }];
}





@end
