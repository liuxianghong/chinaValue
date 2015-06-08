//
//  FileSeeViewController.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/6.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "FileSeeViewController.h"
#import "UIBarButtonItem+ZX.h"

@interface FileSeeViewController ()
@property (nonatomic,strong) IBOutlet UIWebView *scrollView;
@end

@implementation FileSeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%@的日志",self.userName];
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.BlogID key:TOKEN] forKey:@"BlogID"];
    
    [ChinaValueInterface GetUserBlogDetailParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dicData = [responseObject[@"ChinaValue"] firstObject];//dicData
        [self.scrollView loadHTMLString:dicData[@"Content"] baseURL:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
