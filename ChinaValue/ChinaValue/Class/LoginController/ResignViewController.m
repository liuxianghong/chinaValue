//
//  ResignViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/21.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ResignViewController.h"
#import "ChinaValueInterface.h"
#define KNavigationBarH 44
@interface ResignViewController ()

@end

@implementation ResignViewController
{
    UITextField *userName;
    UITextField *checkCode;
    UITextField *passwordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBar];
    [self addBaseSetter];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark -添加基础控件
-(void)addBaseSetter{
    //1 添加userName
    userName=[[UITextField alloc]init];
    userName.frame=CGRectMake(25, KNavigationBarH*2+10, self.view.frame.size.width-50, KNavigationBarH);
    //   userName.background=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forget_02.PNG"]];
    userName.backgroundColor=[UIColor clearColor];
    //1.1设置userName的背景图片
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"resign_04.png"]];
    imageView.frame=CGRectMake(10, KNavigationBarH*2+10, self.view.frame.size.width-20, KNavigationBarH);
    [self.view addSubview:imageView];
    //1.2placeholder居中显示
    userName.placeholder=@"请输入您的手机号";
//    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:@"请输入您的手机号"];
//    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, attributedStr.length)];
//    userName.textAlignment = NSTextAlignmentLeft;
//    userName.attributedPlaceholder = attributedStr;
    userName.delegate = self;
    [self.view addSubview:userName];
    
    
    
    
    //2 添加checkCode
    checkCode=[[UITextField alloc]init];
    checkCode.frame=CGRectMake(25, KNavigationBarH*3+10, self.view.frame.size.width-140, KNavigationBarH);
    checkCode.backgroundColor=[UIColor clearColor];
    checkCode.placeholder=@"验证码";
    //2.1设置checkCode的背景图片
    UIImageView *imageView1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"resign_05.png"]];
    imageView1.frame=CGRectMake(10, KNavigationBarH*3+10, self.view.frame.size.width-20, KNavigationBarH);
    [self.view addSubview:imageView1];
    checkCode.delegate = self;
    [self.view addSubview:checkCode];
    
    //3 添加获取验证码的按钮CodeButton
    UIButton *codeButton=[UIButton buttonWithType:UIButtonTypeSystem];
    codeButton.frame=CGRectMake(imageView1.frame.size.width-90, KNavigationBarH*3+KNavigationBarH/2-3, 80, 25);
    [codeButton setBackgroundImage:[UIImage imageNamed:@"resign_01.PNG"] forState:UIControlStateNormal];
    [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
    codeButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
   
    [codeButton addTarget:self action:@selector(codeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeButton];
    
    //4添加passwordTextField
    passwordTextField=[[UITextField alloc]init];
    passwordTextField.frame=CGRectMake(25, KNavigationBarH*4+10, self.view.frame.size.width-50, KNavigationBarH);
    passwordTextField.backgroundColor=[UIColor clearColor];
    passwordTextField.placeholder=@"密码：6～20位字母、数字、符号构成";
    passwordTextField.delegate = self;
    //2.1设置checkCode的背景图片
    UIImageView *imageView2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"resign_06.png"]];
    imageView2.frame=CGRectMake(10, KNavigationBarH*4+10, self.view.frame.size.width-20, KNavigationBarH);
    [self.view addSubview:imageView2];
    [self.view addSubview:passwordTextField];
    
    
    
    //3 添加注册按钮
    UIButton *resignButton=[UIButton buttonWithType:UIButtonTypeCustom];
    resignButton.frame=CGRectMake(20, KNavigationBarH*7, self.view.frame.size.width-40, 44);
    [resignButton setBackgroundImage:[UIImage imageNamed:@"resign_02.png"] forState:UIControlStateNormal];
    [resignButton setBackgroundImage:[UIImage imageNamed:@"resign_03.png"] forState:UIControlStateHighlighted];
    [resignButton setTitle:@"注册" forState:UIControlStateNormal];
    [resignButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resignButton addTarget:self action:@selector(resignButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resignButton];
    
    



}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -添加导航条
-(void)addNavigationBar{
    /*
    UINavigationBar *navigationBar=[[UINavigationBar alloc]init];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"main_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    navigationBar.frame=CGRectMake(0, 0, self.view.frame.size.width, KNavigationBarH);
    [self.view addSubview:navigationBar];
    
    
    UINavigationItem *navigationItem=[[UINavigationItem alloc]init];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"注册"];
    [label setTextColor:[UIColor whiteColor]];
    navigationItem.titleView=label;
    
    
    
    UIImage *image=[UIImage imageNamed:@"forget_04.png"];
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    navigationItem.leftBarButtonItem=barButtonItem;
    //添加内容到导航栏
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    */
    self.title = @"注册";
    
    //UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"forget_04.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    
}

#pragma mark -按钮监听事件
-(void)backAction{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)codeButtonAction{
    NSLog(@"code Button Action");
}


-(void)resignButtonAction{
    NSLog(@"resign button action is begin");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
