//
//  FirestViewController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/21.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FirstViewDelegate<NSObject>
-(void)pushChildView;

-(void)addDockToHomeController;

-(void)recovreDockToUserCenter;

-(void)userCenterNeedToRomoveDock;

-(void)removeDockForHunter;
@end

@interface FirestViewController : UIViewController
@property(nonatomic,strong)id<FirstViewDelegate> delegate;

-(void)pushViewContrllerWithHunter;
@end
