//
//  UpdateInformationController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/11.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KspServiceEditModel.h"
@protocol UpdateInformationControllerDelegate<NSObject>

-(void)deliverThisdataToMySerVerDetail:(KspServiceEditModel *)kspServerEditMode;
@end
@interface UpdateInformationController : UITableViewController
@property(nonatomic,strong)id<UpdateInformationControllerDelegate> delegate;
@end
