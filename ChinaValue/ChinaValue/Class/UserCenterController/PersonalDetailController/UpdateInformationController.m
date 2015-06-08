//
//  UpdateInformationController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//  修改资料页面
//

#import "UpdateInformationController.h"
#import "UIBarButtonItem+ZX.h"
#import "ServerMethodController.h"
#import "SelectViewController.h"

#import "ExplainText.h"
#import "ChinaValueInterface.h"
#import "GetKspListModel.h"
#import "UIImageView+WebCache.h"
#import "NSData+ZXAES.h"
#import "MBProgressHUD.h"
#import "KspReqListModel.h"
#import "UserModel.h"
#import "MyServerDataDetailController.h"
#import "KspServiceGetModel.h"
#import "KspServiceEditModel.h"



#define TOKEN @"chinavaluetoken=abcdefgh01234567"


@interface UpdateInformationController ()<UITextFieldDelegate,SelectViewDelegate,ServerMethodControllerDelegate>{
    NSArray *_sectionTextArray;
    NSArray *_textArray1;
    NSArray *_textArray2;
    NSArray *_textArray3;
    
    NSMutableDictionary *_textFieldDic1; //用来保存section1种textfield里面的填写内容
    NSMutableDictionary *_textFieldDic2;  //用来保存section2种textfield里面的填写内容
    
    UILabel *_serverMethodLabel;
    UILabel *_serverCategoryLabel;
    UILabel *_addressLabel;//所在地区
    NSString *_str;
    NSString *_method;//服务方式
    
    ServerMethodController *_serverMethodController;
    SelectViewController *_selectViewController;
    
}
@property(nonatomic,strong)NSString *Email;
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,strong)NSString *Wechat;
@property(nonatomic,strong)NSString *QQ;
@property(nonatomic,strong)NSString *Other;
@property(nonatomic,strong)NSString *Address;
@property(nonatomic,strong)NSString *CategoryType;  //行业类型
@property(nonatomic,strong)NSString *ServerType;
@property(nonatomic,strong)NSString *ServerAreaKey;//服务领域关键词
@property(nonatomic,strong)NSString *CompanyName;
@property(nonatomic,strong)NSString *workType;// 职务
@property(nonatomic,strong)NSString *workYears;
@property(nonatomic,strong)NSString *workExperience;
@property(nonatomic,strong)NSString *personWorkDesc;//个人案例描述
@property(nonatomic,strong)NSString *serverDesc;//专业服务描述
@end

