//
//  LoginViewController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/20.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *password;

@property(nonatomic,strong)UIButton *forgetPassword;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton *resignButton;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *qqLoginButton;
@property(nonatomic,strong)UIButton *sinaLoginButton;
@property(nonatomic,strong)UIButton *weixinLoginButton;

@end
