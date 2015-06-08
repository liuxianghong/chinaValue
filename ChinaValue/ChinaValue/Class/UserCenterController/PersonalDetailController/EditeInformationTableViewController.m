//
//  EditeInformationTableViewController.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/2.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "EditeInformationTableViewController.h"
#import "UIBarButtonItem+ZX.h"
#import "UIImageView+WebCache.h"
#import "CityViewController.h"

@interface EditeInformationTableViewController ()
@property (nonatomic,weak) IBOutlet UIImageView *imageView;
@property (nonatomic,weak) IBOutlet UITextField *worktf;
@property (nonatomic,weak) IBOutlet UITextField *jobtf;
@property (nonatomic,weak) IBOutlet UILabel *adressLabel;
@property (nonatomic,weak) IBOutlet UITextView *textView;
@property (nonatomic,weak) IBOutlet UIButton *commitButton;

@property (nonatomic,weak) IBOutlet UIButton *sexMan;
@property (nonatomic,weak) IBOutlet UIButton *sexWomen;
@end

@implementation EditeInformationTableViewController
{
    NSMutableDictionary *cityDic;
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
    
//    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction)];                                   //initWithText:@"确定" target:self action:@selector(rightButtonAction)];
//    self.navigationItem.rightBarButtonItem=rightButtonItem;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:[UserModel sharedManager].basicUserInformation.Avatar] placeholderImage:[UIImage imageNamed:@"credit_05.png"]];
    self.imageView.layer.cornerRadius = 20;
    self.imageView.layer.borderWidth = 0;
    self.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imageView.layer.masksToBounds = YES;
    if ([[UserModel sharedManager].basicUserInformation.Sex isEqualToString:@"男"]) {
        self.sexMan.selected = YES;
        self.sexWomen.selected = NO;
    }
    else
    {
        self.sexMan.selected = NO;
        self.sexWomen.selected = YES;
    }
    self.worktf.text = [UserModel sharedManager].basicUserInformation.CompanyName;
    self.jobtf.text = [UserModel sharedManager].basicUserInformation.DutyName;
    self.adressLabel.text = [UserModel sharedManager].basicUserInformation.City;
    self.textView.text = [UserModel sharedManager].basicUserInformation.About;
    
    CGRect tableViewFooterRect = self.tableView.tableFooterView.frame;
    tableViewFooterRect.size.height = 78.0f;
    [self.tableView.tableFooterView setFrame:tableViewFooterRect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (cityDic) {
        if ([cityDic objectForKey:@"chenshi"]) {
            self.adressLabel.text = [cityDic objectForKey:@"chenshi"][@"Name"];
        }
        else if ([cityDic objectForKey:@"shenfen"]) {
            self.adressLabel.text = [cityDic objectForKey:@"shenfen"][@"Name"];
        }
        else if ([cityDic objectForKey:@"guojia"]) {
            self.adressLabel.text = [cityDic objectForKey:@"guojia"][@"Name"];
        }
    }
}

-(IBAction)commitClick:(id)sender
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    //加到dic中
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    NSString *sex = @"男";
    if (self.sexWomen.selected) {
        sex = @"女";
    }
    [dic setObject:[NSData AES256Encrypt:sex key:TOKEN] forKey:@"Sex"];
    [dic setObject:[NSData AES256Encrypt:self.worktf.text key:TOKEN] forKey:@"CompanyName"];
    [dic setObject:[NSData AES256Encrypt:self.jobtf.text key:TOKEN] forKey:@"DutyName"];
    [dic setObject:[NSData AES256Encrypt:self.textView.text key:TOKEN] forKey:@"About"];
    
    if (cityDic) {
        if ([cityDic objectForKey:@"chenshi"]) {
            [dic setObject:[NSData AES256Encrypt:[cityDic objectForKey:@"chenshi"][@"ID"] key:TOKEN] forKey:@"LocationID"];
            //self.adressLabel.text = [cityDic objectForKey:@"chenshi"][@"Name"];
        }
        else if ([cityDic objectForKey:@"shenfen"]) {
            [dic setObject:[NSData AES256Encrypt:[cityDic objectForKey:@"shenfen"][@"ID"] key:TOKEN] forKey:@"LocationID"];
            //self.adressLabel.text = [cityDic objectForKey:@"shenfen"][@"Name"];
        }
        else if ([cityDic objectForKey:@"guojia"]) {
            [dic setObject:[NSData AES256Encrypt:[cityDic objectForKey:@"guojia"][@"ID"] key:TOKEN] forKey:@"LocationID"];
        }
        else
            [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].basicUserInformation.CityID key:TOKEN] forKey:@"LocationID"];
    }
    else
        [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].basicUserInformation.CityID key:TOKEN] forKey:@"LocationID"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [ChinaValueInterface UserEditBasicInfoParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject[@"ChinaValue"]firstObject][@"Result"] isEqualToString:@"True"]) {
            hud.labelText = @"设置成功";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.5f];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            hud.labelText = @"设置失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.5f];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        hud.labelText = error.domain;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5f];
    }];
}

-(IBAction)manClick:(id)sender
{
    self.sexMan.selected = YES;
    self.sexWomen.selected = NO;
}

-(IBAction)womenClick:(id)sender
{
    self.sexMan.selected = NO;
    self.sexWomen.selected = YES;
}

-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *userID=[UserModel sharedManager].userID;
    //加密
    NSString *enData=[NSData AES256Encrypt:userID key:TOKEN];
    [dic setValue:enData forKey:@"UID"];
    CGFloat max = image.size.width>image.size.height?image.size.width:image.size.height;
    CGFloat dec = 1;
    if (max>160) {
        dec = max/160;
    }
    UIImage *newImage = [ExplainText imageWithImageSimple:image scaledToSize:CGSizeMake(160,160)];
    NSString *str = [UIImageJPEGRepresentation(newImage, 0.8) base64EncodedStringWithOptions:0];
    [dic setValue:str forKey:@"Image"];
    [ChinaValueInterface UserChangeAvatarParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ;
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [ExplainText explainDataWith:responseObject];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = dic[@"Msg"];
        [hud hide:YES afterDelay:1.5];
        NSString *url = dic[@"Avatar"];
        if ([url length]>0) {
            [UserModel sharedManager].basicUserInformation.Avatar = url;
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        hud.mode = MBProgressHUDModeText;
        hud.labelText = error.domain;
        [hud hide:YES afterDelay:1.5];
    }];
    NSLog(@"%@",image);
}
//
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
