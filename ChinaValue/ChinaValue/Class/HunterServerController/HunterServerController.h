//
//  HunterServerController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HunterServerDelegate <NSObject>

-(void)HunterNeedHomeHelpToRemoveDock;

@end

@interface HunterServerController : UIViewController

@property(nonatomic,strong)NSMutableArray *kspList;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)id<HunterServerDelegate> delegate;

@end
