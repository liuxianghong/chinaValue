//
//  EvaluateController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//    评价页面

#import <UIKit/UIKit.h>
#import "GetReqDetailModel.h"
#import "CreditEditModel.h"
@protocol EvaluateControllerDelegate <NSObject>

-(void)deliverDataToOtherServerDetailController:(CreditEditModel  *)credit;

@end


@interface EvaluateController : UIViewController
-(void)reloadDataWith:(GetReqDetailModel *)getReqdetailModel;
@property(nonatomic,strong)GetReqDetailModel *getReqDetailModel;

@property(nonatomic,strong)id<EvaluateControllerDelegate> delegate;



@end
