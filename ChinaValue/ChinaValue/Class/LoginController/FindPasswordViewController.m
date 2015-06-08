//
//  FindPasswordViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/21.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "UIBarButtonItem+ZX.h"
#define KNavigationBarH 44

@interface FindPasswordViewController ()

@end

@implementation FindPasswordViewController
{
    UITextField *userName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationBar];
    
    [self addBaseSetter];
     [self.view setBackgroundColor:[UIColor whiteColor]];
    
}
#pragma mark -添加控件
-(void)addBaseSetter{
    
    //1 添加提示框
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, KNavigationBarH, self.view.frame.size.width-40, KNavigationBarH)];
    //1.2注意这里UILabel的numberoflines(即最大行数限制)设置成0，即不做行数限制。
    [textLabel setNumberOfLines:0];
    textLabel.text=@"请认真填写您的手机号，密码将自动发送到您填写的手机短信中，请注意查收。";
    textLabel.textColor=[UIColor grayColor];
    textLabel.font=[UIFont systemFontOfSize:13.0f];
    [self.view addSubview:textLabel];
    
    //2 添加输入框
    userName=[[UITextField alloc]init];
    userName.frame=CGRectMake(20, KNavigationBarH*2+10, self.view.frame.size.width-40, KNavigationBarH);
    userName.delegate = self;
 //   userName.background=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forget_02.PNG"]];
    userName.backgroundColor=[UIColor clearColor];
    //2.1设置输入框的背景图片
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forget_01.png"]];
    imageView.frame=CGRectMake(15, KNavigationBarH*2+10, self.view.frame.size.width-40, KNavigationBarH+5);
    [self.view addSubview:imageView];
   // userName.placeholder=@"请输入手机号/邮箱号";
    //2.2placeholder居中显示
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:@"请输入手机号/邮箱号"];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, attributedStr.length)];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.attributedPlaceholder = attributedStr;
    [self.view addSubview:userName];
    
    //3 添加button
    UIButton *findButton=[UIButton buttonWithType:UIButtonTypeCustom];
    findButton.frame=CGRectMake(20, self.view.frame.size.height/2, self.view.frame.size.width-40, 44);
    [findButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [findButton.titleLabel setTintColor:[UIColor whiteColor]];
    [findButton addTarget:self action:@selector(findButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [findButton setBackgroundImage:[UIImage imageNamed:@"forget_02.PNG"] forState:UIControlStateNormal];
    [findButton setBackgroundImage:[UIImage imageNamed:@"resign_03.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:findButton];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -添加导航条
-(void)addNavigationBar{
    //UINavigationBar *navigationBar=[[UINavigationBar alloc]init];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"main_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    //navigationBar.frame=CGRectMake(0, 0, self.view.frame.size.width, KNavigationBarH);
    //[self.view addSubview:navigationBar];
    
    
    //UINavigationItem *navigationItem=[[UINavigationItem alloc]init];
    //UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    //[label setText:@"忘记密码"];
    //[label setTextColor:[UIColor whiteColor]];
    //navigationItem.titleView=label;
    
    
    //添加左barbuttonItem按钮的图片

    self.title = @"忘记密码";
    
    //UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"forget_04.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    //添加内容到导航栏
    //[navigationBar pushNavigationItem:navigationItem animated:NO];
    

}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮监听
-(void)findButtonAction{
    NSLog(@"find button is begin");
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
