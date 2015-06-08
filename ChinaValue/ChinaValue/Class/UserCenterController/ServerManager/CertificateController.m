//
//  CertificateControllerTableViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/25.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "CertificateController.h"
#import "UIBarButtonItem+ZX.h"
#import "CertificateInformationController.h"
#import "UIImageView+WebCache.h"
#import "CertificateCell.h"
#import "CerdificateAddTableViewController.h"
#import "HNBrowseImageViewController.h"

@interface CertificateController (){
    CertificateInformationController *_certificateInformationController;
}
@property(nonatomic,strong)IBOutlet UITableViewCell *customCell;

@end

@implementation CertificateController
{
    BOOL needUpdate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"我的荣誉/资质/证书"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
//    if (_certificateInformationController==nil) {
//        _certificateInformationController=[[CertificateInformationController alloc]init];
//    }
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = rightBar;
   //去掉表格多疑的空格行
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //让表格的分割线到表格的最左端显示
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(-10,0, 0, 0);
    }

    self.honorList = [[NSMutableArray alloc]init];
    
    needUpdate = YES;
 
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (needUpdate) {
        [self loadHonorList:NO];
        needUpdate = NO;
    }
}

#pragma mark -加载荣誉证书
-(void)loadHonorList:(BOOL)showHud{
    //首先要清空Honorlist
    [self.honorList removeAllObjects];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *userID=[UserModel sharedManager].userID;
    NSString *enUID=[NSData AES256Encrypt:userID key:TOKEN];
    [dic setObject:enUID forKey:@"UID"];
    [ChinaValueInterface KspHonorListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_honorList removeAllObjects];
        NSArray *dicArray=[[ExplainText alloc]explainManyDataWith:responseObject];
        for (NSDictionary *dic in dicArray) {
            KspHonorListModel *kspHonorModel=[[KspHonorListModel alloc]initWithDic:dic];
            [_honorList addObject:kspHonorModel];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load Honordata is failure");
        
    }];
}
#pragma mark barbuttonItem按钮监听
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.honorList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *myCell=[NSString stringWithFormat:@"myCell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CertificateCell" owner:self options:nil];
    CertificateCell *celll = nil;
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        celll = cell = self.customCell;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
        
    }
    KspHonorListModel *kspHonorModel=self.honorList[indexPath.row];
    UILabel *name=celll.titleText;
    name.text=kspHonorModel.Name;
    
    UILabel *date=celll.Date;
    NSString *year=kspHonorModel.Year;
    NSString *month=kspHonorModel.Month;
    NSString *yearAndMonth=[NSString stringWithFormat:@"%@年%@月",year,month];
    date.text=yearAndMonth;
    
    
    UILabel *desc=celll.describleText;
    desc.text=kspHonorModel.Desc;
    
    
    UIImageView *imageView1=celll.CertificateImage1;
    [imageView1 setImageWithURL:[NSURL URLWithString:kspHonorModel.CardUrl] placeholderImage:nil];
    
    UITapGestureRecognizer *panRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseApproveImage:)];
    imageView1.userInteractionEnabled = YES;
    [imageView1 addGestureRecognizer:panRecognizer];//关键语句，给self.view添加一个手势监测；
//    UIImageView *imageView2=(UIImageView *)[cell.contentView viewWithTag:6];
//    [imageView2 setImageWithURL:[NSURL URLWithString:kspHonorModel.CardUrl] placeholderImage:nil];
    //修改信息7
    UIButton *changeButton=celll.changeImButton;
    changeButton.tag=indexPath.row;
    [changeButton addTarget:self action:@selector(changeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //删除
    UIButton *delete=celll.deleteImButton;
    delete.tag=indexPath.row;
    [delete addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)chooseApproveImage:(UITapGestureRecognizer*)panRecognizer
{
    UIView *view = panRecognizer.view;
    if ([view isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = view;
        [self showPic:imageView.image];
    }
}

- (void)showPic:(UIImage *)sender{
    HNBrowseImageViewController *vc = [[HNBrowseImageViewController alloc] init];
    vc.image = sender;
    [self presentViewController:vc animated:NO completion:^{
        
    }];
}
#pragma mark 按钮监听
-(void)rightClick
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CerdificateAddTableViewController* vc = (CerdificateAddTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CerdificateAdd"];
    //来到资料修改页面
    [self.navigationController pushViewController:vc animated:YES];
    needUpdate = YES;
}

-(void)changeButtonClick:(UIButton *)button{
    //推出信息修改页面
    KspHonorListModel *kspHonorModel=self.honorList[button.tag];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    CerdificateAddTableViewController* vc = (CerdificateAddTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CerdificateAdd"];
    vc.kspHonorModel = kspHonorModel;
    //来到资料修改页面
    [self.navigationController pushViewController:vc animated:YES];
    needUpdate = YES;
}

-(void)deleteButton:(UIButton *)button{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    KspHonorListModel *kspHonorModel=self.honorList[button.tag];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *userID=[UserModel sharedManager].userID;
    NSString *enUID=[NSData AES256Encrypt:userID key:TOKEN];
    [dic setObject:enUID forKey:@"UID"];
    [dic setObject:[NSData AES256Encrypt:kspHonorModel.ID key:TOKEN] forKey:@"HonorID"];
    [ChinaValueInterface KspHonorDeleteParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dicData = [responseObject[@"ChinaValue"] firstObject];
        if ([dicData[@"Result"] isEqualToString:@"True"]) {
            [self.honorList removeObject:kspHonorModel];
            [self.tableView reloadData];
        }
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = dicData[@"Msg"];
        [hud hide:YES afterDelay:1.5f];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = error.domain;
        [hud hide:YES afterDelay:1.5f];
    }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  self.customCell.frame.size.height;
}
@end
