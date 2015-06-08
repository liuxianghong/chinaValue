//
//  CostDetailCell.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/4.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *transformDate;
@property (weak, nonatomic) IBOutlet UILabel *writeDate;
@property (weak, nonatomic) IBOutlet UILabel *transformType;

//交易金额
@property (weak, nonatomic) IBOutlet UILabel *transformCount;

@end
