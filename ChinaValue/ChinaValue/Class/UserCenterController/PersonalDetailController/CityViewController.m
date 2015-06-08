//
//  CityViewController.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/2.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "CityViewController.h"
#import "UIBarButtonItem+ZX.h"

@interface CityViewController ()<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>
@property (nonatomic,weak) IBOutlet UIPickerView *pickView;
@property (nonatomic,weak) IBOutlet UIToolbar *toolBar;

@property (nonatomic,weak) IBOutlet UIButton *guojiaBtn;
@property (nonatomic,weak) IBOutlet UIButton *shenfBtn;
@property (nonatomic,weak) IBOutlet UIButton *chenshiBtn;
@end

@implementation CityViewController
{
    NSMutableArray *guojiaDic;
    NSMutableArray *shenfDic;
    NSMutableArray *chenshiDic;
    
    NSInteger index;
    
    NSDictionary *guojiaCurrent;
    NSDictionary *shenfCurrent;
    NSDictionary *chenshiCurrent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    self.title = @"地区选择";
    //UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction)];                                   //initWithText:@"确定" target:self action:@selector(rightButtonAction)];
    //self.navigationItem.rightBarButtonItem=rightButtonItem;
    guojiaDic = [[NSMutableArray alloc]init];
    shenfDic = [[NSMutableArray alloc]init];
    chenshiDic = [[NSMutableArray alloc]init];
    [self doneClick:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction{
    if (guojiaCurrent) {
        [self.cityDic setObject:guojiaCurrent forKey:@"guojia"];
    }
    if (shenfCurrent) {
        [self.cityDic setObject:shenfCurrent forKey:@"shenfen"];
    }
    if (chenshiCurrent) {
        [self.cityDic setObject:chenshiCurrent forKey:@"chenshi"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)guojiaClick:(id)sender
{
    [self doneClick:nil];
    index = 0;
    
    if ([guojiaDic count]==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        [ChinaValueInterface BasicGetLocationListParameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *dataArray=[responseObject objectForKey:@"ChinaValue"];
            [guojiaDic addObjectsFromArray:dataArray];
            if ([guojiaDic count]>0)
                [self showPic];
            [hud hide:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [hud hide:YES];
        }];
    }
    else
    {
        [self showPic];
    }
}


-(IBAction)shengfClick:(id)sender
{
    if (!guojiaCurrent||![guojiaCurrent[@"Name"] isEqualToString:@"中国"]) {
        return;
    }
    [self doneClick:nil];
    index =1;
    if ([shenfDic count]==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        //加到dic中
        [dic setObject:[NSData AES256Encrypt:guojiaCurrent[@"ID"] key:TOKEN] forKey:@"ID"];
        [ChinaValueInterface BasicGetLocationListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *dataArray=[responseObject objectForKey:@"ChinaValue"];
            [shenfDic addObjectsFromArray:dataArray];
            if ([shenfDic count]>0) {
                [self showPic];
            }
            [hud hide:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [hud hide:YES];
        }];
    }
    else
    {
        [self showPic];
    }
}

-(IBAction)chenshiClick:(id)sender
{
    if (!shenfCurrent||![guojiaCurrent[@"Name"] isEqualToString:@"中国"]) {
        return;
    }
    [self doneClick:nil];
    index =2;
    
    //if ([chenshiDic count]==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        //加到dic中
        [dic setObject:[NSData AES256Encrypt:shenfCurrent[@"ID"] key:TOKEN] forKey:@"ID"];
        [ChinaValueInterface BasicGetLocationListParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *dataArray=[responseObject objectForKey:@"ChinaValue"];
            chenshiDic = [dataArray mutableCopy];
            if ([chenshiDic count]>0)
                [self showPic];
            [hud hide:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [hud hide:YES];
        }];
    }
//    else
//    {
//        [self showPic];
//    }
}

-(IBAction)doneClick:(id)sender
{
    if (sender) {
        NSInteger row = [self.pickView selectedRowInComponent:0];
        switch (index) {
            case 0:
                if([guojiaCurrent isEqualToDictionary:[guojiaDic objectAtIndex:row]])
                    break;
                guojiaCurrent = [guojiaDic objectAtIndex:row];
                [self.guojiaBtn setTitle:[guojiaDic objectAtIndex:row][@"Name"] forState:UIControlStateNormal];
                [self.shenfBtn setTitle:@"省份" forState:UIControlStateNormal];
                [self.chenshiBtn setTitle:@"城市" forState:UIControlStateNormal];
                shenfCurrent = nil;
                chenshiCurrent = nil;
                break;
            case 1:
                if([shenfCurrent isEqualToDictionary:[shenfDic objectAtIndex:row]])
                    break;
                shenfCurrent = [shenfDic objectAtIndex:row];
                [self.shenfBtn setTitle:[shenfDic objectAtIndex:row][@"Name"] forState:UIControlStateNormal];
                [self.chenshiBtn setTitle:@"城市" forState:UIControlStateNormal];
                chenshiCurrent = nil;
                break;
            case 2:
                if([chenshiCurrent isEqualToDictionary:[chenshiDic objectAtIndex:row]])
                    break;
                chenshiCurrent = [chenshiDic objectAtIndex:row];
                [self.chenshiBtn setTitle:[chenshiDic objectAtIndex:row][@"Name"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
    self.pickView.hidden = YES;
    self.toolBar.hidden = YES;
    
}

-(void)showPic
{
    [self.pickView reloadAllComponents];
    self.pickView.hidden = NO;
    self.toolBar.hidden = NO;
}

#pragma mark - uipickview

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (index) {
        case 0:
            return [guojiaDic count];
            break;
        case 1:
            return [shenfDic count];
            break;
        case 2:
            return [chenshiDic count];
            break;
        default:
            break;
    }
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (index) {
        case 0:
            return [guojiaDic objectAtIndex:row][@"Name"];
            break;
        case 1:
            return [shenfDic objectAtIndex:row][@"Name"];
            break;
        case 2:
            return [chenshiDic objectAtIndex:row][@"Name"];
            break;
        default:
            break;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

}
//NSInteger row = [self.pickView selectedRowInComponent:0];

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
