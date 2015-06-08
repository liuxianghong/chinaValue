//
//  CerdificateAddTableViewController.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "CerdificateAddTableViewController.h"
#import "UIImageView+WebCache.h"

@interface CerdificateAddTableViewController ()
@property (nonatomic,weak) IBOutlet UITextField *tfName;
@property (nonatomic,weak) IBOutlet UITextField *tfData;
@property (nonatomic,weak) IBOutlet UITextField *tfDec;
@property (nonatomic,weak) IBOutlet UIImageView *cerdImageView;
@end

@implementation CerdificateAddTableViewController
{
    UIDatePicker *pickDate;
    long year;
    long month;
    UIImage *image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tfData.tintColor = [UIColor whiteColor];
    
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
    self.tfData.inputView = pickDate;
    self.tfData.inputAccessoryView = topView;
    
    
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    CGRect tableViewFooterRect = self.tableView.tableFooterView.frame;
    tableViewFooterRect.size.height = 78.0f;
    [self.tableView.tableFooterView setFrame:tableViewFooterRect];
    
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"forget_04.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    self.title = @"证书编辑";
    
    UITapGestureRecognizer *panRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseApproveImage:)];
    [self.cerdImageView addGestureRecognizer:panRecognizer];//关键语句，给self.view添加一个手势监测；
    
    
    if(self.kspHonorModel)
    {
        self.tfName.text = self.kspHonorModel.Name;
        self.tfData.text = [NSString stringWithFormat:@"%@年%@月",self.kspHonorModel.Year,self.kspHonorModel.Month];
        self.tfDec.text = self.kspHonorModel.Desc;
        [self.cerdImageView sd_setImageWithURL:[NSURL URLWithString:self.kspHonorModel.CardUrl]];
        year = [self.kspHonorModel.Year longLongValue];
        month = [self.kspHonorModel.Month longLongValue];
    }
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightClick
{
    if ([self.tfName.text length]<1||[self.tfDec.text length]<1||[self.tfData.text length]<1||!self.cerdImageView.image)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请完善信息";
        [hud hide:YES afterDelay:1.5f];
        return;
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:[UserModel sharedManager].userID key:TOKEN] forKey:@"UID"];
    if (self.kspHonorModel) {
        [dic setObject:[NSData AES256Encrypt:self.kspHonorModel.ID key:TOKEN] forKey:@"HonorID"];
    }
    else
    {
        ;
    }
        
    [dic setObject:[NSData AES256Encrypt:self.tfName.text key:TOKEN] forKey:@"Name"];
    [dic setObject:[NSData AES256Encrypt:self.tfDec.text key:TOKEN] forKey:@"Desc"];
    [dic setObject:[NSData AES256Encrypt:[NSString stringWithFormat:@"%ld",year] key:TOKEN] forKey:@"Year"];
    [dic setObject:[NSData AES256Encrypt:[NSString stringWithFormat:@"%ld",month] key:TOKEN] forKey:@"Month"];
    
    if (image)
    {
        NSString *str = [UIImageJPEGRepresentation(image, 0.8) base64EncodedStringWithOptions:0];
        [dic setObject:str forKey:@"Card"];
    }
    else
    {
        NSString *str = [UIImageJPEGRepresentation(self.cerdImageView.image, 0.8) base64EncodedStringWithOptions:0];
        [dic setObject:str forKey:@"Card"];
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [ChinaValueInterface KspHonorEditParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

-(void)doneChoice
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy年MM月"];
    NSString *destDateString = [dateFormatter stringFromDate:pickDate.date];
    self.tfData.text = destDateString;
    [self.tfData resignFirstResponder];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:pickDate.date];
    year=[comps year];//获取年对应的长整形字符串
    month=[comps month];//获取月对应的长整形字符串
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseApproveImage:(id)sender {
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
    }
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                return;
        }
    }
    else {
        if (buttonIndex == 1) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    //    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    //    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image2=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.cerdImageView setImage:image2];
    image = image2;
    [picker dismissViewControllerAnimated:YES completion:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
