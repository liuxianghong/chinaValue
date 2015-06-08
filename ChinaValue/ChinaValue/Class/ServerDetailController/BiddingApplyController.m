//
//  BiddingApplyController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

//  竞标申请页面

#import "BiddingApplyController.h"
#import "MyCell.h"
#import "UIBarButtonItem+ZX.h"

@interface BiddingApplyController (){
    NSArray *_textArray;
    NSArray *_imageArray;
    NSArray *_accessoryText;

}

@end

@implementation BiddingApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"竞标申请"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    //初始化Array
    if (_textArray==nil) {
        _textArray=@[@"服务时间",@"服务时长",@"服务费用",@"所在地"];
    }
    if (_imageArray==nil) {
        _imageArray=@[@"writeServerDetail__03.PNG",@"writeServerDetail__02.PNG",@"writeServerDetail_01.PNG",@"serverAdderss.png"];
    }
    if (_accessoryText==nil) {
       // _accessoryText=@[@"2014-05-23  14:23",@"0.5小时",@"5元",@"广东深圳"];
    }
    
    //把多余的表格行隐藏掉
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    }
    
    
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    [self loadApplyData];
}


#pragma mark -查看竞标详情,加载数据
-(void)loadApplyData{
    NSString *enUID=[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN];
    
    
    NSString *enReqID=[NSData AES256Encrypt:self.rID key:TOKEN];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:enUID forKey:@"UID"];
    [dic setObject:enReqID forKey:@"ReqID"];
    
    //    [dic setObject:enUID forKey:@"UID"];
    //    [dic setObject:enReqID forKey:@"ReqID"];
    
    [ChinaValueInterface KspApplyViewParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic1=[ExplainText explainDataWith:responseObject];
        KspApplyViewModel *kspApplyViewModel=[[KspApplyViewModel alloc]initWithDic:dic1];
        
        self.kspApplyViewModel=kspApplyViewModel;
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load data is failure");
    }];
    
    
}

#pragma mark leftBarButton的监听
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    MyCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell==nil) {
        cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row!=4) {
        [cell.imageView setImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
        [cell.textLabel setText:_textArray[indexPath.row]];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        [label setTextAlignment:NSTextAlignmentRight];
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        //[label setText:_accessoryText[indexPath.row]];
        if (indexPath.row==0) {
           
            label.text=self.kspApplyViewModel.AddTime;
        }else if(indexPath.row==1){
            NSString *str=[NSString stringWithFormat:@"%@ 小时",self.kspApplyViewModel.Duration];
            label.text=str;
        }else if(indexPath.row==2){
            NSString *str=[NSString stringWithFormat:@"%@ 元",self.kspApplyViewModel.Price];
            label.text=str;
        }else{
            NSString *str=@"城市";
            if (self.kspApplyViewModel.City==nil) {
                str=[NSString stringWithFormat:@"%@ %@",self.kspApplyViewModel.Country,self.kspApplyViewModel.Province];
            }
            else if (self.kspApplyViewModel.Province==nil) {
                str=self.kspApplyViewModel.Country;
            }
            else{
                if (self.kspApplyViewModel.Province==self.kspApplyViewModel.City) {
                     str=[NSString stringWithFormat:@"%@ %@",self.kspApplyViewModel.Country,self.kspApplyViewModel.City];
                }else{
                     str=[NSString stringWithFormat:@"%@ %@ %@",self.kspApplyViewModel.Country,self.kspApplyViewModel.Province,self.kspApplyViewModel.City];
                }
               
            }
            label.text=str;

        }
        cell.accessoryView=label;

    }
    if (indexPath.row==4) {
        UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width-20, 90)];
        textView.returnKeyType = UIReturnKeyDefault;//return键的类型
        textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        textView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:13],
                                     
                                     };
        textView.attributedText = [[NSAttributedString alloc] initWithString:@"描述基本信息..." attributes:attributes];
        textView.text=self.kspApplyViewModel.Reason;
        //让textview不可编辑
        textView.editable=NO;
        [cell addSubview:textView];
    }
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        return 90;
    }
    return 44;
}

@end
