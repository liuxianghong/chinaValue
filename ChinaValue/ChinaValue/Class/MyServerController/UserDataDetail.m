//
//  UserDataDetail.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/13.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "UserDataDetail.h"
#import "UIBarButtonItem+ZX.h"
#import "DataDetailSectionHeader.h"
#import "UIImageView+WebCache.h"
#import "CreditEvaluationViewControler.h"
#import "UserBlogTableViewController.h"
#import "NSString+ZX.h"
#import "MiniBlogTableViewController.h"

@interface UserDataDetail(){
    NSArray *_textArray1;
    NSArray *_accessTextArray1;
    
    NSArray *_textArray2;
    NSArray *_accessTextArray2;
    
    NSArray *_textArray3;
    NSArray *_accessTextArray3;
    
    NSArray *_textArray4;

    NSDictionary *dicKspService;

}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *buttonView;
@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@end

@implementation UserDataDetail

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //初始化array
//    if (_textArray1==nil) {
//        _textArray1=@[@"基本资料",@"邮箱地址",@"手机号",@"微信号",@"座机号",@"QQ号"];
//    }
    if (_textArray2==nil) {
        _textArray2=@[@"职业信息",@"所在地区",@"现工作单位",@"职务",@"工作总年限"];
    }
    if (_textArray3==nil) {
        _textArray3=@[@"服务内容",@"行业类行",@"行业经验",@"个人案列描述"];
    }
    
//    if (_textArray4==nil) {
//        _textArray4=@[@"荣誉/资质/证书",@"详情列表"];
//    }
    
    
    
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"服务方详情"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    [self addView];
    [self loadData2];
    
}

-(void)loadData2
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.uid key:TOKEN] forKey:@"UID"];
    [ChinaValueInterface KspServiceGetParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dicKspService = [responseObject[@"ChinaValue"] firstObject];//dicData
        _accessTextArray2 = @[@"",NoNillString(dicKspService[@"City"]),NoNillString(dicKspService[@"CompanyName"]),NoNillString(dicKspService[@"DutyName"]),NoNillString(dicKspService[@"WorkYear"])];
        _accessTextArray3 = @[@"",NoNillString(dicKspService[@"IndustryName"]),NoNillString(dicKspService[@"IndustryExperience"]),NoNillString([dicKspService[@"PersonalCase"] removeHTML])];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-44);
    self.buttonView.frame = CGRectMake(0, self.view.height-44, self.view.width, 44);
}
#pragma mark barButtonItem的监听事件
-(void)backAction{
    //给MyServerViewController发信息，让homeController把dock加载回来
    [self.delegate MyserverViewControllerNeedToAddDock];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -tableView的协议方法和代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
//        return 6;//基本资料
//    }
    if (section==0) {
        return 5;//职业信息
    }
    if (section==1) {
        return 4;//服务内容
    }
    
    return 2;//荣誉
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
        if (indexPath.row>0) {
            
            [cell.textLabel setTextColor:[UIColor grayColor]];
            [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
            [cell.detailTextLabel setFont:[UIFont systemFontOfSize:15]];
            UILabel *label=cell.detailTextLabel;
            [label setTextAlignment:NSTextAlignmentRight];
            [label setTextColor:[UIColor grayColor]];
            
           }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        cell.textLabel.text=_textArray2[indexPath.row];
        if ([_accessTextArray2 count]>(indexPath.row)) {
            cell.detailTextLabel.text = _accessTextArray2[indexPath.row];
        }
    }else if(indexPath.section==1){
        cell.textLabel.text=_textArray3[indexPath.row];
        if ([_accessTextArray3 count]>(indexPath.row)) {
            cell.detailTextLabel.text = _accessTextArray3[indexPath.row];
        }
        
    }
//    else if(indexPath.section==2){
//        cell.textLabel.text=_textArray3[indexPath.row];
//    }else{
//        cell.textLabel.text=_textArray4[indexPath.row];
//    }
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 125;
    }
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        DataDetailSectionHeader *firstSection=[[DataDetailSectionHeader alloc]init];
//        [firstSection.contentView setBackgroundColor:[UIColor whiteColor]];
        firstSection.name.text=dicKspService[@"UserName"];
        [firstSection.headerView sd_setImageWithURL:[NSURL URLWithString:dicKspService[@"Avatar"]] placeholderImage:[UIImage imageNamed:@"service_unselect.png"]];
         //setImage:[UIImage imageNamed:@"service_unselect.png"]];
        [firstSection.btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
        [firstSection.btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
        [firstSection.btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
        return firstSection;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    [view setBackgroundColor:[UIColor colorWithRed:247.0/255.f green:247.0/255.f blue:247.0/255.f alpha:1]];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"123"];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:15]];
    [cell.detailTextLabel setTextAlignment:NSTextAlignmentRight];
    cell.detailTextLabel.numberOfLines = 0;
    if (indexPath.section==0) {
        cell.textLabel.text=_textArray2[indexPath.row];
        if ([_accessTextArray2 count]>(indexPath.row)) {
            cell.detailTextLabel.text = _accessTextArray2[indexPath.row];
        }
    }else if(indexPath.section==1){
        cell.textLabel.text=_textArray3[indexPath.row];
        if ([_accessTextArray3 count]>(indexPath.row)) {
            cell.detailTextLabel.text = _accessTextArray3[indexPath.row];
        }
        
    }
    [cell layoutSubviews];
    return (cell.detailTextLabel.height+10)>44?(cell.detailTextLabel.height+10):44;
}


