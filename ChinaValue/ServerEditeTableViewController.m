//
//  ServerEditeTableViewController.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ServerEditeTableViewController.h"
#import "SelectViewController.h"
#import "ServerMethodController.h"
#import "CityViewController.h"

@interface ServerEditeTableViewController ()
@property (nonatomic,weak) IBOutlet UITextField *tfEmail;
@property (nonatomic,weak) IBOutlet UITextField *tfWechat;
@property (nonatomic,weak) IBOutlet UITextField *tfQQ;
@property (nonatomic,weak) IBOutlet UITextField *tfOther;
@property (nonatomic,weak) IBOutlet UITextField *tfMobile;

@property (nonatomic,weak) IBOutlet UITextView *tfDesc;
@property (nonatomic,weak) IBOutlet UITextView *tfDesc2;

@property (nonatomic,weak) IBOutlet UILabel *labelLocationID;
@property (nonatomic,weak) IBOutlet UILabel *labelIndustry;
@property (nonatomic,weak) IBOutlet UILabel *labelFunction;

@property (nonatomic,weak) IBOutlet UITextField *tfFunctionKeyword;
@property (nonatomic,weak) IBOutlet UITextField *tfCompanyName;
@property (nonatomic,weak) IBOutlet UITextField *tfDutyName;
@property (nonatomic,weak) IBOutlet UITextField *tfWorkYear;
@property (nonatomic,weak) IBOutlet UITextField *tfIndustryExperience;

@property (nonatomic,strong) NSMutableDictionary *dicIndustry;
@property (nonatomic,strong) NSMutableDictionary *dicFunction;
@end

