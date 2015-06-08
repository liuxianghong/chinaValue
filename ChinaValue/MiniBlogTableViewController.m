//
//  MiniBlogTableViewController.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/7.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "MiniBlogTableViewController.h"
#import "UIBarButtonItem+ZX.h"
#import "MJRefresh.h"
#import "MiniBlogTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+ZX.h"

@interface MiniBlogTableViewController ()

@end

@implementation MiniBlogTableViewController
{
    NSMutableArray *tableArray;
    NSInteger pageIndex;
    
    NSMutableDictionary *imageDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    self.title = [NSString stringWithFormat:@"%@的日志",self.uName];
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    tableArray = [[NSMutableArray alloc]init];
    pageIndex = 1;
    __weak typeof(self) weakSelf = self;
    
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.legendHeader beginRefreshing];
    
    imageDic = [[NSMutableDictionary alloc]init];
}

-(void)loadMoreData
{
    if ([tableArray count]<pageIndex*8) {
        [self.tableView.footer endRefreshing];
        return;
    }
    pageIndex ++;
    [self loadData];
}

-(void)loadNewData
{
    pageIndex = 1;
    [self loadData];
}

-(void)loadData
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSData AES256Encrypt:self.uid key:TOKEN] forKey:@"UID"];
    NSString *pagesize=[NSString stringWithFormat:@"%ld",8];
    NSString *pageindex=[NSString stringWithFormat:@"%ld",pageIndex];
    NSString *enPageSize=[NSData AES256Encrypt:pagesize key:TOKEN];
    NSString *enpageIndex=[NSData AES256Encrypt:pageindex key:TOKEN];
    [dic setObject:enPageSize forKey:@"PageSize"];
    [dic setObject:enpageIndex forKey:@"PageIndex"];
    
    [ChinaValueInterface GetUserMiniBlogParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (pageIndex==1) {
            [tableArray removeAllObjects];
        }
        NSArray *array = responseObject[@"ChinaValue"];//dicData
        [tableArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MiniBlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mini" forIndexPath:indexPath];
    NSDictionary *dic = tableArray[indexPath.row];
    [cell.imageHead sd_setImageWithURL:[NSURL URLWithString:dic[@"Avatar"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if ((cacheType == SDImageCacheTypeNone)&&!error) {
//            [self.tableView reloadData];
//        }
    }];
    [cell.imageContent sd_setImageWithURL:[NSURL URLWithString:dic[@"ImgUrl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        ;
    }];
    cell.labelTitle.text = dic[@"UserName"];
    cell.labelAddTime.text = dic[@"AddTime"];
    cell.labelContent.text = dic[@"Content"];
//    cell.label1.text = dic[@"Title"];
//    cell.label2.text = dic[@"Summary"];
//    cell.label3.text = dic[@"AddTime"];
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MiniBlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mini"];
    NSDictionary *dic = tableArray[indexPath.row];
    cell.translatesAutoresizingMaskIntoConstraints = NO;
    cell.labelContent.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *str = dic[@"Content"];
    cell.labelContent.text = dic[@"Content"];
    //74 16 25 50
    CGSize size = [str calculateSize:CGSizeMake(self.view.width-66-8-16, FLT_MAX) font:cell.labelContent.font];
    CGFloat imageHeght = 0;
    if ([dic[@"ImgUrl"] length]>1) {
        imageHeght = 83;
    }
    return size.height +16+66+16+imageHeght;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}


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