- (void)reloadTableData{
    [self.tableView reloadData];
}

-(void)btn1Click
{
    if (self.uid) {
        UIAlertView *aview = [[UIAlertView alloc]initWithTitle:@"请输入邀请留言" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aview.alertViewStyle = UIAlertViewStylePlainTextInput;
        [aview show];
    }
}

-(void)btn2Click
{
    if (self.uid) {
        [self getGUANXI];
    }
}

-(void)btn3Click
{
    if (self.uid) {
        CreditEvaluationViewControler *vc = [[CreditEvaluationViewControler alloc]init];
        vc.uid = self.uid;
        vc.userName = self.userName;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)getGUANXI
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    NSString *reqID=self.uid;
    
    NSString *enReqID=[NSData AES256Encrypt:reqID key:TOKEN];
    
    NSString *uid=[UserModel sharedManager].userID;
    
    NSString *enUID=[NSData AES256Encrypt:uid key:TOKEN];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:enReqID forKey:@"ToUID"];
    [dic setObject:enUID forKey:@"FromUID"];
    [ChinaValueInterface UserGetConnectionParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = dic[@"Name"];
        [HUD hide:YES afterDelay:1.5f];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = error.domain;
        [HUD hide:YES afterDelay:1.5f];
    }];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *tf = [alertView textFieldAtIndex:0];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"FromUID"];
        [dic setObject:[NSData AES256Encrypt:self.uid key:TOKEN] forKey:@"ToUID"];
        [dic setObject:[NSData AES256Encrypt:tf.text key:TOKEN] forKey:@"Content"];
        [ChinaValueInterface KnowKnowKsbInviteParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];//dicData
            hud.detailsLabelText = dic[@"Msg"];
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.5f];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            hud.detailsLabelText = error.domain;
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.5f];
        }];
    }
}

-(void)addView
{
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-44);
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //去掉没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    //隐藏title的滚动条
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    self.buttonView = [[UIView alloc]init];
    self.buttonView.backgroundColor = self.tableView.backgroundColor;
    self.buttonView.frame = CGRectMake(0, self.view.height-44, self.view.width, 44);
    [self.view addSubview:self.buttonView];
    UIButton *askedbiddButton=[UIButton buttonWithType:UIButtonTypeCustom];//40
    CGFloat width=(self.view.frame.size.width-40)/2;
    CGFloat Y = 2;
    CGFloat H = 35;
    askedbiddButton.frame=CGRectMake(15, Y+2, width, H);
    [askedbiddButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
    [askedbiddButton setTitle:[NSString stringWithFormat:@"%@的日志",self.userName] forState:UIControlStateNormal];
    [askedbiddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [askedbiddButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.buttonView addSubview:askedbiddButton];
    [askedbiddButton addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
    
    //我和他的关系
    UIButton *relationButton=[UIButton buttonWithType:UIButtonTypeCustom];
    relationButton.frame=CGRectMake(width+20, Y+2, width, H);
    [relationButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
    [relationButton setTitle:[NSString stringWithFormat:@"%@的微媒体",self.userName] forState:UIControlStateNormal];
    [relationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [relationButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [relationButton addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview: relationButton];
}

-(void)button1Click
{
    if (self.uid) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UserBlogTableViewController* vc = (UserBlogTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"userBlog"];
        vc.uid = self.uid;
        vc.uName = self.userName;
        //来到资料修改页面
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)button2Click
{
    if (self.uid) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        MiniBlogTableViewController* vc = (MiniBlogTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MiniBlog"];
        vc.uid = self.uid;
        vc.uName = self.userName;
        //来到资料修改页面
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