@implementation ServerEditeTableViewController
{
    NSMutableDictionary *cityDic;
    
    NSMutableDictionary *IndustryDic;
    NSMutableDictionary *FunctionDic;
    
    NSString *cityID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    CGRect tableViewFooterRect = self.tableView.tableFooterView.frame;
    tableViewFooterRect.size.height = 78.0f;
    [self.tableView.tableFooterView setFrame:tableViewFooterRect];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"forget_04.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    self.title = @"我的服务资料";
    
    _dicIndustry = [[NSMutableDictionary alloc]init];
    _dicFunction = [[NSMutableDictionary alloc]init];
    
    
    [self loadMy];
//    
    if([self.dic count])
    {
        
        cityDic = [[NSMutableDictionary alloc]init];
        cityID = self.dic[@"LocationID"];
        self.labelLocationID.text = self.dic[@"City"];
        self.tfDesc.text = self.dic[@"ServiceDesc"];
        self.tfDesc2.text = self.dic[@"PersonalCase"];
        self.tfFunctionKeyword.text = self.dic[@"FunctionKeyword"];
        self.tfCompanyName.text = self.dic[@"CompanyName"];
        self.tfDutyName.text = self.dic[@"DutyName"];
        self.tfWorkYear.text = self.dic[@"WorkYear"];
        self.tfIndustryExperience.text = self.dic[@"IndustryExperience"];
        
        NSArray *Function = [self.dic[@"Function"] componentsSeparatedByString: @","];
        NSArray *FunctionName = [self.dic[@"FunctionName"] componentsSeparatedByString: @","];
        for (int i=0; i<[Function count]&&i<[FunctionName count]; i++) {
            [_dicFunction setObject:FunctionName[i] forKey:Function[i]];
        }
        
        NSArray *Industry = [self.dic[@"Industry"] componentsSeparatedByString: @","];
        NSArray *IndustryName = [self.dic[@"IndustryName"] componentsSeparatedByString: @","];
        for (int i=0; i<[Industry count]&&i<[IndustryName count]; i++) {
            [_dicIndustry setObject:IndustryName[i] forKey:Industry[i]];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)loadMy
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    [ChinaValueInterface GeContactPatameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
        self.tfEmail.text = dic[@"Email"];
        self.tfMobile.text = dic[@"Mobile"];
        self.tfOther.text = dic[@"Other"];
        self.tfQQ.text = dic[@"QQ"];
        self.tfWechat.text = dic[@"Wechat"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
    //    if (self.reID) {
    //        [self loadRe];
    //    }
}

//-(void)loadRe
//{
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//    [dic setObject:[NSData AES256Encrypt:self.reID key:TOKEN] forKey:@"ReqID"];
//    [ChinaValueInterface KnowKsbReqGetParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
//        cityID = dic[@"CityID"];
//        self.labelLocationID.text = dic[@"City"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ;
//    }];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (cityDic) {
        if ([cityDic objectForKey:@"chenshi"]) {
            self.labelLocationID.text = [cityDic objectForKey:@"chenshi"][@"Name"];
            cityID = [cityDic objectForKey:@"chenshi"][@"ID"];
        }
        else if ([cityDic objectForKey:@"shenfen"]) {
            self.labelLocationID.text = [cityDic objectForKey:@"shenfen"][@"Name"];
            cityID = [cityDic objectForKey:@"shenfen"][@"ID"];
        }
        else if ([cityDic objectForKey:@"guojia"]) {
            self.labelLocationID.text = [cityDic objectForKey:@"guojia"][@"Name"];
            cityID = [cityDic objectForKey:@"guojia"][@"ID"];
        }
        else
        {
            if (cityID) {
                ;
            }
            else
            {
                self.labelLocationID.text = @"请选择所在地";
                cityID = nil;
            }
        }
    }
    else
    {
        if (cityID) {
            ;
        }
        else
            self.labelLocationID.text = @"请选择所在地";
    }
    
    if ([_dicIndustry count]>0) {
        NSString *ind = @"";
        for (NSString *str in [_dicIndustry allValues]) {
            ind = [ind stringByAppendingString:str];
            if (![[[_dicIndustry allValues] lastObject] isEqualToString:str]) {
                ind = [ind stringByAppendingString:@","];
            }
        }
        self.labelIndustry.text = ind;
    }
    else
    {
        self.labelIndustry.text = @"请选择所属行业";
    }
    
    if ([_dicFunction count]>0) {
        NSString *ind = @"";
        for (NSString *str in [_dicFunction allValues]) {
            ind = [ind stringByAppendingString:str];
            if (![[[_dicFunction allValues] lastObject] isEqualToString:str]) {
                ind = [ind stringByAppendingString:@","];
            }
            
        }
        self.labelFunction.text = ind;
    }
    else
    {
        self.labelFunction.text = @"请选择所属行业";
    }
}


#pragma mark -按钮监听事件
-(void)backAction{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)commitClick:(id)sender
{
    if([self.tfEmail.text length]<1||[self.tfWechat.text length]<1||[self.tfMobile.text length]<1||[_dicFunction count]<1||[_dicIndustry count]<1||[self.tfDesc.text length]<1||!cityID||[self.tfDesc2.text length]<1|| [self.tfFunctionKeyword.text length]<1||[self.tfCompanyName.text length]<1||[self.tfCompanyName.text length]<1||[self.tfWorkYear.text length]<1||[self.tfIndustryExperience.text length]<1)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = @"请完善带*号的信息";
        [hud hide:YES afterDelay:1.5f];
        return;
    }
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    [dic setObject:[NSData AES256Encrypt:self.tfEmail.text key:TOKEN] forKey:@"Email"];
    [dic setObject:[NSData AES256Encrypt:self.tfWechat.text key:TOKEN] forKey:@"Wechat"];
    [dic setObject:[NSData AES256Encrypt:self.tfMobile.text key:TOKEN] forKey:@"Mobile"];
    [dic setObject:[NSData AES256Encrypt:self.tfDesc.text key:TOKEN] forKey:@"ServiceDesc"];
    [dic setObject:[NSData AES256Encrypt:self.tfDesc2.text key:TOKEN] forKey:@"PersonalCase"];
    
    [dic setObject:[NSData AES256Encrypt:self.tfFunctionKeyword.text key:TOKEN] forKey:@"FunctionKeyword"];
    [dic setObject:[NSData AES256Encrypt:self.tfCompanyName.text key:TOKEN] forKey:@"CompanyName"];
    [dic setObject:[NSData AES256Encrypt:self.tfDutyName.text key:TOKEN] forKey:@"DutyName"];
    [dic setObject:[NSData AES256Encrypt:self.tfWorkYear.text key:TOKEN] forKey:@"WorkYear"];
    [dic setObject:[NSData AES256Encrypt:self.tfIndustryExperience.text key:TOKEN] forKey:@"IndustryExperience"];
    
    if ([self.tfQQ.text length]>1) {
        [dic setObject:[NSData AES256Encrypt:self.tfQQ.text key:TOKEN] forKey:@"QQ"];
    }
    if ([self.tfOther.text length]>1) {
        [dic setObject:[NSData AES256Encrypt:self.tfOther.text key:TOKEN] forKey:@"Other"];
    }
    
    NSString *ind = @"";
    for (NSString *str in [_dicIndustry allKeys]) {
        ind = [ind stringByAppendingString:str];
        if (![[[_dicIndustry allKeys] lastObject] isEqualToString:str]) {
            ind = [ind stringByAppendingString:@","];
        }
    }
    [dic setObject:[NSData AES256Encrypt:ind key:TOKEN] forKey:@"Industry"];
    
    NSString *fun = @"";
    for (NSString *str in [_dicFunction allKeys]) {
        fun = [fun stringByAppendingString:str];
        if (![[[_dicFunction allKeys] lastObject] isEqualToString:str]) {
            fun = [fun stringByAppendingString:@","];
        }
        
    }
    [dic setObject:[NSData AES256Encrypt:fun key:TOKEN] forKey:@"Function"];
    
    [dic setObject:[NSData AES256Encrypt:cityID key:TOKEN] forKey:@"LocationID"];
    
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [ChinaValueInterface KspServiceEditParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
        hud.mode = MBProgressHUDModeText;
        if ([dic[@"Result"] isEqualToString:@"True"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        hud.labelText = dic[@"Msg"];
        [hud hide:YES afterDelay:1.5f];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load data is failure");
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = error.domain;
        [hud hide:YES afterDelay:1.5f];
    }];

    
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
//        if (indexPath.row==1) {
//            ServerMethodController *vc = [[ServerMethodController alloc]init];
//            vc.dicServiceType = self.dicServiceType;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
        if (indexPath.row==1) {
            SelectViewController *vc = [[SelectViewController alloc]init];
            vc.dic = _dicIndustry;
            vc.type = 1;
            vc.mun = 5;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==2) {
            SelectViewController *vc = [[SelectViewController alloc]init];
            vc.dic = _dicFunction;
            vc.type = 2;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"cityid"]) {
        if (!cityDic) {
            cityDic = [[NSMutableDictionary alloc]init];
        }
        CityViewController *vc = segue.destinationViewController;
        vc.cityDic = cityDic;
    }
    
}

@end
