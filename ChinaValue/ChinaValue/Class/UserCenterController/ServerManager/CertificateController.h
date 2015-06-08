//
//  CertificateControllerTableViewController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/25.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KspHonorListModel.h"

@interface CertificateController : UITableViewController

@property(nonatomic,strong)KspHonorListModel *kspHonorListModel;
@property(nonatomic,strong)NSMutableArray *honorList;

@end
