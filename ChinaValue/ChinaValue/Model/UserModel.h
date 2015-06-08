//
//  UserModel.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicUserInformation.h"
#import "BalanceModel.h"

@interface UserModel : NSObject
+(instancetype)sharedManager;
@property(nonatomic,strong)NSString *userID;
@property(nonatomic,strong)BasicUserInformation *basicUserInformation;

@property(nonatomic,strong)BalanceModel *balanceModel;


@end
