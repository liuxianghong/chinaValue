//
//  WBNavigationViewController.m
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "WBNavigationViewController.h"

@interface WBNavigationViewController ()

@end

@implementation WBNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏的属性
    
    UINavigationBar *bar=[UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"main_top_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{
                                  
                                  NSForegroundColorAttributeName:[UIColor blackColor],
                                  //  NSShadowAttributeName:[NSValue valueWithUIOffset:UIOffsetZero],
                                  }];
    
    
    //修改UIBarbuttonItem上的文字字样
    UIBarButtonItem *barItem=[UIBarButtonItem appearance];
    
//    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    
    NSDictionary *dict=@{
                         NSForegroundColorAttributeName:[UIColor grayColor],
                         };
    [barItem setTitleTextAttributes: dict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
}


@end
