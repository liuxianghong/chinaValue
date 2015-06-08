//
//  OtherServerDetailController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KspReqDetailModel.h"
#import "GetReqDetailModel.h"
#import "KspApplyCancelModel.h"

@interface OtherServerDetailController : UITableViewController

@property(nonatomic,strong)KspReqDetailModel *kspReqDetailModel;

@property(nonatomic,strong)GetReqDetailModel *getReqDetailModel;

@property(nonatomic,strong)KspApplyCancelModel *kspApplyCancelModel;
@property (nonatomic,strong) NSString *rID;
@end
