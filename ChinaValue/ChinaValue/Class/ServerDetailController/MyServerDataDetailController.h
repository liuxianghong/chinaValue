//
//  MyServerDataDetailController;.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/15.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeContactModel.h"
#import "KspServiceGetModel.h"
@interface MyServerDataDetailController : UITableViewController

@property(nonatomic,strong)GeContactModel *getContactModel;
@property(nonatomic,strong)KspServiceGetModel *kspServerGerModel;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic) NSInteger type;
@end
