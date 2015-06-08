//
//  ServerOrderTableViewController.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/6.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ServerOrderTableViewController.h"
#import "UIBarButtonItem+ZX.h"

@interface ServerOrderTableViewController ()

@end

@implementation ServerOrderTableViewController
{
    UIPickerView *pick;
    NSArray *pickArray;
    
    UIDatePicker *pickDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commit)];
    //把多余的表格行隐藏掉
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    }
    
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    self.title = @"填写服务订单";
    
    self.tf1.tintColor = [UIColor whiteColor];
    self.tf2.tintColor = [UIColor whiteColor];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneChoice)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    pickDate = [[UIDatePicker alloc]init];
    [pickDate setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
     [pickDate setDatePickerMode:UIDatePickerModeDate];
    self.tf1.inputView = pickDate;
    self.tf1.inputAccessoryView = topView;
    
    
    UIToolbar * topView2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    topView2.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton2 = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneChoice2)];
    NSArray * buttonsArray2 = [NSArray arrayWithObjects:btnSpace2,doneButton2,nil];
    [topView2 setItems:buttonsArray2];
    self.tf2.inputAccessoryView = topView2;
    pick = [[UIPickerView alloc]init];
    self.tf2.inputView = pick;
    pick.delegate = self;
    pickArray = [NSArray arrayWithObjects:@"0.5",@"1.0",@"1.5",@"2.0",@"2.5",@"3.0", nil];
}

-(void)doneChoice
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy年MM月dd日"];
    NSString *destDateString = [dateFormatter stringFromDate:pickDate.date];
    self.tf1.text = destDateString;
    [self.tf1 resignFirstResponder];
}

-(void)doneChoice2
{
    NSInteger row = [pick selectedRowInComponent:0];
    self.tf2.text = [NSString stringWithFormat:@"%@小时",[pickArray objectAtIndex:row]];
    [self.tf2 resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commit
{
    [self.tf1 resignFirstResponder];
    [self.tf2 resignFirstResponder];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    if ([self.tf1.text length]<1||[self.tf2.text length]<1) {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"请完善信息";
        [HUD hide:YES afterDelay:1.5f];
        return;
    }
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:self.reid key:TOKEN] forKey:@"ReqID"];
    [dic setObject:[NSData AES256Encrypt:self.tf1.text key:TOKEN] forKey:@"DateTime"];
    [dic setObject:[NSData AES256Encrypt:self.tf2.text key:TOKEN] forKey:@"Duration"];
    [ChinaValueInterface KnowKsbOrderEditParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject[@"ChinaValue"] firstObject];
        HUD.mode = MBProgressHUDModeText;
        HUD.detailsLabelText = dic[@"Msg"];
        if ([dic[@"Result"] isEqualToString:@"True"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [HUD hide:YES afterDelay:1.5f];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = error.domain;
        [HUD hide:YES afterDelay:1.5f];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@小时",[pickArray objectAtIndex:row]];
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