@implementation UpdateInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"修改资料"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    //初始化数组
    if (_sectionTextArray==nil) {
        _sectionTextArray=@[@"联系方式",@"服务内容"];
    }
    if (_textArray1==nil) {
        _textArray1=@[@"邮箱地址:",@"手机号码:",@"微信号:",@"QQ:",@"其他联系方式:"];
    }
    if (_textArray2==nil) {
        _textArray2=@[@"所在地区:",@"行业类型:",@"服务类型:",@"服务领域关键词:",@"现工作单位:",@"职务:",@"工作年限:",@"行业经验:",@"个人案例描述:",@"专业服务描述:"];
    }
    
    if (_textFieldDic1==nil) {
        _textFieldDic1=[[NSMutableDictionary alloc]init];
    }
    if (_textFieldDic2==nil) {
        _textFieldDic2=[[NSMutableDictionary alloc]init];
    }
    
    if (_serverMethodController==nil) {
        _serverMethodController=[[ServerMethodController alloc]init];
        _serverMethodController.delegate=self;
    }
    if (_selectViewController==nil) {
        _selectViewController=[[SelectViewController alloc]init];
        _selectViewController.delegate=self;
    }

    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction)];                                   //initWithText:@"确定" target:self action:@selector(rightButtonAction)];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
    
    //去掉底部没有内容的多余的表格
    self.tableView.tableFooterView=[[UIView alloc]init];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark barButtonItem的监听事件
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//确定按钮
-(void)rightButtonAction{
    //提交填写的数据
    [self putUserData];
    //先处理填写的信息，然后再pop
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 5;
    }
  
    return 10;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.section==0) {
        cell.textLabel.text=_textArray1[indexPath.row];
    }
    if (indexPath.section==1) {
        cell.textLabel.text=_textArray2[indexPath.row];
    }
    
    
    //section1
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = YES;
    textField.tag =indexPath.row;
    textField.delegate = self;
    textField.font=[UIFont systemFontOfSize:13.0f];
    [textField setTextAlignment:NSTextAlignmentRight];
    [textField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingDidEnd];
    
    //section2
    UITextField *textField1=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField1.returnKeyType = UIReturnKeyDone;
    textField1.clearButtonMode = YES;
    textField1.tag =indexPath.row;
    textField1.delegate = self;
    textField1.font=[UIFont systemFontOfSize:13.0f];
    [textField1 setTextAlignment:NSTextAlignmentRight];
    [textField1 addTarget:self action:@selector(textFieldWithSection:) forControlEvents:UIControlEventEditingDidEnd];
    
    
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, 10, 250, 68)];
    
    if (indexPath.section==0) {
        cell.textLabel.text=_textArray1[indexPath.row];
        textField.placeholder=@"点击编辑";
        
        if (indexPath.row==0) {
            NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            [textField setText:[_textFieldDic1 objectForKey:key]];
            
        }else if (indexPath.row==1) {
            NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            [textField setText:[_textFieldDic1 objectForKey:key]];
            
        }else if(indexPath.row==2){
            NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            [textField setText:[_textFieldDic1 objectForKey:key]];
            
        }else if (indexPath.row==3){
            NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            [textField setText:[_textFieldDic1 objectForKey:key]];
            
        }else if (indexPath.row==4){
            NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            [textField setText:[_textFieldDic1 objectForKey:key]];
            
        }
        cell.accessoryView=textField;
    }
    if (indexPath.section==1) {
        cell.textLabel.text=_textArray2[indexPath.row];
        
        
        textField1.placeholder=@"点击编辑";
        if (indexPath.row>2) {
            cell.accessoryView=textField1;
             if (indexPath.row==3) {
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];
                
                
            }else if(indexPath.row==4){
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];
                
                
            }else if (indexPath.row==5){
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];
                
            }else if (indexPath.row==6){
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];
                
                
            }else if (indexPath.row==7){
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];
                
            }else if (indexPath.row==8){
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];
                
            }else if (indexPath.row==9){
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];
                
            }
        }else if (indexPath.row==1){//行业类型
            UILabel *serverCategoryLabel=[[UILabel alloc]init];
            serverCategoryLabel=[[UILabel alloc]init];
            serverCategoryLabel.frame=CGRectMake(cell.frame.size.width/2-30, 0, 180, 44);
            [serverCategoryLabel setTextAlignment:NSTextAlignmentRight];
            [serverCategoryLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [serverCategoryLabel setTextColor:[UIColor grayColor]];
           
            [serverCategoryLabel setText:_str];
            [cell addSubview:serverCategoryLabel];
           // _serverCategoryLabel=serverCategoryLabel;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
           
        }else if (indexPath.row==0){   //服务地址
            UILabel *addressLabel=[[UILabel alloc]init];
            addressLabel=[[UILabel alloc]init];
            addressLabel.frame=CGRectMake(cell.frame.size.width/2-30, 0, 180, 44);
            [addressLabel setTextAlignment:NSTextAlignmentRight];
            [addressLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [addressLabel setTextColor:[UIColor grayColor]];
            [cell addSubview:addressLabel];
            addressLabel.text=@"深圳";
            _addressLabel=addressLabel;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
           // cell.accessoryView=_addressLabel;
            
        }else if(indexPath.row==2){//服务类型
            
            UILabel *serverMethodLabel=[[UILabel alloc]init];
            
            serverMethodLabel=[[UILabel alloc]init];
            serverMethodLabel.frame=CGRectMake(cell.frame.size.width/2-30, 0, 180, 44);
            [serverMethodLabel setTextAlignment:NSTextAlignmentRight];
            [serverMethodLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [serverMethodLabel setTextColor:[UIColor grayColor]];
            
           // serverMethodLabel.text=_method;
            [cell addSubview:serverMethodLabel];
            _serverMethodLabel=serverMethodLabel;
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==1) {
            [self.navigationController pushViewController:_selectViewController animated:YES];
        }
        if (indexPath.row==2) {
            [self.navigationController pushViewController:_serverMethodController animated:YES];
        }
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row>7) {
            return 88;
        }
    }
    return 44;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return _sectionTextArray[section];
//}

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


#pragma mark -selectViewcontroller的代理方法
- (void)selectWithDic:(NSMutableDictionary *)dic{
    for (NSString *text in [dic allKeys]) {
        _str=[NSString stringWithFormat:@"%@等%ld个行业",text,[dic count]];
    }
    [self.tableView reloadData];
}

#pragma mark -ServerMethodController 的协议代理方法
-(void)deliverThisSelectMethodWith:(NSArray *)array{
    _serverMethodLabel.text=array[0];
    [self.tableView reloadData];
}





#pragma mark -textField的监听方法
- (void)textFieldWithText:(UITextField *)textField
{
    NSString *key=[NSString stringWithFormat:@"%ld",(long)textField.tag];
    switch (textField.tag) {
        case 0:
            self.Email=textField.text;
            [_textFieldDic1 setObject:self.Email forKey:key];
            [self.tableView reloadData];
            break;
        case 1:
            self.Mobile=textField.text;
            [_textFieldDic1 setObject:self.Mobile forKey:key];
            [self.tableView reloadData];
            break;
        case 2:
            self.Wechat=textField.text;
            [_textFieldDic1 setObject:self.Wechat forKey:key];
            
            [self.tableView reloadData];
            break;
        case 3:
            self.QQ=textField.text;
            [_textFieldDic1 setObject:self.QQ forKey:key];
            
            [self.tableView reloadData];
            break;
        case 4:
            self.Other=textField.text;
            [_textFieldDic1 setObject:self.Other forKey:key];
            
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

-(void)textFieldWithSection:(UITextField *)textField{
    NSString *key=[NSString stringWithFormat:@"%ld",(long)textField.tag];
    switch (textField.tag) {
        case 3:
            self.ServerAreaKey=textField.text;
            [_textFieldDic2 setObject:self.ServerAreaKey forKey:key];
            [self.tableView reloadData];
            break;
        case 4:
            self.CompanyName=textField.text;
            [_textFieldDic2 setObject:self.CompanyName forKey:key];
            [self.tableView reloadData];
            break;
        case 5:
            self.workType=textField.text;
            [_textFieldDic2 setObject:self.workType forKey:key];
            [self.tableView reloadData];
            break;
        case 6:
            self.workYears=textField.text;
            [_textFieldDic2 setObject:self.workYears forKey:key];
            [self.tableView reloadData];
            break;
        case 7:
            self.workExperience=textField.text;
            [_textFieldDic2 setObject:self.workExperience forKey:key];
            [self.tableView reloadData];
            break;
        case 8:
            self.personWorkDesc=textField.text;
            [_textFieldDic2 setObject:self.personWorkDesc forKey:key];
            [self.tableView reloadData];
            break;
        case 9:
            self.serverDesc=textField.text;
            [_textFieldDic2 setObject:self.serverDesc forKey:key];
            [self.tableView reloadData];
            break;
        default:
        break;
    }
    
}


#pragma mark -提交填写的数据
-(void)putUserData{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *enUID=[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN];
    NSString *enIndustryExperience=[NSData AES256Encrypt:self.workExperience key:TOKEN];
    NSString *enServiceDesc=[NSData AES256Encrypt:self.serverDesc key:TOKEN];
    NSString *enPersonalCase=[NSData AES256Encrypt:self.personWorkDesc key:TOKEN];
    NSString *enFunctionKeyWord=[NSData AES256Encrypt:self.ServerAreaKey key:TOKEN];
    NSString *enWorkYear=[NSData AES256Encrypt:self.workYears key:TOKEN];
    NSString *enLocationID=[NSData AES256Encrypt:self.Address key:TOKEN];
    NSString *enIndustry=[NSData AES256Encrypt:self.CategoryType key:TOKEN];
    NSString *enFunction=[NSData AES256Encrypt:self.ServerType key:TOKEN];
    NSString *enCompanyName=[NSData AES256Encrypt:self.CompanyName key:TOKEN];
    NSString *enDutyName=[NSData AES256Encrypt:self.workType key:TOKEN];
    NSString *enEmail=[NSData AES256Encrypt:self.Email key:TOKEN];
    NSString *enMobile=[NSData AES256Encrypt:self.Mobile key:TOKEN];
    NSString *enWechat=[NSData AES256Encrypt:self.Wechat key:TOKEN];
    NSString *enQQ=[NSData AES256Encrypt:self.QQ key:TOKEN];
    NSString *enOther=[NSData AES256Encrypt:self.Other key:TOKEN];
    
    [dic setObject:enUID forKey:@"UID"];
    [dic setObject:enIndustryExperience forKey:@"IndustryExperience"];
    [dic setObject:enServiceDesc forKey:@"ServiceDesc"];
    [dic setObject:enPersonalCase forKey:@"PersonalCase"];
    [dic setObject:enFunctionKeyWord forKey:@"FunctionKeyword"];
    [dic setObject:enWorkYear forKey:@"WorkYear"];
    [dic setObject:enLocationID forKey:@"LocationID"];
    [dic setObject:enIndustry forKey:@"Industry"];
    [dic setObject:enFunction forKey:@"Function"];
    [dic setObject:enCompanyName forKey:@"CompanyName"];
    [dic setObject:enDutyName forKey:@"DutyName"];
    [dic setObject:enEmail forKey:@"Email"];
    [dic setObject:enMobile forKey:@"Mobile"];
    [dic setObject:enWechat forKey:@"Wechat"];
    [dic setObject:enQQ forKey:@"QQ"];
    [dic setObject:enOther forKey:@"Other"];
    
    
    [ChinaValueInterface KspServiceEditParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dic=[ExplainText explainDataWith:responseObject];
            KspServiceEditModel *kspServeceEditModel=[[KspServiceEditModel alloc]initWithDic:dic];

            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate deliverThisdataToMySerVerDetail:kspServeceEditModel];
            });
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"put the KspServiceEdit is failure");
    }];
    
}





@end
