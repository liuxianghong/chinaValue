//
//  EvaluateController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//   评价页面
//
#import "EvaluateController.h"
#import "UIBarButtonItem+ZX.h"
#import "UIImageView+WebCache.h"



#import "ExplainText.h"
#import "ChinaValueInterface.h"
#import "GetKspListModel.h"
#import "UIImageView+WebCache.h"
#import "NSData+ZXAES.h"
#import "MBProgressHUD.h"
#import "KspReqListModel.h"
#import "UserModel.h"
#import "CreditEditModel.h"



#define TOKEN @"chinavaluetoken=abcdefgh01234567"


@interface EvaluateController()<MBProgressHUDDelegate>{
    UIImageView *_headerView;
    UILabel *_nameLabel;
    NSInteger *_i;
    
    UITextView *_textView;
    
    MBProgressHUD *HUD;
}
@end

@implementation EvaluateController


-(void)reloadDataWith:(GetReqDetailModel *)getReqdetailModel{
        self.getReqDetailModel=getReqdetailModel;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
   
    
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"评价"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    
    //createview 添加视图
    [self createView];
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithText:@"提交" target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
    
    
    _i=0;
    
}

-(void)viewDidAppear:(BOOL)animated{
        [_headerView setImageWithURL:[NSURL URLWithString:self.getReqDetailModel.PublisherAvatar] placeholderImage:[UIImage imageNamed:@"serverDetail_02.PNG"]];
    
    _nameLabel.text=self.getReqDetailModel.PublisherName;

}
#pragma mark leftBarButton的监听
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark rightBarButtonItem的监听
-(void)rightBarButtonAction{
    //先提交填写的数据然后再pop页面
    //提交数据
    [self putCreditData];
    
}



#pragma mark -创建评价视图控件
-(void)createView{
    //头像和评价星星数及评价内容在一个单独的view里面
    UIView *evaluateView=[[UIView alloc]init];
    evaluateView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2);
    [evaluateView setBackgroundColor:[UIColor whiteColor]];
    
    //先添加三条横线
    UIView *line1=[[UIView alloc]init];
    line1.frame=CGRectMake(0, 80, self.view.frame.size.width, 1);
    [line1 setBackgroundColor:[UIColor grayColor]];
    [evaluateView addSubview:line1];
    
    UIView *line2=[[UIView alloc]init];
    line2.frame=CGRectMake(0, 124, self.view.frame.size.width, 1);
    [line2 setBackgroundColor:[UIColor grayColor]];
    [evaluateView addSubview:line2];

    UIView *line3=[[UIView alloc]init];
    line3.frame=CGRectMake(0, evaluateView.frame.size.height, self.view.frame.size.width, 1);
    [line3 setBackgroundColor:[UIColor grayColor]];
    [evaluateView addSubview:line3];
    
    //头像
    UIImageView *headView=[[UIImageView alloc]init];
    headView.frame=CGRectMake(10, 10, 60, 60);
    _headerView=headView;
   // [headView setImage:[UIImage imageNamed:@"serverDetail_02.PNG"]];
