//
//  MiniBlogTableViewCell.h
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/7.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiniBlogTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView *imageHead;
@property (nonatomic,weak) IBOutlet UIImageView *imageContent;
@property (nonatomic,weak) IBOutlet UILabel *labelTitle;
@property (nonatomic,weak) IBOutlet UILabel *labelAddTime;
@property (nonatomic,weak) IBOutlet UILabel *labelContent;

@property (nonatomic,weak) IBOutlet UIView *backView;
@end
