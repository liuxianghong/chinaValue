//
//  UserAccountController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserAccountDelegate<NSObject>
-(void)userAccountNeedToAddDock;
@end

@interface UserAccountController : UITableViewController

@property(nonatomic,strong)id<UserAccountDelegate> delegate;

//-(void)reloadTableData;


@end