//    [headView setImageWithURL:[NSURL URLWithString:self.getReqDetailModel.PublisherAvatar] placeholderImage:[UIImage imageNamed:@"serverDetail_02.PNG"]];
    
    [evaluateView addSubview:headView];
    
    //name
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 100, 20)];
    [nameLabel setFont:[UIFont systemFontOfSize:13.0f]];
    //nameLabel.text=@"andy";
   // nameLabel.text=self.getReqDetailModel.PublisherName;
    _nameLabel=nameLabel;
    [evaluateView addSubview:nameLabel];
    
    //explain
    UILabel *explain=[[UILabel alloc]initWithFrame:CGRectMake(80, 30, evaluateView.frame.size.width-120, 30)];
    explain.numberOfLines = 0;
    [explain setLineBreakMode:NSLineBreakByWordWrapping];
    explain.text=@"请您根据服务过程中对服务方的服务质量进行评价";
    [explain setFont:[UIFont systemFontOfSize:12.0f]];
    [evaluateView addSubview:explain];
    
    //总体评价
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 92, 60, 20)];
    textLabel.text=@"总体评价";
    [textLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [evaluateView addSubview:textLabel];
    
    //创建button（评价的星星)
    
    UIButton *starButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    starButton1.frame=CGRectMake(80, 87, 30, 30);
    starButton1.tag=1;
    [starButton1 setBackgroundImage:[UIImage imageNamed:@"serverDetail_01.png"] forState:UIControlStateNormal];
    [starButton1 setBackgroundImage:[UIImage imageNamed:@"credit_04.png"] forState:UIControlStateSelected];
    [starButton1 addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [evaluateView addSubview:starButton1];
    
    UIButton *starButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    starButton2.frame=CGRectMake(80+35, 87, 30, 30);
    starButton2.tag=2;
    [starButton2 setBackgroundImage:[UIImage imageNamed:@"serverDetail_01.png"] forState:UIControlStateNormal];
    [starButton2 setBackgroundImage:[UIImage imageNamed:@"credit_04.png"] forState:UIControlStateSelected];
    [starButton2 addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];

    [evaluateView addSubview:starButton2];
    
    UIButton *starButton3=[UIButton buttonWithType:UIButtonTypeCustom];
    starButton3.frame=CGRectMake(80+35*2, 87, 30, 30);
    starButton3.tag=3;
    [starButton3 setBackgroundImage:[UIImage imageNamed:@"serverDetail_01.png"] forState:UIControlStateNormal];
    [starButton3 setBackgroundImage:[UIImage imageNamed:@"credit_04.png"] forState:UIControlStateSelected];
    [starButton3 addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];

    [evaluateView addSubview:starButton3];
    
    UIButton *starButton4=[UIButton buttonWithType:UIButtonTypeCustom];
    starButton4.frame=CGRectMake(80+35*3, 87, 30, 30);
    starButton4.tag=4;
    [starButton4 setBackgroundImage:[UIImage imageNamed:@"serverDetail_01.png"] forState:UIControlStateNormal];
    [starButton4 setBackgroundImage:[UIImage imageNamed:@"credit_04.png"] forState:UIControlStateSelected];
    [starButton4 addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];

    [evaluateView addSubview:starButton4];
    
    UIButton *starButton5=[UIButton buttonWithType:UIButtonTypeCustom];
    starButton5.frame=CGRectMake(80+35*4, 87, 30, 30);
    starButton5.tag=5;
    [starButton5 setBackgroundImage:[UIImage imageNamed:@"serverDetail_01.png"] forState:UIControlStateNormal];
    [starButton5 setBackgroundImage:[UIImage imageNamed:@"credit_04.png"] forState:UIControlStateSelected];
    [starButton5 addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [evaluateView addSubview:starButton5];

    //评价内容
    UITextView *textView=[[UITextView alloc]init];
    //line2.frame=CGRectMake(0, 124, self.view.frame.size.width, 1);
    textView.frame=CGRectMake(10, 127, evaluateView.frame.size.width-20, evaluateView.frame.size.height-127);
    textView.returnKeyType = UIReturnKeyDefault;//return键的类型
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
                                
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:@"评价内容..." attributes:attributes];
    _textView=textView;
    
    [evaluateView addSubview:textView];
    
    [self.view addSubview:evaluateView];
    
    
    
    
    
    //评价提示
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, evaluateView.frame.size.height+10, 60,20)];
    label1.text=@"评价提示";
    [label1 setFont:[UIFont systemFontOfSize:13.0f]];
    [label1 setTextColor:[UIColor grayColor]];
    [self.view addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, evaluateView.frame.size.height+25, self.view.frame.size.width-20,40)];
    label2.text=@"1.请您根据服务过程中对服务方的服务质量、沟通态度和服务结果，真实，客观的给予对方评价；";
    label2.numberOfLines=0;
    [label2 setLineBreakMode:NSLineBreakByCharWrapping];
    [label2 setFont:[UIFont systemFontOfSize:13.0f]];
     [label2 setTextColor:[UIColor grayColor]];
    [self.view addSubview:label2];

    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, evaluateView.frame.size.height+62, self.view.frame.size.width-20,20)];
    label3.text=@"2.您的评价将成为对方服务信用的真实体现；";
     [label3 setTextColor:[UIColor grayColor]];
    [label3 setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:label3];
    
    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(10, evaluateView.frame.size.height+82, self.view.frame.size.width-20,20)];
    label4.text=@"3.评价30天内，您可以对评价进行修改.";
     [label4 setTextColor:[UIColor grayColor]];
    [label4 setFont:[UIFont systemFontOfSize:13.0f]];
    [self.view addSubview:label4];
    
}

#pragma mark -点击事件的监听
-(void)buttonClickAction:(UIButton *)button{
   
    if (button.selected) {
        NSLog(@"jfklsjafkj");
        --_i;
        NSLog(@"startCount is :%ld",(long)_i);
        button.selected=NO;
        
        
    }else{
        
        NSLog(@"ljfslkdjfklsdajflkasdjf");
        ++_i;
        NSLog(@"startCount is :%ld",(long)_i);

        button.selected=YES;
        
    }
    
    
}


#pragma  mark -putCreditData
-(void)putCreditData{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    NSString *enFormUID=[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN];
    
    NSString *enToUID=[NSData AES256Encrypt:self.getReqDetailModel.PublisherID key:TOKEN];
    
    NSString *enReqID=[NSData AES256Encrypt:self.getReqDetailModel.ReqID key:TOKEN];
    
    //分数先设定一个常亮
    NSString *enScore=[NSData AES256Encrypt:@"4" key:TOKEN];
    
    NSString *enContent=[NSData AES256Encrypt:_textView.text key:TOKEN];
    NSLog(@"textview.text is :%@",_textView.text);
    
    [dic setObject:enFormUID forKey:@"FromUID"];
    [dic setObject:enToUID forKey:@"ToUID"];
    [dic setObject:enReqID forKey:@"ReqID"];
    [dic setObject:enContent forKey:@"Content"];
    [dic setObject:enScore forKey:@"Score"];
    
    [ChinaValueInterface CreditEditParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSDictionary *dic=[ExplainText explainDataWith:responseObject];
            CreditEditModel *creditEditModel=[[CreditEditModel alloc]initWithDic:dic];
            //把creditEditModel传递到父类中去，通过代理
            
            [self.delegate deliverDataToOtherServerDetailController:creditEditModel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //pop页面
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        });
        
       
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"put credit data is failure");
    }];
    
    
}

#pragma mark -loading页面
-(void)showHUD{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
}


@end
