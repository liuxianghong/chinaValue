//
//  ServerMethodController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/28.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ServerMethodControllerDelegate <NSObject>

-(void)deliverThisSelectMethodWith:(NSArray *)array;

@end

@interface ServerMethodController : UITableViewController

@property(nonatomic,strong)id <ServerMethodControllerDelegate> delegate;
@property (nonatomic,strong) NSDictionary *dicServiceType;

@end
