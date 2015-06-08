//
//  ServerDetailCell.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/3.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ServerDetailCell.h"

@implementation ServerDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.point.layer.cornerRadius = self.point.height/2;
    self.point.layer.borderWidth = 0;
    self.point.layer.borderColor = [[UIColor grayColor] CGColor];
    self.point.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
