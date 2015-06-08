//
//  MyServerViewController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/29.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyserverViewDelegate<NSObject>
-(void)myServerViewControllerNeedtoRemoveDock;

-(void)myServerViewControllerNeedToRecoverDock;
@end
@interface MyServerViewController : UITableViewController
@property(nonatomic,strong)id<MyserverViewDelegate> delegate;

@end
