//
//  UserDataDetail.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/13.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//查看用户资料详情页面

#import <UIKit/UIKit.h>
#import "GetReqDetailModel.h"
@protocol UserDataDetailDelegate<NSObject>
-(void)MyserverViewControllerNeedToAddDock;
@end
@interface UserDataDetail : UIViewController

@property(nonatomic,strong)GetReqDetailModel *reqDetaiModel;

@property(nonatomic,strong)id<UserDataDetailDelegate> delegate;

@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *userName;
-(void)reloadTableData;
@end
