//
//  CheckServerPageController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/10.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetReqDetailModel.h"
#import "KspApplyViewModel.h"

@interface CheckServerPageController : UITableViewController

@property(nonatomic,strong)GetReqDetailModel *getReqDetailModel;
@property(nonatomic,strong)KspApplyViewModel *kspApplyViewMpdel;
@property (nonatomic,strong) NSString *ReqID;
@property (nonatomic,strong) NSString *uID;
@end
