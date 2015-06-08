//
//  DemandManagerController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DemandManagerDelagate <NSObject>
@optional
-(void)demandManagerNeedToAddDock;
@end

@interface DemandManagerController : UITableViewController
@property(nonatomic,strong)id<DemandManagerDelagate>delegate;

@end
