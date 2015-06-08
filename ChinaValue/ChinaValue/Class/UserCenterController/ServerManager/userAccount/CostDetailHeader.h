//
//  CostDetailHeader.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/4.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostDetailHeader : UITableViewHeaderFooterView


-(void)initTextWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *date;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,assign)BOOL isOpen;//用来判断分组是展开还是关闭

@end
