//
//  UserCenterController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/22.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserCenterDelegate <NSObject>

-(void)deliverThisTitleWith:(NSString *)str;

@optional
-(void)addDockAgain;

@end

@interface UserCenterController : UITableViewController

@property(nonatomic,strong)id<UserCenterDelegate> delegate;

//执行婆婆操作
-(void)popViewControllerToFirstViewController;
@end
