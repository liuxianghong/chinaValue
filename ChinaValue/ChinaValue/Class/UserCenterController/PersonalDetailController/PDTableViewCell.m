//
//  PDTableViewCell.m
//  ChinaValue
//
//  Created by 刘向宏 on 15/6/2.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "PDTableViewCell.h"

@implementation PDTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = self.imageView.height/2;
    self.imageView.layer.borderWidth = 0;
    self.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imageView.layer.masksToBounds = YES;
}
@end
