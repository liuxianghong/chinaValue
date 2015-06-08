 //
//  ServerDemandViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/27.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
// 服务需求页面
#import "ServerDemandViewController.h"
#import "UIBarButtonItem+ZX.h"
#import "SercerDemandButon.h"
#import "ServerMethodController.h"
#import "SelectViewController.h"
#import "DemandViewController.h"

@interface ServerDemandViewController ()<UITextFieldDelegate,SelectViewDelegate>{
    NSArray *_sectionTextArray;
    NSArray *_textArray1;
    NSArray *_textArray2;
    NSMutableDictionary *_textFieldDic1; //用来保存section1种textfield里面的填写内容
    NSMutableDictionary *_textFieldDic2;  //用来保存section2种textfield里面的填写内容
    ServerMethodController *_serverMethodController;
    SelectViewController *_selectViewController;
    UILabel *_serverMethodLabel;
    UILabel *_serverCategoryLabel;
     NSString *_str;
    DemandViewController *_demandViewController;
    
}
@property(nonatomic,strong)NSString *Email;
@property(nonatomic,strong)NSString *WeChat;
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,strong)NSString *TelePhone;
@property(nonatomic,strong)NSString *QQ;
@property(nonatomic,strong)NSString *Other;


@property(nonatomic,strong)NSString *RequestTitle;
@property(nonatomic,strong)NSString *ServerMethod;
@property(nonatomic,strong)NSString *ServerAddress;
@property(nonatomic,strong)NSString *ServerPrice;
@property(nonatomic,strong)NSString *ServerName;//需求所属行业
@property(nonatomic,strong)NSString *DemandDate;
@property(nonatomic,strong)NSString *DemandDecript;

@end

@implementation ServerDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_textArray1==nil) {
        _textArray1=@[@"邮箱地址:",@"微信号:",@"手机号:",@"QQ:",@"其他:"];
        
    }
    if (_textArray2==nil) {
        _textArray2=@[@"需求标题:",@"服务方式:",@"服务费用:",@"有效期",@"所在地",@"行业类别",@"服务类别",@"需求描述:"];
    }
    if (_sectionTextArray==nil) {
        _sectionTextArray=@[@"联系方式",@"需求内容"];
    }
    if (_textFieldDic1==nil) {
        _textFieldDic1=[[NSMutableDictionary alloc]init];
    }
    if (_textFieldDic2==nil) {
        _textFieldDic2=[[NSMutableDictionary alloc]init];
    }
    if (_serverMethodController==nil) {
        _serverMethodController=[[ServerMethodController alloc]init];
    }
    if (_selectViewController==nil) {
        _selectViewController=[[SelectViewController alloc]init];
        _selectViewController.delegate=self;
    }
    if (_demandViewController==nil) {
        _demandViewController=[[DemandViewController alloc]init];
    }
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"服务需求"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    //添加
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)]];
    UIButton *confirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame=CGRectMake(self.view.frame.size.width/3,7, 150, 30);
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"serverManager_select_11.png"] forState:UIControlStateNormal];
    [confirmButton setTitle:@"提交" forState:UIControlStateNormal];
    [confirmButton setTintColor:[UIColor whiteColor]];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView.tableFooterView addSubview:confirmButton];

    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
}

