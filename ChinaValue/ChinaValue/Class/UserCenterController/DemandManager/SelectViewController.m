//
//  SelectViewController.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/28.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
// 所属需求行业选择页面

#import "SelectViewController.h"
#import "UIBarButtonItem+ZX.h"


#define kViewX 15    //距离屏幕左边15
#define kViewY 15    //控件垂直间距

@interface SelectViewController (){
    NSArray *_buttonTextArray;//存放button的text内容
    
    NSMutableDictionary *_buttonDic;//用来保存选中之后的按钮
   
}

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if (_buttonTextArray==nil) {
        _buttonTextArray=@[@"互联网+",@"管理咨询",@"投资咨询",@"产业分析",@"经济分析",@"金融服务",@"点赞商务",@"法律咨询",@"跨境商务",@"国际合作",@"技术咨询",@"创业辅导",@"公共政策",@"社会公益",@"心理辅导",@"教育咨询",@"政策经济",@"历史哲学",@"文化宗教",@"社会学+"];
    }
    if (_buttonDic==nil) {
        _buttonDic=[[NSMutableDictionary alloc]init];
    }
    // 设置title
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [label setText:@"选项"];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=label;
    
    //添加UIbarButtionItem
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithIcon:@"forget_04.png" highLight:nil target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=barButtonItem;
    
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
                                         //initWithText:@"确定" target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    if (self.mun==0) {
        self.mun = self.type==1?1:3;
    }
    //添加基础控件
    [self addBaseView];
    
    if (self.type==1) {
        [ChinaValueInterface KnowGetIndustryListParameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //创建按钮
            _buttonTextArray = responseObject[@"ChinaValue"];
            [self createButtonWitCount:[_buttonTextArray count] locCount:3];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
        }];
    }
    else
    {
        [ChinaValueInterface KnowGetFunctionListParameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            //创建按钮
            _buttonTextArray = responseObject[@"ChinaValue"];
            [self createButtonWitCount:[_buttonTextArray count] locCount:3];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
        }];
    }
    
}

#pragma mark barButtonItem的监听事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    //先把选中的按钮的值传回到父视图，然后再pop到父视图
    //传值
    [self.delegate selectWithDic:_buttonDic];
    // pop界面
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -添加基础控件
-(void)addBaseView{
    CGFloat width=(self.view.frame.size.width-50)/3;
    CGFloat height=44;
    //label1
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(kViewX,0, width, height)];
    if (self.type==1) {
        label1.text=@"服务行业选择";
    }
    else
    {
        label1.text=@"服务类别选择";
    }
    label1.textColor=[UIColor grayColor];
    label1.font=[UIFont systemFontOfSize:13.0f];
    [self.view addSubview:label1];
    
    //label2
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(width*2+kViewX*4, 0, width, height)];
    label2.text=[NSString stringWithFormat:@"最多选择%ld个",self.mun] ;
    label2.textColor=[UIColor grayColor];
    label2.font=[UIFont systemFontOfSize:13.0f];
    [self.view addSubview:label2];
    
    
    
}

#pragma mark 根据总数创建3列多行的按钮数
-(void)createButtonWitCount:(NSInteger)count locCount:(NSInteger)totalloc{
    CGFloat width=(self.view.frame.size.width-50)/3;
    CGFloat height=44;
    //count是要创建的button的数量，locCount是所要创建的多少列，width是button的宽，height是button的高
   // UIView *view=[[UIView alloc]init];
  //  view.frame=CGRectMake(kViewX, kViewY, self.view.frame.size.width, self.view.frame.size.height-89);
    CGFloat margin=(self.view.frame.size.width-totalloc*width)/(totalloc+1);
    for (int i=0; i<count; i++) {
        int row=i/totalloc;//行号 //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        CGFloat appviewx=15+(margin+width)*loc;
        CGFloat appviewy=50+(margin+height)*row;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame= CGRectMake(appviewx, appviewy, width, 40);
        button.tag=i;
        [button setBackgroundImage:[UIImage imageNamed:@"serverselect_01.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"serverselect_02.png"] forState:UIControlStateSelected];
        [button setBackgroundImage:nil forState:UIControlStateHighlighted];
        [button setTitle:_buttonTextArray[i][@"Name"] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if([[self.dic allKeys] containsObject:_buttonTextArray[i][@"ID"]])
        {
            button.selected = YES;
        }
        [self.view addSubview:button];
    }
   // [self.view addSubview:view];
}
#pragma mark button按钮的监听
-(void)buttonClick:(UIButton *)button{
    NSLog(@"button's tag is:%ld",(long)button.tag);
    //NSString *key=button.titleLabel.text;
    NSDictionary *dic = [_buttonTextArray objectAtIndex:button.tag];
    if (button.selected==NO) {
        if (self.dic.count<(self.mun)) {
            button.selected=YES;
            //把选中的按钮放到_buttonDic中去
            [self.dic setObject:dic[@"Name"] forKey:dic[@"ID"]];
        }
        
    }else{
        button.selected=NO;
        //把取消选中的按钮从_buttonDic中删除
        [self.dic removeObjectForKey:dic[@"ID"]];
    }
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
