//
//  BiddingApplyTableViewController.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/3.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "BiddingApplyTableViewController.h"
#import "CityViewController.h"
#import "UIBarButtonItem+ZX.h"

@interface BiddingApplyTableViewController ()<UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet UILabel *adrress;
@property (nonatomic,weak) IBOutlet UITextField *tf1;
@property (nonatomic,weak) IBOutlet UITextField *tf2;
@property (nonatomic,weak) IBOutlet UITextView *tv;
@property (nonatomic,weak) IBOutlet UILabel *uilabel;
@end

@implementation BiddingApplyTableViewController
{
    NSMutableDictionary *cityDic;
    
    UIPickerView *pick;
    NSArray *pickArray;
    
    NSString *cityID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //添加UIbarButtionItem
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
    
    self.title = @"竞标申请";
    
    self.tf1.tintColor = [UIColor whiteColor];
    
    self.uilabel.text = @"请输入竞标理由";
    self.uilabel.enabled = NO;//lable必须设置为不可用
    self.uilabel.backgroundColor = [UIColor clearColor];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneChoice)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    self.tv.inputAccessoryView = topView;
    
    
    UIToolbar * topView2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    topView2.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton2 = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneChoice2)];
    NSArray * buttonsArray2 = [NSArray arrayWithObjects:btnSpace2,doneButton2,nil];
    [topView2 setItems:buttonsArray2];
    self.tf1.inputAccessoryView = topView2;
    pick = [[UIPickerView alloc]init];
    self.tf1.inputView = pick;
    pick.delegate = self;
    pickArray = [NSArray arrayWithObjects:@"0.5",@"1.0",@"1.5",@"2.0",@"2.5",@"3.0", nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (cityDic) {
        if ([cityDic objectForKey:@"chenshi"]) {
            self.adrress.text = [cityDic objectForKey:@"chenshi"][@"Name"];
            cityID = [cityDic objectForKey:@"chenshi"][@"ID"];
        }
        else if ([cityDic objectForKey:@"shenfen"]) {
            self.adrress.text = [cityDic objectForKey:@"shenfen"][@"Name"];
            cityID = [cityDic objectForKey:@"shenfen"][@"ID"];
        }
        else if ([cityDic objectForKey:@"guojia"]) {
            self.adrress.text = [cityDic objectForKey:@"guojia"][@"Name"];
            cityID = [cityDic objectForKey:@"guojia"][@"ID"];
        }
    }
}

-(void)doneChoice
{
    [self.tv resignFirstResponder];
    
}

-(void)doneChoice2
{
    NSInteger row = [pick selectedRowInComponent:0];
    self.tf1.text = [NSString stringWithFormat:@"%@小时",[pickArray objectAtIndex:row]];
    [self.tf1 resignFirstResponder];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.uilabel.text = @"请输入竞标理由";
    }else{
        self.uilabel.text = @"";
    }
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
    [self.tv resignFirstResponder];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    if ([self.tf1.text length]<1||[self.tf2.text length]<1||[self.tv.text length]<1||!cityID) {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"请完善信息";
        [HUD hide:YES afterDelay:1.5f];
        return;
    }
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:self.rID key:TOKEN] forKey:@"ReqID"];
    [dic setObject:[NSData AES256Encrypt:self.tv.text key:TOKEN] forKey:@"Reason"];
    [dic setObject:[NSData AES256Encrypt:self.tf1.text key:TOKEN] forKey:@"Duration"];
    [dic setObject:[NSData AES256Encrypt:self.tf2.text key:TOKEN] forKey:@"Price"];
    [dic setObject:[NSData AES256Encrypt:cityID key:TOKEN] forKey:@"LocationID"];
    [ChinaValueInterface knowKspApplyParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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



// returns width of column and height of row for each component.
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
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
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0); // attributed title is favored if both methods are implemented
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

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
