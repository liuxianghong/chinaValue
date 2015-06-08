//
//  ServerManagerController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/22.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ServerManagerDelegate <NSObject>
-(void)recoverDockAgain;
@end

@interface ServerManagerController : UITableViewController
@property(nonatomic,strong)id<ServerManagerDelegate> delegate;


@end
