//
//  LoginViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/20.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "LoginViewController.h"
#import "FindPasswordViewController.h"
#import "ResignViewController.h"
#import "HomeViewController.h"
#import "FirestViewController.h"
#import "ChinaValueInterface.h"
#import "AESCrypt.h"
#import "GTMBase64.h"
#import "NSData+ZXAES.h"
#import "UserModel.h"
#import "BasicUserInformation.h"
#import "MBProgressHUD.h"


#define TOKEN @"chinavaluetoken=abcdefgh01234567"

@interface LoginViewController (){
    UIImageView *imageView;
    FindPasswordViewController *_findPasswordContrller;
    ResignViewController *_resignController;
    HomeViewController *_homeVC;
    FirestViewController *_firstVC;
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetter];
    [self addBottomLine];
   
    
    if (_findPasswordContrller==nil) {
        _findPasswordContrller=[[FindPasswordViewController alloc]init];
        _findPasswordContrller.view.frame=self.view.bounds;
    }
    
    if (_resignController==nil) {
        _resignController=[[ResignViewController alloc]init];
        _resignController.view.frame=self.view.bounds;
    }
    if (_homeVC==nil) {
        //homeVicController一定要设置成全局的，不然会报错
        _homeVC=[[HomeViewController alloc]init];
    }
    if (_firstVC==nil) {
        _firstVC=[[FirestViewController alloc]init];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark 控件基本设置
-(void)baseSetter{
    if (self.userName==nil) {
        self.userName=[[UITextField alloc]init];
        CGFloat x=10;
        CGFloat y=self.view.frame.size.height/3;
        self.userName.frame=CGRectMake(x, y, self.view.frame.size.width-20, 30);
        [self.userName setBorderStyle:UITextBorderStyleNone];
        self.userName.delegate = self;
        [self.view addSubview:self.userName];
        
        
    }
    if (self.password==nil) {
        self.password=[[UITextField alloc]init];
        CGFloat x=10;
        CGFloat y=self.view.frame.size.height/3+40;
        self.password.frame=CGRectMake(x, y, self.view.frame.size.width-20, 30);
        [self.password setBorderStyle:UITextBorderStyleNone];
        self.password.delegate = self;
        [self.view addSubview:self.password];
        
    }
    
    self.userName.placeholder=@"输入邮箱／手机号";
    self.password.placeholder=@"输入密码";
    self.password.secureTextEntry = YES;
    [self.userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.userName setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.password setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    
    
    if (self.forgetPassword==nil) {
        self.forgetPassword=[UIButton buttonWithType:UIButtonTypeCustom];
        self.forgetPassword.frame=CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/3+88, 80, 30);
        [self.forgetPassword setTitle:@"忘记密码？"  forState:UIControlStateNormal];
        [self.forgetPassword.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [self.forgetPassword addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.forgetPassword];
    }
    
    if (self.loginButton==nil) {
        self.loginButton=[UIButton buttonWithType:UIButtonTypeSystem];
        self.loginButton.frame=CGRectMake(self.view.frame.size.width/2-85, self.view.frame.size.height/3+166, 160, 40);
        
         [self.loginButton setBackgroundImage:[UIImage imageNamed:@"login_btn_unselect.png"] forState:UIControlStateNormal];
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"login_btn_select.png"] forState:UIControlStateHighlighted];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor colorWithRed:54.f/255.f green:135.f/255.f blue:118.f/255.f alpha:1] forState:UIControlStateNormal];
        [self.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.loginButton];
    }
    
    if (self.resignButton==nil) {
        self.resignButton=[UIButton buttonWithType:UIButtonTypeSystem];
        self.resignButton.frame=CGRectMake(self.view.frame.size.width/2-85, self.view.frame.size.height/3+216, 160, 40);
       [ self.resignButton setTitle:@"注册" forState:UIControlStateNormal];
        [self.resignButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.resignButton addTarget:self action:@selector(resignButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.resignButton];
        
    }
    
    
    if (self.titleLabel==nil) {
        self.titleLabel=[[UILabel alloc]init];
        self.titleLabel.frame=CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height-150, 100, 44);
        [self.titleLabel setText:@"第三方账号登录"];
        self.titleLabel.font=[UIFont systemFontOfSize:13.0f];
        self.titleLabel.textColor=[UIColor whiteColor];
        [self.view addSubview:self.titleLabel];
        
    }
    
    if (self.qqLoginButton==nil) {
        self.qqLoginButton=[UIButton buttonWithType:UIButtonTypeSystem];
        self.qqLoginButton.frame=CGRectMake(self.view.frame.size.width/2-120, self.view.frame.size.height-100, 60, 60);
        [self.qqLoginButton setBackgroundImage:[UIImage imageNamed:@"qq_login.png"] forState:UIControlStateNormal];
        [self.view addSubview:self.qqLoginButton];
    }
    
    if (self.sinaLoginButton==nil) {
        self.sinaLoginButton=[UIButton buttonWithType:UIButtonTypeSystem];
        self.sinaLoginButton.frame=CGRectMake(self.view.frame.size.width/2-30, self.view.frame.size.height-100, 60, 60);
        [self.sinaLoginButton setBackgroundImage:[UIImage imageNamed:@"sina_login.png"] forState:UIControlStateNormal];
        [self.view addSubview:self.sinaLoginButton];
    }
    
    if (self.weixinLoginButton==nil) {
        self.weixinLoginButton=[UIButton buttonWithType:UIButtonTypeSystem];
        self.weixinLoginButton.frame=CGRectMake(self.view.frame.size.width/2+60, self.view.frame.size.height-100, 60, 60);
        [self.weixinLoginButton setBackgroundImage:[UIImage imageNamed:@"weixin_login.png"] forState:UIControlStateNormal];
        [self.view addSubview:self.weixinLoginButton];
    }


    

}

