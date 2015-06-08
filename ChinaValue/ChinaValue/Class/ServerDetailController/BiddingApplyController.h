//
//  BiddingApplyController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KspApplyViewModel.h"
@interface BiddingApplyController : UITableViewController

@property(nonatomic,strong)KspApplyViewModel *kspApplyViewModel;
@property(nonatomic,strong)NSString *rID;
@end
