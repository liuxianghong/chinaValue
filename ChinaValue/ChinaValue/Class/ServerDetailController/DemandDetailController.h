//
//  DemandDetailController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetReqDetailModel.h"
#import "ReqListModel.h"

@interface DemandDetailController : UITableViewController

@property(nonatomic,strong)NSString *PublisherID;
@property(nonatomic,strong)NSString *reqID;
@end
