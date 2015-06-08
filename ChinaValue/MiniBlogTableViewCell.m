//
//  MiniBlogTableViewCell.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/7.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "MiniBlogTableViewCell.h"

@implementation MiniBlogTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView sendSubviewToBack:self.backView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
