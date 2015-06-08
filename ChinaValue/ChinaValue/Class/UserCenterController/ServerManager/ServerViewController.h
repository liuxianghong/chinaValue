//
//  ServerViewController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *allList;//全部
@property(nonatomic,strong)NSMutableArray *bidList;//已投标
@property(nonatomic,strong)NSMutableArray *competiveBidList;//已竞标

@property(nonatomic,strong)UITableView *tableView;

@end
