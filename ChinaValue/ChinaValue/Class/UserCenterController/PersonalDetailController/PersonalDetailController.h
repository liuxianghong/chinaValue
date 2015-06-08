//
//  PersonalDetailController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
@protocol PersonalDetailDelegate<NSObject>
-(void)personnalDetailNeedToAddDock;
@end

@interface PersonalDetailController : UITableViewController

@property(nonatomic,strong)id<PersonalDetailDelegate> delegate;

@end