-(void)addBottomLine{
    //userName底部
    CGFloat x=self.userName.frame.origin.x;
    CGFloat y=self.userName.frame.origin.y+self.userName.frame.size.height;
    CGFloat w=self.userName.frame.origin.x+self.userName.frame.size.width;
    CGFloat h=self.userName.frame.origin.y+self.userName.frame.size.height;
    [self drawLineWithX:x Y:y Width:w hight:h];
    
    //password底部
    CGFloat x1=self.password.frame.origin.x;
    CGFloat y1=self.password.frame.origin.y+self.password.frame.size.height;
    CGFloat w1=self.password.frame.origin.x+self.password.frame.size.width;
    CGFloat h1=self.password.frame.origin.y+self.password.frame.size.height;
    [self drawLineWithX:x1 Y:y1 Width:w1 hight:h1];
    
    //button底部
    CGFloat x2=self.forgetPassword.frame.origin.x;
    CGFloat y2=self.forgetPassword.frame.origin.y+self.forgetPassword.frame.size.height;
    CGFloat w2=self.forgetPassword.frame.origin.x+self.forgetPassword.frame.size.width-10;
    CGFloat h2=self.forgetPassword.frame.origin.y+self.forgetPassword.frame.size.height;
    [self drawLineWithX:x2 Y:y2 Width:w2 hight:h2];
    
    
    
}

#pragma mark 划线
-(void)drawLineWithX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width hight:(CGFloat)hight{
    imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:imageView];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_top_bg.png"]]];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.5);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);//线颜色
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x,y );
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), width, hight);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}

#pragma mark -按钮监听事件
-(void)forgetPasswordAction{
    NSLog(@"forget");
    
    [self.navigationController pushViewController:[[FindPasswordViewController alloc]init] animated:YES];
    //[self presentViewController:_findPasswordContrller animated:YES completion:nil];
}

-(void)loginButtonAction{
    NSLog(@"login");
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//    [dic setObject:@"416225994@qq.com" forKey:@"LoginName"];
//    [dic setObject:@"09andy28" forKey:@"LoginPwd"];
    
    
    //AES+Base64
    
    //NSString *name=self.userName.text;//
    NSString *name=@"416225994@qq.com";
    NSString *encryptedNAM=[NSData AES256Encrypt:name key:TOKEN];//加密后的name
    
    //NSString *password = self.password.text;//
    NSString *password = @"09andy28";
    NSString *encryptedPWD = [NSData AES256Encrypt:password key:TOKEN];//加密后的password
    
    
    //加到dic中
    [dic setObject:encryptedNAM forKey:@"LoginName"];
    [dic setObject:encryptedPWD forKey:@"LoginPwd"];
    
    //NSString *code=@"vM14ob4fd32aAPXNHGwElp2JBlUMJEnJVULFPf86M4w=";
    //NSString *enCode=[NSData AES256Decrypt:code key:TOKEN];
   
    //NSLog(@"--------------%@",enCode);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"登录中";
    
    [ChinaValueInterface UserLoginParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is:%@",responseObject);
        
        NSDictionary *dict=[self explainDataWith:responseObject];
        NSString *userID=[dict objectForKey:@"UID"];
        NSLog(@"UID value is :%@",userID);
        
        hud.labelText = [dict objectForKey:@"Msg"];
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5f];
        
        if ([userID intValue]>0) {
            NSLog(@"登录成功");
            
            NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
            //加密
            NSString *idEN=[NSData AES256Encrypt:userID key:TOKEN];
            [dictionary setValue:idEN forKey:@"UID"];
            //加载用户基本信息
            [ChinaValueInterface GetUserBasicInfoParameters:dictionary  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dic=[ExplainText explainDataWith:responseObject];
                [UserModel sharedManager].basicUserInformation=[[BasicUserInformation alloc]initWithDic:dic];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"load data is failure");
            }];
            
            [UserModel sharedManager].userID=userID;
            [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"UID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@" failure to httpRequest");
        hud.labelText = error.domain;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5f];
    }];
    
}

-(void)resignButtonAction{
    NSLog(@"resign");
    [self.navigationController pushViewController:[[ResignViewController alloc]init] animated:YES];
    //[self presentViewController:_resignController animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -解密数据
-(NSDictionary *)explainDataWith:(id)responseObject{
    NSDictionary *dict=responseObject;
    NSArray  *dataArray=[dict objectForKey:@"ChinaValue"];
    
    NSLog(@"dict is %@",dataArray);
    NSDictionary *dataDic=dataArray[0];
    
    return dataDic;
}

@end