#pragma mark barButtonItem的监听事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark confirmButton按钮的监听事件
-(void)confirmButtonAction{
    //提交之后跳转到需求管理页面
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _sectionTextArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        return _textArray1.count;
    }
    else{
        return _textArray2.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    static NSString *myCell=@"myCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
       cell.textLabel.textColor=[UIColor grayColor];
    cell.textLabel.font=[UIFont systemFontOfSize:13.0f];
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
                
            }else if (indexPath.row==5){
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField setText:[_textFieldDic1 objectForKey:key]];
                
            }
        cell.accessoryView=textField;
    }
    if (indexPath.section==1) {
        cell.textLabel.text=_textArray2[indexPath.row];
        
        
       textField1.placeholder=@"点击编辑";
        if (indexPath.row!=1&&indexPath.row!=4) {
            cell.accessoryView=textField1;
            if (indexPath.row==0) {
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];
            }else if (indexPath.row==2) {
                NSString *key=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                [textField1 setText:[_textFieldDic2 objectForKey:key]];

                
            }else if(indexPath.row==3){
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

            }
        }else if (indexPath.row==1){
           _serverMethodLabel=[[UILabel alloc]init];
            _serverMethodLabel.frame=CGRectMake(cell.frame.size.width/2, 0, 180, 44);
            [_serverMethodLabel setTextAlignment:NSTextAlignmentRight];
            [_serverMethodLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [_serverMethodLabel setTextColor:[UIColor grayColor]];

           // [serverMethodLabel setText:@"nihao"];
            [cell addSubview:_serverMethodLabel];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else{
            _serverCategoryLabel=[[UILabel alloc]init];
            _serverCategoryLabel.frame=CGRectMake(cell.frame.size.width/2, 0, 180, 44);
            [_serverCategoryLabel setTextAlignment:NSTextAlignmentRight];
            [_serverCategoryLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [_serverCategoryLabel setTextColor:[UIColor grayColor]];
            [_serverCategoryLabel setText:_str];
            [cell addSubview:_serverCategoryLabel];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==1) {
            [self.navigationController pushViewController:_serverMethodController animated:YES];
        }
        if (indexPath.row==4) {
            [self.navigationController pushViewController:_selectViewController animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return _sectionTextArray[section];
    }
    return _sectionTextArray[section];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 100, 44)];
//    label.font=[UIFont systemFontOfSize:13.0f];
//    if (section==0) {
//        label.text=_sectionTextArray[section];
//    }else{
//        label.text=_sectionTextArray[section];
//    }
//    return label;
//}

#pragma mark -textfield的监听方法
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
            self.WeChat=textField.text;
             [_textFieldDic1 setObject:self.WeChat forKey:key];
            [self.tableView reloadData];
            break;
        case 2:
            self.Mobile=textField.text;
            [_textFieldDic1 setObject:self.Mobile forKey:key];

            [self.tableView reloadData];
            break;
        case 3:
            self.TelePhone=textField.text;
            [_textFieldDic1 setObject:self.TelePhone forKey:key];

            [self.tableView reloadData];
            break;
        case 4:
            self.QQ=textField.text;
            [_textFieldDic1 setObject:self.QQ forKey:key];

            [self.tableView reloadData];
            break;
        case 5:
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
        case 0:
            self.RequestTitle=textField.text;
            [_textFieldDic2 setObject:self.RequestTitle forKey:key];
            [self.tableView reloadData];
            break;
        case 2:
            self.ServerMethod=textField.text;
            [_textFieldDic2 setObject:self.ServerMethod forKey:key];
            [self.tableView reloadData];
            break;
        case 3:
            self.ServerAddress=textField.text;
            [_textFieldDic2 setObject:self.ServerAddress forKey:key];
            [self.tableView reloadData];
            break;
        case 5:
            self.ServerPrice=textField.text;
            [_textFieldDic2 setObject:self.ServerPrice forKey:key];
            [self.tableView reloadData];
            break;
        case 6:
            self.ServerName=textField.text;
            [_textFieldDic2 setObject:self.ServerName forKey:key];
            [self.tableView reloadData];
            break;
        case 7:
            self.DemandDate=textField.text;
            [_textFieldDic2 setObject:self.DemandDate forKey:key];
            [self.tableView reloadData];
            break;
        default:
        break;    }
    
}

#pragma mark -实现selectView的协议代理方法
- (void)selectWithDic:(NSMutableDictionary *)dic{
   
    for (NSString *text in [dic allKeys]) {
        _str=[NSString stringWithFormat:@"%@等%ld个行业",text,[dic count]];
    }
   // _serverCategoryLabel.text=_str;
    NSLog(@"my str is :%@",_str);
    [self.tableView reloadData];
}

@end
